-----------------------------------------------------------
-- production
-----------------------------------------------------------

require('helper_functions')
require('production_division_templates')
require('production_restrictions')
require('production_province_improvements')

local unitNames = {
	naval = {
		[0] = 'battlecruiser',
		'battleship',
		'carrier',
		'destroyer',
		'escort_carrier',
		'heavy_cruiser',
		'light_cruiser',
		'nuclear_submarine',
		'submarine',
		'super_heavy_battleship',
		'transport_ship'
	},
	land = {
		[0] = 'armor_brigade',
		'bergsjaeger_brigade',
		'cavalry_brigade',
		'garrison_brigade',
		'infantry_brigade',
		'light_armor_brigade',
		'marine_brigade',
		'mechanized_brigade',
		'militia_brigade',
		'motorized_brigade',
		'paratrooper_brigade'
	},
	air = {
		[0] = 'cag',
		'cas',
		'flying_bomb',
		'flying_rocket',
		'interceptor',
		'multi_role',
		'naval_bomber',
		'rocket_interceptor',
		'strategic_bomber',
		'tactical_bomber',
		'transport_plane'
	}
}

--Use our wrapper method in order to trap and log our errors
function ProductionMinister_Tick(minister)
	dtools.setLogContext(minister,"PROD")
	return dtools.wrap(ProductionMinister_Tick_Impl,minister)
end

function ProductionMinister_Tick_Impl(minister)
	local ministerCountry = minister:GetCountry()
	if not IsValidCountry(ministerCountry) or ministerCountry:IsGovernmentInExile() then
		return
	end

	local availIC = ministerCountry:GetICPart(CDistributionSetting._PRODUCTION_PRODUCTION_):Get() - ministerCountry:GetUsedIC():Get()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local capitalProvId =  ministerCountry:GetActingCapitalLocation():GetProvinceID()
	local TotalIC = ministerCountry:GetTotalIC()

	-- we need convoys at all?
	availIC = ConstructConvoys(ai, minister, ministerTag, ministerCountry, availIC)

	-- Don't build anything on day one. AI needs some time to know what it wants to build.
	if gDayCount <= 0 then
		return
	end

	if math.mod(CCurrentGameState.GetAIRand(), 7) == 0 then
		minister:PrioritizeBuildQueue()
	end

	if availIC <= 0 then
		return
	end

	local ratioProvince = GetICRatioForProvinceImprovements(ministerCountry) * 100
	local provinceIdPool = nil
	local dice = {}
	local provinceIndex = {}
	local nothingBuiltCounter = 0

	local bBuildReserveAtPeace = not (ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar())
	local requestQueue = ai:GetReqProdQueue()
	local doBuildUnit = false
	local gotManPower = HasExtraManpowerLeft(ministerCountry)

	Utils.LUA_DEBUGOUT("-------------------Production AI - " .. tostring(ministerTag) .. " -----------------------")
	Utils.LUA_DEBUGOUT("gotManPower: " .. tostring(gotManPower))
	Utils.LUA_DEBUGOUT("Ratio province: " .. tostring(ratioProvince) .. "%")
	-- Utils.LUA_DEBUGOUT("Units filterted out:")
	
	dtools.debug("Request Queue: ")
	-- Filter request queue
	queue = {}
	for request in ai:GetReqProdQueueIter() do
		local unit = request.pUnit
		
		-- DEBUG output
		local key = tostring(unit:GetKey())
		if not queue[key] then
			queue[key] = 0
		end
		queue[key] = queue[key] + 1

		if not unit:IsRegiment() or gotManPower then
			doBuildUnit = true
		else
			requestQueue:Remove(request)
		end
	end
	dtools.debug(queue)

	if not doBuildUnit then
		-- Only build province improvements
		-- ratioProvince = 100
		-- Utils.LUA_DEBUGOUT("No unit to build. Changing ratio province to 100%.")
	end

	while (availIC > 0) and (nothingBuiltCounter < 10) do
		local availICInThisIteration = availIC

		if ratioProvince == 0 and not doBuildUnit then
			-- Seems we can't build anything
			break
		end

		if requestQueue:IsEmpty() then
			doBuildUnit = false
			ratioProvince = math.max(ratioProvince, 10 * nothingBuiltCounter)
		end

		if math.mod(CCurrentGameState.GetAIRand(), 100) >= ratioProvince then
			local orderlist = SubUnitList()
			
			if not requestQueue:IsEmpty() then
				local unit = requestQueue:GetHeadData().pUnit
				local bBuildReserve = bBuildReserveAtPeace and unit:IsRegiment()
				local unitName = tostring(unit:GetKey())

				if unit:IsRegiment() then
					-- Utils.LUA_DEBUGOUT( "Brigade unit")
					orderlist, availIC = BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, availIC, unitName)
				elseif unit:IsShip() then
					-- Utils.LUA_DEBUGOUT( "Naval unit")
					orderlist, availIC = BuildNavalAndAir(minister, ministerCountry, false, orderlist, availIC, unitName)
				elseif	unitName == "cag" or unitName == "cas" or unitName == "flying_bomb" or
						unitName == "flying_rocket" or unitName == "interceptor" or unitName == "multi_role" or
						unitName == "naval_bomber" or unitName == "rocket_interceptor" or unitName == "strategic_bomber" or
						unitName == "tactical_bomber" or unitName == "transport_plane"
				then
					-- Utils.LUA_DEBUGOUT( "Air Unit")
					orderlist, availIC = BuildNavalAndAir(minister, ministerCountry, false, orderlist, availIC, unitName)
				else
					availIC = availIC - ministerCountry:GetBuildCostIC(unit, 1, bBuildReserve):Get()
					SubUnitList.Append(orderlist, unit)
				end

				local construct = CConstructUnitCommand(ministerTag, orderlist, capitalProvId, 1, bBuildReserve, CNullTag(), CID())
				ai:Post(construct)

				requestQueue:RemoveHead()
			else
				-- Force a build
				local p = {
					land = 40,
					air = ministerCountry:GetNumOfAirfields(),
					naval = ministerCountry:GetNumOfPorts()
				}
				if not gotManPower then
					p.land = 0
				end
				
				local sum = p.air + p.naval
				if sum > 0 then
					p.naval = (p.naval / sum) * (100 - p.land)
					p.air = (p.air / sum) * (100 - p.land)
				end
				sum = p.air + p.naval + p.land
				
				if sum > 0 then
					for k,v in pairs(p) do
						if math.mod(CCurrentGameState.GetAIRand(), 100) < v then
							local unitName = unitNames[k][math.mod(CCurrentGameState.GetAIRand(), table.getn(unitNames[k]))]
							dtools.debug(tostring(unitName) .. " with a chance of " .. (v) .. "%")
							if k == "land" then
								orderlist, availIC = BuildTemplateDivision(minister, ministerCountry, bBuildReserveAtPeace, orderlist, availIC, unitName)
							else
								orderlist, availIC = BuildNavalAndAir(minister, ministerCountry, false, orderlist, availIC, unitName)
							end
							break
						end
					end
					
					local construct = CConstructUnitCommand(ministerTag, orderlist, capitalProvId, 1, bBuildReserveAtPeace, CNullTag(), CID())
					ai:Post(construct)
				else
					-- Build province improvements
					doBuildUnit = false
					ratioProvince = 100
				end
			end
		else
-- Utils.LUA_DEBUGOUT("->ProductionMinister_Tick Province")
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
				local buildCost = ministerCountry:GetBuildCost(building):Get()

				local multiplier = 1
				if improvementType == 'infra' then
					-- Infra is very cheap to build in comparison to industry. (1/5)
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
							availIC = availIC - buildCost
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
				dtools.warn("Dice pool is empty. Figure out why country can't build any province improvements.", ministerCountry, "DEVEL")
			end
-- Utils.LUA_DEBUGOUT("<-ProductionMinister_Tick Province")
		end

		if availICInThisIteration == availIC then
			nothingBuiltCounter = nothingBuiltCounter + 1
		end
	end

	-- force inf or mil production for small countries
	if	availIC > 0 and gotManPower and
		((	ratioProvince == 0 and not doBuildUnit) or
			10 == nothingBuiltCounter	)
	then
		local orderlist = SubUnitList()
		local unit = CSubUnitDataBase.GetSubUnit("infantry_brigade")
		local unitName = "infantry_brigade"
		if not ministerCountry:GetTechnologyStatus():IsUnitAvailable(unit) then
			unitName = "militia_brigade"
		end
		orderlist, availIC = BuildTemplateDivision(minister, ministerCountry, bBuildReserveAtPeace, orderlist, availIC, unitName)

		local construct = CConstructUnitCommand(ministerTag, orderlist, capitalProvId, 1, bBuildReserveAtPeace, CNullTag(), CID())
		ai:Post(construct)
	end

	-- Utils.LUA_DEBUGOUT("<-ProductionMinister_Tick")
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
							province:GetInfrastructure():Get() > 0.3
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
							province:IsFrontProvince(false) or
							province:GetNumberOfUnits() >= 1
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
			-- Randomly select up to 50 provinces
			-- Select user specified provinces first (higher priority)
			local source = v.ids
			if source then
				for i = 1, math.min(50, table.getn(source)) do
					local index = math.mod(CCurrentGameState.GetAIRand(), table.getn(source)) + 1
					local province = CCurrentGameState.GetProvince(source[index])

					if ministerCountry:IsBuildingAllowed(building[k], province) and v.buildCallback(province) then
						table.insert(provinceIdPool[k], source[index])
					end
				end
			end

			-- Now select all other provinces
			source = ids[k]
			for i = table.getn(provinceIdPool[k]) + 1, math.min(50, table.getn(source)) do
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

function BalanceProductionSliders(ai, ministerCountry, prioSelection)
	if not IsValidCountry(ministerCountry) then
		return
	end

	local changes = { [0] = 0, 0, 0, 0, 0 }	
	local dissent = ministerCountry:GetDissent():Get()
	local factorLeft = 1.0
	local MaxIC = ministerCountry:GetTotalIC()

	-- CONSUMER
	local ConsumerNeed = ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_CONSUMER_):GetNeeded():Get() / MaxIC

	-- SUPPLY
	local SupplyNeed = ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_SUPPLY_):GetNeeded():Get() / MaxIC
	if not ministerCountry:isPuppet() then
		local supplyStock = ministerCountry:GetPool():Get(CGoodsPool._SUPPLIES_ ):Get()
		local supplyStockFactor = supplyStock / math.min(45000, MinStock(ministerCountry, CGoodsPool._SUPPLIES_))
		-- If below half of min stock start give it an extra boost
		local supplyBoost = math.max(0.5 - supplyStockFactor, 0)
		SupplyNeed = math.max(SupplyNeed * (1 + 0.5 * (1 - supplyStockFactor)), 0) + supplyBoost
		dtools.debug(string.format("stock: %f, factor: %f, boost: %f, need: %f", supplyStock, supplyStockFactor, supplyBoost, SupplyNeed), ministerCountry, "PROD")
	end

	-- REINFORCEMENT
	local ReinforcementNeed = ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_REINFORCEMENT_):GetNeeded():Get() / MaxIC

	-- PRODUCTION
	local ProductionNeed = ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_PRODUCTION_):GetNeeded():Get() / MaxIC

	-- UPGRADE
	local UpgradeNeed = ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_UPGRADE_):GetNeeded():Get() / MaxIC
	-- --Utils.LUA_DEBUGOUT("UpgradeNeed " .. UpgradeNeed )


	-------------------------- Distribute IC --------------------------

	-- fight dissent
	ConsumerNeed =  math.min(ConsumerNeed + dissent, factorLeft)
	changes[CDistributionSetting._PRODUCTION_CONSUMER_] = ConsumerNeed
	factorLeft = factorLeft - ConsumerNeed

	-- Supply (max factorLeft)
	SupplyNeed = math.min(SupplyNeed, factorLeft)
	changes[CDistributionSetting._PRODUCTION_SUPPLY_] = SupplyNeed
	factorLeft = factorLeft - SupplyNeed

	-- prod
	if 1==prioSelection then
		ProductionNeed = math.min(ProductionNeed, factorLeft)
		changes[CDistributionSetting._PRODUCTION_PRODUCTION_] = ProductionNeed
		factorLeft = factorLeft - ProductionNeed

		ReinforcementNeed = math.min(ReinforcementNeed, factorLeft )
		changes[CDistributionSetting._PRODUCTION_REINFORCEMENT_] = ReinforcementNeed
		factorLeft = factorLeft - ReinforcementNeed

		UpgradeNeed = math.min(UpgradeNeed, factorLeft )
		changes[CDistributionSetting._PRODUCTION_UPGRADE_] = UpgradeNeed
		factorLeft = factorLeft - UpgradeNeed

	-- upgrades
	elseif 2==prioSelection then
		UpgradeNeed = math.min(UpgradeNeed, factorLeft )
		changes[CDistributionSetting._PRODUCTION_UPGRADE_] = UpgradeNeed
		factorLeft = factorLeft - UpgradeNeed

		ReinforcementNeed = math.min(ReinforcementNeed, factorLeft )
		changes[CDistributionSetting._PRODUCTION_REINFORCEMENT_] = ReinforcementNeed
		factorLeft = factorLeft - ReinforcementNeed

		ProductionNeed = math.min(ProductionNeed, factorLeft)
		changes[CDistributionSetting._PRODUCTION_PRODUCTION_] = ProductionNeed
		factorLeft = factorLeft - ProductionNeed

	-- reinforcement
	else
		ReinforcementNeed = math.min(ReinforcementNeed, factorLeft )
		changes[CDistributionSetting._PRODUCTION_REINFORCEMENT_] = ReinforcementNeed
		factorLeft = factorLeft - ReinforcementNeed

		if factorLeft > 0 then
			-- distribute same percentage of IC needed to upgrade and production
			local equalizer = factorLeft / math.max(ProductionNeed + UpgradeNeed, factorLeft)
			ProductionNeed = equalizer * ProductionNeed
			changes[CDistributionSetting._PRODUCTION_PRODUCTION_] = ProductionNeed
			factorLeft = factorLeft - ProductionNeed

			UpgradeNeed = equalizer * UpgradeNeed
			changes[CDistributionSetting._PRODUCTION_UPGRADE_] = UpgradeNeed
			factorLeft = factorLeft - UpgradeNeed
		else
			changes[CDistributionSetting._PRODUCTION_PRODUCTION_] = 0
			changes[CDistributionSetting._PRODUCTION_UPGRADE_] = 0
		end
	end

	-- leftover IC
	if factorLeft > 0.01 then

		-- AI
		if 0 == prioSelection and factorLeft > 0.02 then
			changes[CDistributionSetting._PRODUCTION_PRODUCTION_] = changes[CDistributionSetting._PRODUCTION_PRODUCTION_] + 0.02
			factorLeft = factorLeft - 0.02
		end

		-- if there is dissent move all possible IC left into money
		if dissent > 0.01 then
			changes[CDistributionSetting._PRODUCTION_CONSUMER_] = changes[CDistributionSetting._PRODUCTION_CONSUMER_] + factorLeft
		-- otherwise make supplies
		else
			changes[CDistributionSetting._PRODUCTION_SUPPLY_] = changes[CDistributionSetting._PRODUCTION_SUPPLY_] + factorLeft
		end
	end

	local command = CChangeInvestmentCommand(ministerCountry:GetCountryTag(), changes[0], changes[1], changes[2], changes[3], changes[4])
	ai:Post(command)
end


-- for debugging
--local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, availIC, unit_name)
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
	while prod_ratio[unit_name] and prod_ratio[unit_name][i] and template_number == 0 do
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
				availIC = availIC - ministerCountry:GetBuildCostIC( prod_ratio[unit_name][template_number][j], 1, bBuildReserve ):Get()
			end
			j = j + 1
		end
	end

	--Utils.LUA_DEBUGOUT( "EXIT Build division function")
	return orderlist, availIC
end

function BuildNavalAndAir(minister, ministerCountry, bBuildReserve, orderlist, availIC, unit_name)
	--Utils.LUA_DEBUGOUT( "ENTER BuildNavalAndAir function")
	local prod_restrictions = {}

	-- Load country's restrictions
	prod_restrictions = LoadRestrictions(minister, ministerCountry)

	local i = 1
	local pourcent = 100
	local find = 0
	local rem = math.mod( CCurrentGameState.GetAIRand(), 100)

	while prod_restrictions[unit_name] and prod_restrictions[unit_name][i] and find == 0 do
		pourcent = pourcent - prod_restrictions[unit_name][i]
		--Utils.LUA_DEBUGOUT(prod_restrictions[unit_name][i])
		if rem >= pourcent then
			if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_restrictions[unit_name][i+1]) then
				--Utils.LUA_DEBUGOUT( "Find")
				find = 1
				SubUnitList.Append( orderlist, prod_restrictions[unit_name][i+1] )
				availIC = availIC - ministerCountry:GetBuildCostIC( prod_restrictions[unit_name][i+1], 1, bBuildReserve ):Get()
			end
		end
		i = i + 2
	end
	--Utils.LUA_DEBUGOUT( "EXIT BuildNavalAndAir function")
	--Utils.LUA_DEBUGOUT("\n")
	return orderlist, availIC
end

function ConstructConvoys(ai, minister, ministerTag, ministerCountry, availIC )
	--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. "->ConstructConvoys")

	if ministerCountry:GetNumOfPorts() > 0 then
		local freeTransports = minister:CountTransportsUnderConstruction() + ministerCountry:GetTransports()
		local neededTransports = math.min(ministerCountry:GetTotalIC(), 20)

		neededTransports = math.ceil((neededTransports - freeTransports) / defines.economy.CONVOY_CONSTRUCTION_SIZE)

		if neededTransports > 0 then
			local cost = ministerCountry:GetConvoyBuildCost():Get()
			local transportCommand = CConstructConvoyCommand(ministerTag, false, 1)

			for i = 1, neededTransports do
				ai:Post(transportCommand)
				availIC = availIC - cost
			end
		end

		-- if at war, we could use protection
		if ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() then
			local freeEscorts = minister:CountEscortsUnderConstruction() + ministerCountry:GetEscorts()
			local neededEscorts = math.min(ministerCountry:GetTotalIC(), 10)

			neededEscorts = math.ceil((neededEscorts - freeEscorts) / defines.economy.CONVOY_CONSTRUCTION_SIZE)

			if neededEscorts > 0 then
				local cost = ministerCountry:GetEscortBuildCost():Get()
				local escortCommand = CConstructConvoyCommand(ministerTag, true, 1)

				for i = 1, neededEscorts do
					ai:Post(escortCommand)
					availIC = availIC - cost
				end
			end
		end
	end

	--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. "<-ConstructConvoys")

	return availIC
end
