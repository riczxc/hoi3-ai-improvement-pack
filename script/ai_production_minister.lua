-----------------------------------------------------------
-- production
-----------------------------------------------------------

require('ai_trade')
require('helper_functions')
require('production_division_templates')
require('production_restrictions')
require('production_province_improvements')

function ProductionMinister_Tick(minister)
	local ministerCountry = minister:GetCountry()
	if not IsValidCountry(ministerCountry) then
		return
	end

	local AvailIC = ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_PRODUCTION_ ):Get() - ministerCountry:GetUsedIC():Get()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local capitalProvId =  ministerCountry:GetActingCapitalLocation():GetProvinceID()
	local StartIC = AvailIC
	local TotalIC = ministerCountry:GetTotalIC()

	--Utils.LUA_DEBUGOUT( tostring(minister:GetCountryTag()) )

	-- we need convoys at all?
	AvailIC = ConstructConvoys(ai, minister, ministerTag, ministerCountry, AvailIC )

	if AvailIC <= 0 then
		return 0
	end

	local ratioProvince = GetICRatioForProvinceImprovements(ministerCountry) * 100
	local provinceIdPool = nil
	local dice = nil
	local provinceIndex = {}
	local nothingBuiltCounter = 0

	while (AvailIC > 0) and (nothingBuiltCounter < 10) do
		local availICInThisIteration = AvailIC

		if math.mod(CCurrentGameState.GetAIRand(), 100) >= ratioProvince then

			-- ai list of requests, in prio order
			local bShouldBuildReserve = not (ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar())
			local requestQueue = ai:GetReqProdQueue()
			local nothingBuiltByTacticalAI = true
			if not requestQueue:IsEmpty() then
				----------------------------------- Random for Tail or Head Data
				local ranNumber = math.mod( CCurrentGameState.GetAIRand(), 2)+1
				local unit = 1
				if ranNumber == 1 then
					unit = requestQueue:GetTailData().pUnit
				else
					unit = requestQueue:GetHeadData().pUnit
				end

				local bBuildReserve = bShouldBuildReserve
				if not unit:IsRegiment() then
					--Utils.LUA_DEBUGOUT( 'NO RESERVE' )
					bBuildReserve = false
				end
				-----------------------------------
				local cost = ministerCountry:GetBuildCostIC( unit, 1, bBuildReserve ):Get()
				-- only build sensible stuff
				if cost < TotalIC then
					local orderlist = SubUnitList()
					local unitName = tostring(unit:GetKey())

					if unit:IsRegiment() then
						--Utils.LUA_DEBUGOUT( "Brigade unit")
						orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unitName)
					elseif unit:IsShip() then
						--Utils.LUA_DEBUGOUT( "Naval unit")
						orderlist, AvailIC = BuildNavalAndAir(minister, ministerCountry, false, orderlist, AvailIC, unitName)
					elseif unitName == "cag" or unitName == "cas" or unitName == "flying_bomb"
					or unitName == "flying_rocket" or unitName == "interceptor" or unitName == "multi_role"
					or unitName == "naval_bomber" or unitName == "rocket_interceptor" or unitName == "strategic_bomber"
					or unitName == "tactical_bomber" or unitName == "transport_plane" then
						--Utils.LUA_DEBUGOUT( "Air Unit")
						orderlist, AvailIC = BuildNavalAndAir(minister, ministerCountry, false, orderlist, AvailIC, unitName)
					else
						AvailIC = AvailIC - cost
						SubUnitList.Append( orderlist, unit )
					end

					if orderlist:GetSize() > 0 then
						local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bBuildReserve, CNullTag(), CID() )
						ai:Post( construct )
						nothingBuiltByTacticalAI = false
					end
				end
				-----------------------------------
				if ranNumber == 1 then
					requestQueue:RemoveTail()
				else
					requestQueue:RemoveHead()
				end
				-----------------------------------

			end

			if nothingBuiltByTacticalAI then

				-- any requests by strategic ai
				for subunit in CSubUnitDataBase.GetSubUnitList() do
					local bBuildReserve = bShouldBuildReserve
					if not subunit:IsRegiment() then
						--Utils.LUA_DEBUGOUT( 'NO RESERVE' )
						bBuildReserve = false
					end
					local count = ministerCountry:GetStrategy():GetWantedSubUnits(subunit)
					local cost = ministerCountry:GetBuildCostIC( subunit, 1, bBuildReserve ):Get()
					if count > 0.0 and cost < TotalIC then
						local orderlist = SubUnitList()
						SubUnitList.Append( orderlist, subunit )
						AvailIC = AvailIC - cost
						local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, count, bBuildReserve, CNullTag(), CID() )
						ai:Post( construct )
						-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built (S) " .. tostring(subunit:GetKey()))
					end
				end

				-- got AvailIC left not built something yet?
				if AvailIC > 0 then
					-- always fill out with more infantry if AvailIC and manpower is left
					if ministerCountry:GetOfficerRatio():Get() > 0.75
						and ministerCountry:GetManpower():Get() > TotalIC
					then
						local orderlist = SubUnitList()
						local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")
						local militia = CSubUnitDataBase.GetSubUnit("militia_brigade")

						if ministerCountry:GetTechnologyStatus():IsUnitAvailable(infantry) then
							-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built inf div with... ")
							local unitName = "infantry_brigade"
							orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bShouldBuildReserve, orderlist, AvailIC, unitName)
						else
							local unitName = "militia_brigade"
							orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bShouldBuildReserve, orderlist, AvailIC, unitName)
							--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built mil ")
						end

						--Utils.LUA_DEBUGOUT( "build a division." )
						local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bShouldBuildReserve, CNullTag(), CID() )
						ai:Post( construct )
					end
				end

			end

		else

			if provinceIdPool == nil then
				-- Load country specific province improvements
				local improvements = LoadProvinceImprovements(ministerCountry)

				-- Create a list of provinces where each improvement type can be built
				-- and create a dice we use later to decide what improvement type to build.
				provinceIdPool, dice = CreateProvinceIdPoolAndDice(ministerCountry, improvements)
			end

			if table.getn(dice) > 0 then
				-- If this is the first round we know two things:
				--	- We can build at least one improvement, otherwise the dice would be empty.
				--	- All provinces in the province pool are valid locations for an improvement.
				-- If this is not the first round, we have to make sure, that we're not
				-- building in provinces we've already touched.

				-- Let's roll the dice to decide which improvement to build
				local diceIndex = math.mod(CCurrentGameState.GetAIRand(), table.getn(dice))
				local improvementType = dice[diceIndex]
				local building = CBuildingDataBase.GetBuilding(improvementType)

				local multiplier = 1
				if improvementType == 'infra' then
					-- Infra is very cheap to build in comparison to the rest. (1/5)
					-- Build more infra in one round so ICs are equally spent.
					multiplier = math.min(5, math.ceil(TotalIC / 10))
				end

				if provinceIndex[improvementType] == nil then
					provinceIndex[improvementType] = 0
				end

				for j = 1, multiplier do
					provinceIndex[improvementType] = provinceIndex[improvementType] + 1

					if provinceIndex[improvementType] <= table.getn(provinceIdPool[improvementType]) then
						local provinceId = provinceIdPool[improvementType][provinceIndex[improvementType]]
						local constructCommand = CConstructBuildingCommand(ministerTag, building, provinceId, 1)
						if constructCommand:IsValid() then
							ai:Post(constructCommand)
							AvailIC = AvailIC - ministerCountry:GetBuildCost(building):Get()
						end
					end
				end
			else
				-- Dice is empty. Since the creation of the province pool is random
				-- we could reinitialize the pool and hope to find some provinces
				-- where we actually could build something, but because this operation
				-- is very expensive we leave it be with those province improvements
				-- and build some units.
				-- Shouldn't happen too often...
				ratioProvince = 0
			end

		end

		if availICInThisIteration == AvailIC then
			nothingBuiltCounter = nothingBuiltCounter + 1
		end
	end

	-- Return remaining IC to use
	if AvailIC > 0 then
		local changes = CArrayFix(5)
		changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint( ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_PRODUCTION_ ):Get() - AvailIC ) )
		changes:SetAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_, CFixedPoint(ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_REINFORCEMENT_ ):Get() ) )
		changes:SetAt( CDistributionSetting._PRODUCTION_UPGRADE_, CFixedPoint( ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_UPGRADE_ ):Get() ) )

		-- if there is dissent move all possible left IC into money
		if ministerCountry:GetDissent():Get() > 0.01 or ministerCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get() > 99000 then
			changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get() + AvailIC) )
			changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint(ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_SUPPLY_ ):Get() ) )
		-- otherwise make supplies
		else
			changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get() ) )
			changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint(ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_SUPPLY_ ):Get() + AvailIC ) )
		end
		ai:Post( CChangeInvestmentCommand( ministerCountry:GetCountryTag(), changes ) )
	end
end

function CreateProvinceIdPoolAndDice(ministerCountry, improvements)
	-- Create a list of provinces where each improvement can be built
	local ids = {}
	local building = {}
	for k,v in pairs(improvements) do
		ids[k] = {}
		building[k] = CBuildingDataBase.GetBuilding(k)
	end

	-- Since the decision for a location of a few improvements depends on other
	-- improvements, make sure we cycle them in the right order.
	local capitalContinent = ministerCountry:GetActingCapitalLocation():GetContinent()

	local provinceFilter = {
		{
			'infra',
			function (province, provinceHasBuilding)
				return 	province:GetMaxInfrastructure():Get() > 0.3
			end
		},
		{
			'industry',
			function (province, provinceHasBuilding)
				return not province:IsFrontProvince(false) and
							province:GetInfrastructure():Get() > 0.3 and
							capitalContinent == province:GetContinent()
			end
		},
		{
			'air_base',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['air_base']
			end
		},
		{
			'naval_base',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['naval_base']
			end
		},
		{
			'radar_station',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['radar_station'] or
							provinceHasBuilding['air_base'] or
							provinceHasBuilding['naval_base'] or
							province:IsFrontProvince(false)
			end
		},
		{
			'land_fort',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['land_fort'] or
							province:IsFrontProvince(false)
			end
		},
		{
			'coastal_fort',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['coastal_fort'] or
							provinceHasBuilding['naval_base']
			end
		},
		{
			'anti_air',
			function (province, provinceHasBuilding)
				return 	provinceHasBuilding['anti_air'] or
							provinceHasBuilding['industry'] or
							provinceHasBuilding['air_base'] or
							provinceHasBuilding['naval_base'] or
							provinceHasBuilding['radar_station'] or
							provinceHasBuilding['land_fort'] or
							provinceHasBuilding['coastal_fort']
			end
		}
	}

	for provinceId in ministerCountry:GetOwnedProvinces() do
		local province = CCurrentGameState.GetProvince(provinceId)

		local provinceHasBuilding = {}
		for index,tuple in ipairs(provinceFilter) do
			local k = tuple[1]
			local filter = tuple[2]

			if province:HasBuilding(building[k]) then
				provinceHasBuilding[k] = true
			end

			if filter(province, provinceHasBuilding) then
				table.insert(ids[k], provinceId)
			end

		end
	end

	-- Create a province pool for each improvement type
	local prioSum = 0
	local provinceIdPool = {}

	for k,v in pairs(improvements) do
		provinceIdPool[k] = {}

		if v.priority > 0 then
			-- Select province source
			local source = ids[k]
			if v.ids then
				source = v.ids
			end

			-- Randomly select up to 50 provinces
			for i = 1, math.min(50, table.getn(source)) do
				local index = math.mod(CCurrentGameState.GetAIRand(), table.getn(source)) + 1
				local province = CCurrentGameState.GetProvince(source[index])

				if ministerCountry:IsBuildingAllowed(building[k], province) and v.buildCallback(province) then
					table.insert(provinceIdPool[k], source[index])
				end
			end

			if table.getn(provinceIdPool[k]) == 0 then
				v.priority = 0
			end

			prioSum = prioSum + v.priority
		end
	end

	-- Rebalance and create a dice
	local dice = {}

	if prioSum > 0 then
		local lastSideCount = 0
		for k,v in pairs(improvements) do
			if improvements[k].priority > 0 then
				improvements[k].priority = improvements[k].priority / prioSum

				local sideCount = math.ceil(math.max(improvements[k].priority * 100, 1))
				for i = lastSideCount, lastSideCount + sideCount - 1 do
					dice[i] = k
				end
				lastSideCount = lastSideCount + sideCount
			end
		end
	end

	return provinceIdPool, dice
end

-- local PRIO_SETTINGS = {
	-- [0] = { -- full ai automation
		-- [0] = CDistributionSetting._PRODUCTION_CONSUMER_,
		-- CDistributionSetting._PRODUCTION_SUPPLY_,
		-- CDistributionSetting._PRODUCTION_REINFORCEMENT_,
		-- CDistributionSetting._PRODUCTION_PRODUCTION_,
		-- CDistributionSetting._PRODUCTION_UPGRADE_
	-- },
	-- [1] = {  -- prio production
		-- [0] = CDistributionSetting._PRODUCTION_CONSUMER_,
		-- CDistributionSetting._PRODUCTION_SUPPLY_,
		-- CDistributionSetting._PRODUCTION_PRODUCTION_,
		-- CDistributionSetting._PRODUCTION_REINFORCEMENT_,
		-- CDistributionSetting._PRODUCTION_UPGRADE_
	-- },
	-- [2] = {   -- prio upgrades
		-- [0] = CDistributionSetting._PRODUCTION_CONSUMER_,
		-- CDistributionSetting._PRODUCTION_SUPPLY_,
		-- CDistributionSetting._PRODUCTION_UPGRADE_,
		-- CDistributionSetting._PRODUCTION_REINFORCEMENT_,
		-- CDistributionSetting._PRODUCTION_PRODUCTION_
	-- },
	-- [3] = {   -- prio reinforcement
		-- [0] = CDistributionSetting._PRODUCTION_CONSUMER_,
		-- CDistributionSetting._PRODUCTION_SUPPLY_,
		-- CDistributionSetting._PRODUCTION_REINFORCEMENT_,
		-- CDistributionSetting._PRODUCTION_PRODUCTION_,
		-- CDistributionSetting._PRODUCTION_UPGRADE_
	-- },
-- }

function BuildImprovement(ai, AvailIC, ministerTag, improvement, improvementCost, provinceId)
	--Utils.LUA_DEBUGOUT("A")
	local constructCommand = CConstructBuildingCommand( ministerTag, improvement, provinceId, 1 )
	--Utils.LUA_DEBUGOUT("B")
	if constructCommand:IsValid() then
		--Utils.LUA_DEBUGOUT("C")
		ai:Post( constructCommand )
		--Utils.LUA_DEBUGOUT("D")
		AvailIC = AvailIC-improvementCost
		--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built " .. tostring(improvement) .. " for " .. tostring(improvementCost).."$ at "..tostring(provinceId))
		--Utils.LUA_DEBUGOUT("E")
	end
	--Utils.LUA_DEBUGOUT("F")
	return AvailIC
end

function BalanceProductionSliders(ai, ministerCountry, prioSelection)
	--Utils.LUA_DEBUGOUT("BalanceProductionSliders - " .. tostring(ministerCountry:GetCountryTag()) )
	-- if tostring(ministerCountry:GetCountryTag())=='GER' then
		-- Utils.LUA_DEBUGOUT( " BalanceProductionSliders ")
	-- end
	--local ministerCountry = minister:GetCountry()
	--local TotalIC = ministerCountry:GetTotalIC()

	local changes = CArrayFix(5)
	local dissent = ministerCountry:GetDissent():Get()
	local AvailIC = ministerCountry:GetTotalIC()
	local MaxIC = ministerCountry:GetTotalIC()

	-- CONSUMER
	local ConsumerNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get() --/ TotalIC

	-- MONEY
	local MoneyStockFactor = ministerCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/ministerCountry:GetTotalIC()

	-- SUPPLY
	local SupplyStockFactor = ministerCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get()/math.min(45000, ai_configuration.MINIMUM_SUPPLY_STOCKPILE*ministerCountry:GetTotalIC())
	-- 100% supply prod. at 0 stock, 50% at 1/2 goal stock and 0% at goal stock
	local SupplyNeed = MaxIC*(1-math.min(1, SupplyStockFactor ))

	-- REINFORCEMENT
	local ReinforcementNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_ ):GetNeeded():Get() --/ TotalIC

	-- PRODUCTION
	local ProductionNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_PRODUCTION_ ):GetNeeded():Get() --/ TotalIC

	-- UPGRADE
	local UpgradeNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_UPGRADE_ ):GetNeeded():Get() --/ TotalIC
	-- Utils.LUA_DEBUGOUT("UpgradeNeed " .. UpgradeNeed )

	-- Distribute IC --

	-- consumer need (to prevent new dissent) + boost for dissent or low money stock but never more than 90% of IC
	ConsumerNeed = ConsumerNeed + MaxIC * math.min(math.max(dissent/10, 1-MoneyStockFactor), 0.9)

	-- not more than AvailIC
	ConsumerNeed = math.min(AvailIC, ConsumerNeed)
	changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( ConsumerNeed ) )

	AvailIC = AvailIC - ConsumerNeed
	-- Supply (max AvailIC)
	SupplyNeed = math.min(SupplyNeed, AvailIC )
	changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint( SupplyNeed ) )
	AvailIC = AvailIC - SupplyNeed

	-- prod
	if 1==prioSelection then
		ProductionNeed = math.min(ProductionNeed, AvailIC)
		changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint( ProductionNeed ) )
		AvailIC = AvailIC - ProductionNeed

		ReinforcementNeed = math.min(ReinforcementNeed, AvailIC )
		changes:SetAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_, CFixedPoint( ReinforcementNeed ) )
		AvailIC = AvailIC - ReinforcementNeed

		UpgradeNeed = math.min(UpgradeNeed, AvailIC )
		changes:SetAt( CDistributionSetting._PRODUCTION_UPGRADE_, CFixedPoint( UpgradeNeed ) )
		AvailIC = AvailIC - UpgradeNeed
	-- upgrades
	elseif 2==prioSelection then
		UpgradeNeed = math.min(UpgradeNeed, AvailIC )
		changes:SetAt( CDistributionSetting._PRODUCTION_UPGRADE_, CFixedPoint( UpgradeNeed ) )
		AvailIC = AvailIC - UpgradeNeed

		ReinforcementNeed = math.min(ReinforcementNeed, AvailIC )
		changes:SetAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_, CFixedPoint( ReinforcementNeed ) )
		AvailIC = AvailIC - ReinforcementNeed

		ProductionNeed = math.min(ProductionNeed, AvailIC)
		changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint( ProductionNeed ) )
		AvailIC = AvailIC - ProductionNeed
	else
		-- Reinforcement (max AvailIC)
		ReinforcementNeed = math.min(ReinforcementNeed, AvailIC )
		changes:SetAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_, CFixedPoint( ReinforcementNeed ) )
		AvailIC = AvailIC - ReinforcementNeed

		-- distribute same percentage of IC needed to upgrade and production
		local equalizer = math.min(1, AvailIC/(ProductionNeed+UpgradeNeed))
		ProductionNeed = equalizer * ProductionNeed
		changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint( ProductionNeed ) )
		AvailIC = AvailIC - ProductionNeed

		UpgradeNeed = equalizer*UpgradeNeed
		changes:SetAt( CDistributionSetting._PRODUCTION_UPGRADE_, CFixedPoint( UpgradeNeed ) )
		AvailIC = AvailIC - UpgradeNeed
	end

	if AvailIC > 0.01 then
		-- AI
		if 0 == prioSelection and AvailIC > 0.02 then
			changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint(changes:GetAt( CDistributionSetting._PRODUCTION_PRODUCTION_ ):Get() + 0.02 ) )
		-- human player
			AvailIC = AvailIC - 0.02
		end
		--else
			-- if there is dissent move all possible left IC into money
			if dissent > 0.01 or ministerCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get() > 99000 then
				changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( changes:GetAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()+AvailIC ) )
			-- otherwise make supplies
			else
				-- if AI put 1/3 into money to allow more trades globaly
				-- if 0 == prioSelection and MoneyStockpile < 100*ministerCountry:GetTotalIC() then
					-- changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( changes:GetAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()+AvailIC/3 ) )
					-- changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint( changes:GetAt( CDistributionSetting._PRODUCTION_SUPPLY_ ):Get()+2*AvailIC/3 ) )
				-- else
					changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint( changes:GetAt( CDistributionSetting._PRODUCTION_SUPPLY_ ):Get()+AvailIC ) )
				-- end
			end
		--end
	end

	ai:Post( CChangeInvestmentCommand( ministerCountry:GetCountryTag(), changes ) )
end


-- for debugging
--local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
	--Utils.LUA_DEBUGOUT( "ENTER Build division function")
	--Utils.LUA_DEBUGOUT( "Start Load production function")
	-- Load country's division templates
	local prod_ratio = LoadProductionRatio(minister, ministerCountry)

	local i = 1
	local j = 1
	local pourcent = 100
	local template_number = 0
	local rem = math.mod( CCurrentGameState.GetAIRand(), 100)

	-- Determine which template AI will builds
	while prod_ratio[unit_name][i] and template_number == 0 do
		pourcent = pourcent - prod_ratio[unit_name][i][1]
		--Utils.LUA_DEBUGOUT(prod_ratio[unit_name][i][1])
		if rem >= pourcent then
			--Utils.LUA_DEBUGOUT( "Find")
			template_number = i
			j = 2
			-- Check every brigades in the template, if they are available
			while prod_ratio[unit_name][template_number][j] do
				if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_ratio[unit_name][template_number][j]) == false then
					--Utils.LUA_DEBUGOUT( "Not available")
					template_number = 1		-- If not, build the first template
				end
				j = j + 1
			end
		end
		i = i + 1
	end
	if template_number ~= 0 then
		j = 2
		-- Start to build all brigades of the template
		while prod_ratio[unit_name][template_number][j] do
			if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_ratio[unit_name][template_number][j]) then
				SubUnitList.Append( orderlist, prod_ratio[unit_name][template_number][j] )
				AvailIC = AvailIC - ministerCountry:GetBuildCostIC( prod_ratio[unit_name][template_number][j], 1, bBuildReserve ):Get()
			end
			j = j + 1
		end
	end

	--Utils.LUA_DEBUGOUT( "EXIT Build division function")
	return orderlist, AvailIC
end

function BuildNavalAndAir(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
	--Utils.LUA_DEBUGOUT( "ENTER BuildNavalAndAir function")
	local prod_restrictions = {}

	-- Load country's restrictions
	prod_restrictions = LoadRestrictions(minister, ministerCountry)

	local i = 1
	local pourcent = 100
	local find = 0
	local rem = math.mod( CCurrentGameState.GetAIRand(), 100)

	while prod_restrictions[unit_name][i] and find == 0 do
		pourcent = pourcent - prod_restrictions[unit_name][i]
		--Utils.LUA_DEBUGOUT(prod_restrictions[unit_name][i])
		if rem >= pourcent then
			if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_restrictions[unit_name][i+1]) then
				--Utils.LUA_DEBUGOUT( "Find")
				find = 1
				SubUnitList.Append( orderlist, prod_restrictions[unit_name][i+1] )
				AvailIC = AvailIC - ministerCountry:GetBuildCostIC( prod_restrictions[unit_name][i+1], 1, bBuildReserve ):Get()
			end
		end
		i = i + 2
	end
	--Utils.LUA_DEBUGOUT( "EXIT BuildNavalAndAir function")
	--Utils.LUA_DEBUGOUT("\n")
	return orderlist, AvailIC
end

function ConstructConvoys(ai, minister, ministerTag, ministerCountry, AvailIC )
	if ministerCountry:GetNumOfPorts() > 0 then
		-- 10%
		local buffer = 0.1

		if ministerCountry:GetStrategy():IsPreparingWar() then
			-- add 10%
			buffer = buffer+0.1
		end

		-- running out of transporters???
		if 0==ministerCountry:GetTransports() then
			-- add 10%
			buffer = buffer+0.1
		end

		if minister:GetCountry():IsAtWar() then
			-- double it (20% or 40%)
			buffer = buffer*2
		end

		local freeTransports = (minister:CountTransportsUnderConstruction() + ministerCountry:GetTransports())/defines.economy.CONVOY_CONSTRUCTION_SIZE
		local neededTransports = ministerCountry:GetTotalNeededTransports()*buffer/defines.economy.CONVOY_CONSTRUCTION_SIZE
		if 0==ministerCountry:GetTransports() then -- no free ones, ramp up building
			neededTransports = math.max(neededTransports, ministerCountry:GetTotalIC()/10)
		else -- got some free ones build less rapid and smaller buffer
			neededTransports = math.max(neededTransports, ministerCountry:GetTotalIC()/20)
		end

		local cost = ministerCountry:GetConvoyBuildCost():Get()
		local transportCommand = CConstructConvoyCommand( ministerTag, false, 1 )

		while neededTransports > freeTransports do
			AvailIC = AvailIC - cost
			ai:Post( transportCommand )
			freeTransports = freeTransports+1
		end

		-- if at war, we could use protection
		if minister:GetCountry():IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() then
			-- 10% before war
			local buffer = 0.1
			if minister:GetCountry():IsAtWar() then
				-- 20% for war
				buffer = 0.2
				-- 30% if we run out of escorts
				if 0==ministerCountry:GetEscorts() then
					buffer = 0.3
				end
			end
			local freeEscorts = (minister:CountEscortsUnderConstruction() + ministerCountry:GetEscorts())/defines.economy.CONVOY_CONSTRUCTION_SIZE
			local neededEscorts = math.max(minister:CountTotalDesiredEscorts()*buffer/defines.economy.CONVOY_CONSTRUCTION_SIZE, 1)
			local cost = ministerCountry:GetEscortBuildCost():Get()
			local escortCommand = CConstructConvoyCommand( ministerTag, true, 1 )
			while neededEscorts > freeEscorts do
					ai:Post( escortCommand )
					AvailIC = AvailIC - cost
					freeEscorts = freeEscorts + 1
			end
		end
	end
	return math.max(AvailIC, 0)
end
