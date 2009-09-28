-----------------------------------------------------------
-- production
-----------------------------------------------------------

require('utils')
require('helper_functions')
require('production_division_templates')
require('production_restrictions')
require('production_province_improvements')

function ProductionMinister_Tick(minister)
	--Utils.LUA_DEBUGOUT("ProductionMinister_Tick")
	local ministerCountry = minister:GetCountry()
	if not IsValidCountry(ministerCountry) then
		--Utils.LUA_DEBUGOUT("ProductionMinister_TickEnd")
		return
	end

	local AvailIC = ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_PRODUCTION_ ):Get() - ministerCountry:GetUsedIC():Get()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local strategy = ministerCountry:GetStrategy()

	local capitalProvId =  ministerCountry:GetActingCapitalLocation():GetProvinceID()
	local StartIC = AvailIC
	local TotalIC = ministerCountry:GetTotalIC()
	local maxCost = TotalIC / 3
	local unit_name
	-----------------------------------
	-- Variable to use or not Darkzodiak's Division System
	local useDivisionSystem = 1
	-----------------------------------

	-- we need convoys at all?
	AvailIC = ConstructConvoys(ai, minister, ministerTag, ministerCountry, AvailIC )

	local ratioProvince = GetICRatioForProvinceImprovements(ministerCountry) * 100
	local improvements = nil
	local building = {}
	local dice = nil
	local provinceIndex = {}

	local nothingBuiltCounter = 0
	while (AvailIC > 0) and (nothingBuiltCounter < 10) do
		local availICInThisIteration = AvailIC

		if math.mod(CCurrentGameState.GetAIRand(), 100) > ratioProvince then
			-- Build units

			-- ai list of requests, in prio order
			local requestQueue = ai:GetReqProdQueue()
			local bShouldBuildReserve = not (ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar())
			if not requestQueue:IsEmpty() then
				----------------------------------- Random for Tail or Head Data
				local ranNumber = math.random(1,2)
				local unit = 1
				if ranNumber == 1 then
					unit = requestQueue:GetTailData().pUnit
				else
					unit = requestQueue:GetHeadData().pUnit
				end

				local bBuildReserve = bShouldBuildReserve
				if not unit:IsRegiment() then
					bBuildReserve = false
				end
				-----------------------------------
				local cost = ministerCountry:GetBuildCostIC( unit, 1, bBuildReserve ):Get()
				-- only build sensible stuff
				if cost < maxCost then
					local orderlist = SubUnitList()
					unit_name = tostring(unit:GetKey())
					---------------------------------------------------------------
					-- If we are using division system
					if useDivisionSystem > 0 then
						if unit:IsRegiment() then
							--Utils.LUA_DEBUGOUT( "Brigade unit")
							orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
						elseif unit:IsShip() then
							--Utils.LUA_DEBUGOUT( "Naval unit")
							orderlist, AvailIC = BuildNavalAndAir(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
						elseif unit:IsBomber() or unit:IsCag() or unit_name == "cas" or unit_name == "flying_bomb"
						or unit_name == "flying_rocket" or unit_name == "interceptor" or unit_name == "multi_role"
						or unit_name == "rocket_interceptor" then
							--Utils.LUA_DEBUGOUT( "Air Unit")
							orderlist, AvailIC = BuildNavalAndAir(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
						else
							AvailIC = AvailIC - cost
							SubUnitList.Append( orderlist, unit )
						end
					---------------------------------------------------------------
					else
						if unit_name == "infantry_brigade" and math.mod( CCurrentGameState.GetAIRand(), 3)>1 then
							-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " messing with queue " .. tostring(unit:GetKey()) .. " changed to")
							orderlist, AvailIC = ChanceSupportBrigade(ministerCountry, bBuildReserve, orderlist, AvailIC)
						-- if ENG tries to build transport del it in 9 out of 10
						elseif unit_name == "transport_ship" and 'ENG' == tostring(ministerTag) and 0~=math.mod( CCurrentGameState.GetAIRand(), 10) then
							--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " failed to build " .. tostring(unit:GetKey()))
						else
							AvailIC = AvailIC - cost
							SubUnitList.Append( orderlist, unit )
							--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built queue " .. tostring(unit:GetKey()))
						end
					end
					---------------------------------------------------------------
					local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bBuildReserve, CNullTag(), CID() )
					ai:Post( construct )
				end
				-----------------------------------
				if ranNumber == 1 then
					requestQueue:RemoveTail()
				else
					requestQueue:RemoveHead()
				end
				-----------------------------------
			else
				-- any requests by strategic ai
				for subunit in CSubUnitDataBase.GetSubUnitList() do
					local bBuildReserve = bShouldBuildReserve
					if not subunit:IsRegiment() then
						bBuildReserve = false
					end

					local count = ministerCountry:GetStrategy():GetWantedSubUnits(subunit)
					local cost = ministerCountry:GetBuildCostIC( subunit, 1, bBuildReserve ):Get()
					if (count > 0.0) and (cost < maxCost) and (AvailIC > 0) then
						local orderlist = SubUnitList()
						SubUnitList.Append( orderlist, subunit )
						AvailIC = AvailIC - cost
						local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, count, bBuildReserve, CNullTag(), CID() )
						ai:Post( construct )
						-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built (S) " .. tostring(subunit:GetKey()))
					end
				end

				-- Got AvailIC left not built something yet?
				if AvailIC > 0 then
					-- always fill out with more infantry if AvailIC and manpower is left
					if ministerCountry:GetOfficerRatio():Get() > 0.75
						and (ministerCountry:GetManpower():Get() > TotalIC)
					then
						local orderlist = SubUnitList()
						local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")
						local militia = CSubUnitDataBase.GetSubUnit("militia_brigade")
						---------------------------------------------------------------
						if ministerCountry:GetTechnologyStatus():IsUnitAvailable(infantry) then
							-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built inf div with... ")
							unit_name = "infantry_brigade"
							orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bShouldBuildReserve, orderlist, AvailIC, unit_name)
						else
							unit_name = "militia_brigade"
							orderlist, AvailIC = BuildTemplateDivision(minister, ministerCountry, bShouldBuildReserve, orderlist, AvailIC, unit_name)
							--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built mil ")
						end
						---------------------------------------------------------------
						--Utils.LUA_DEBUGOUT( "builds a division." )
						local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bShouldBuildReserve, CNullTag(), CID() )
						ai:Post( construct )
					end
				end
			end

		else

			if improvements == nil then
				--Utils.LUA_DEBUGOUT("Initializing province improvements for " .. tostring(ministerTag))

				-- Load country specific province improvements
				improvements = LoadProvinceImprovements(ministerCountry)

				-- Make sure the improvements table is complete
				local requiredKeys = {
					infra = {
						priority = 0,
						max_level = 0.8
					},
					industry = {
						priority = 0
					},
					air_base = {
						priority = 0
					},
					naval_base = {
						priority = 0
					},
					anti_air = {
						priority = 0
					},
					land_fort = {
						priority = 0
					},
					coastal_fort = {
						priority = 0
					},
					radar_station = {
						priority = 0
					}
				}
				for k,v in pairs(requiredKeys) do
					if improvements[k] == nil then
						improvements[k] = v
					else
						-- Cycle through subkeys
						for subk,subv in pairs(v) do
							if improvements[k][subk] == nil then
								improvements[k][subk] = subv
							end
						end
					end
				end

				-- Now create a list of provinces where each improvement can be built
				local ids = { any = {} }
				for k,v in pairs(improvements) do
					ids[k] = {}
					building[k] = CBuildingDataBase.GetBuilding(k)
				end

				for provinceId in ministerCountry:GetOwnedProvinces() do
					local province = CCurrentGameState.GetProvince(provinceId)

					local hasBuilding = false
					for k,v in pairs(improvements) do
						if k == 'infra' then
							if province:GetInfrastructure():Get() < v.max_level then
								table.insert(ids[k], provinceId)
							end
						else
							if province:HasBuilding(building[k]) then
								table.insert(ids[k], provinceId)
								hasBuilding = true
							end
						end
					end
					if hasBuilding then
						table.insert(ids.any, provinceId)
					end
				end

				-- Select provinces randomly out of possible provinces
				for k,v in pairs(improvements) do
					-- Select province source
					local key = k
					if k == 'anti_air' or k == 'radar_station' then
						key = 'any'
					end

					local source = ids[key]
					if improvements[k].ids ~= nil then
						v.ids_not_random = true
						source = improvements[k].ids
					end

					improvements[k].selected_ids = {}

					-- Randomly select up to 100 provinces
					for i = 1, math.min(100, table.getn(source)) do
						local index = math.mod(CCurrentGameState.GetAIRand(), table.getn(source)) + 1
						table.insert(improvements[k].selected_ids, source[index])
					end
				end

				-- Now make sure we can even build a improvement in selected provinces
				-- If not, the priority for this improvement is set to 0
				local prioSum = 0
				for k,v in pairs(improvements) do
					if improvements[k].priority > 0 then
						local improvementPossible = false
						for i = 1, table.getn(v.selected_ids) do
							local province = CCurrentGameState.GetProvince(v.selected_ids[i])
							if ministerCountry:IsBuildingAllowed(building[k], province) then
								improvementPossible = true
							end
							if improvementPossible then
								break
							end
						end

						if not improvementPossible then
							improvements[k].priority = 0
						end
					end
					prioSum = prioSum + improvements[k].priority
				end

				if prioSum > 0 then
					-- Rebalance and create a dice
					local lastSideCount = 0
					dice = {}
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
				--else
					--Utils.LUA_DEBUGOUT("No province improvements")
				end
			end

			if dice ~= nil then
				--Utils.LUA_DEBUGOUT("Trying to build province improvement...")

				local counter = 0
				local availICForThisRound = AvailIC
				while (AvailIC == availICForThisRound) and (counter < 10) do
					-- Now let's roll the dice
					local diceIndex = math.mod(CCurrentGameState.GetAIRand(), table.getn(dice))
					local k = dice[diceIndex]
					local v = improvements[k]
					local cost = ministerCountry:GetBuildCost(building[k]):Get()

					--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. " improvement " .. k .. " priority " .. tostring(v.priority) .. " AvailIC " .. tostring(AvailIC))

					if provinceIndex[k] == nil then
						provinceIndex[k] = 0
					end
					provinceIndex[k] = provinceIndex[k] + 1

					local i = math.mod(provinceIndex[k], table.getn(v.selected_ids))
					local province = CCurrentGameState.GetProvince(v.selected_ids[i])

					if ministerCountry:IsBuildingAllowed(building[k], province) then
						--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. " is building improvement " .. k)

						if k == 'infra' then
							if province:GetInfrastructure():Get() < v.max_level then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						elseif k == 'industry' then
							if v.ids_not_random or
								(
									not province:IsFrontProvince(false)
								and
									province:GetInfrastructure():Get() > 0.3
								)
							then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						elseif k == 'land_fort' then
							if v.ids_not_random or province:IsFrontProvince(false) then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						elseif k == 'coastal_fort' then
							if v.ids_not_random or province:HasBuilding(building.naval_base) then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						elseif k == 'radar_station' then
							if v.ids_not_random or (not province:HasBuilding(building[k])) then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						elseif k == 'air_base' then
							if v.ids_not_random or (not province:IsFrontProvince(false)) then
								AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
							end
						else -- anti_air and naval_base
							AvailIC = BuildImprovement(ai, AvailIC, ministerTag, building[k], cost, v.selected_ids[i])
						end
					end

					counter = counter + 1
				end

				--if counter == 0 then
					--Utils.LUA_DEBUGOUT("No improvement built in this round.")
				--end
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

	--Utils.LUA_DEBUGOUT("ProductionMinister_TickEnd")
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
	---Utils.LUA_DEBUGOUT("F")
	return AvailIC
end

function BalanceProductionSliders(ai, ministerCountry, prioSelection)
	--Utils.LUA_DEBUGOUT("BalanceProductionSliders - " .. tostring(ministerCountry:GetCountryTag()) )
	--Utils.LUA_DEBUGOUT("TotalIC: " .. tostring(ministerCountry:GetTotalIC() ))
	--Utils.LUA_DEBUGOUT("proSelection: " .. tostring(prioSelection) )
	-- if tostring(ministerCountry:GetCountryTag())=='GER' then
		-- Utils.LUA_DEBUGOUT( " BalanceProductionSliders ")
	-- end
	--local ministerCountry = minister:GetCountry()
	--local TotalIC = ministerCountry:GetTotalIC()

	local changes = CArrayFix(5)
	local dissent = ministerCountry:GetDissent():Get()
	local AvailIC = ministerCountry:GetTotalIC()

	-- Distribute IC --
	-- First get CG and money sorted
	-- CONSUMER
	local ConsumerNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get() --/ TotalIC
	local moneyModifier = ministerCountry:GetGlobalModifier():GetValue(CModifier._MODIFIER_GLOBAL_MONEY_) * -1
	local neededMoney = -math.min(GetAverageBalance(ministerCountry, CGoodsPool._MONEY_), 0)
	local neededMoneyToReachTargetStock = math.max((GetTargetStock(ministerCountry, CGoodsPool._MONEY_) - GetStock(ministerCountry, CGoodsPool._MONEY_)) / ai_configuration.G_AVERAGING_TIME_PERIOD, 0)
	neededMoney = neededMoney + neededMoneyToReachTargetStock
	ConsumerNeed = ConsumerNeed * (1 + dissent) + math.max(neededMoney * (1 + moneyModifier), 0)
	ConsumerNeed = math.min(ConsumerNeed, AvailIC )
	changes:SetAt( CDistributionSetting._PRODUCTION_CONSUMER_, CFixedPoint( ConsumerNeed ) )
	AvailIC = AvailIC - ConsumerNeed

	-- SUPPLY
	local SupplyNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_SUPPLY_ ):GetNeeded():Get() --/ TotalIC
	local desireSupplies = GetDesireInGoods(ministerCountry, CGoodsPool._SUPPLIES_)
	local desireMoney = math.min(GetDesireInGoods(ministerCountry, CGoodsPool._MONEY_), 0)
	-- Don't fool ourselfs in thinking we've enough money to decrease supply production
	-- forcing ourselfs to be a supply-buying-country if the money surplus comes from selling
	-- of supplies.
	if desireMoney < 0 then
		-- Find out where the money is coming from
		if GetTradedAmount(ministerCountry, CGoodsPool._SUPPLIES_) < 0 then
			desireMoney = 0
		end
	end
	-- As long as we're overproducing in CG produce more supplies as needed to decrease the desire
	-- in supplies and so get eventually a trade running selling supplies to make some money.
	local penalty = math.min(GetCGOverProductionPenalty(ministerCountry), 0.6)
	if desireSupplies > 0.9 then
		-- Probably a bug:
		-- If supplies drop to zero, supply need also drops to zero and will never come back up
		-- Put all into supplies till desire falls under 0.9
		SupplyNeed = AvailIC
	else
		SupplyNeed = SupplyNeed * math.max(1 + (1 - penalty) * desireMoney + (1 - penalty) * desireSupplies + penalty, 0)
	end
	SupplyNeed = math.min(SupplyNeed, AvailIC )
	changes:SetAt( CDistributionSetting._PRODUCTION_SUPPLY_, CFixedPoint( SupplyNeed ) )
	AvailIC = AvailIC - SupplyNeed

	--if tostring(ministerCountry:GetCountryTag()) == 'ROM' then
		--Utils.LUA_DEBUGOUT("Desire in supplies is " .. tostring(desireSupplies))
		--Utils.LUA_DEBUGOUT("Desire in money is " .. tostring(desireMoney))
		--Utils.LUA_DEBUGOUT("SupplyNeed is " .. tostring(SupplyNeed))
	--end

	-- REINFORCEMENT
	local ReinforcementNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_REINFORCEMENT_ ):GetNeeded():Get() --/ TotalIC

	-- PRODUCTION
	local ProductionNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_PRODUCTION_ ):GetNeeded():Get() --/ TotalIC

	-- UPGRADE
	local UpgradeNeed = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_UPGRADE_ ):GetNeeded():Get() --/ TotalIC

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

		-- Upgrade (50% of max AvailIC)
		UpgradeNeed = math.min(UpgradeNeed, AvailIC) * 0.5
		changes:SetAt( CDistributionSetting._PRODUCTION_UPGRADE_, CFixedPoint( UpgradeNeed ) )
		AvailIC = AvailIC - UpgradeNeed

		-- put the rest into production
		ProductionNeed = AvailIC
		changes:SetAt( CDistributionSetting._PRODUCTION_PRODUCTION_, CFixedPoint( ProductionNeed ) )
		AvailIC = AvailIC - ProductionNeed
	end
	--Utils.LUA_DEBUGOUT("EndBalanceProductionSliders - " .. tostring(ministerCountry:GetCountryTag()) )
	ai:Post( CChangeInvestmentCommand( ministerCountry:GetCountryTag(), changes ) )
end

-- for debugging
--local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function BuildTemplateDivision(minister, ministerCountry, bBuildReserve, orderlist, AvailIC, unit_name)
	--Utils.LUA_DEBUGOUT( "ENTER Build division function")
	local prod_ratio = {}
	local type_template = 'infantry_template'

	--Utils.LUA_DEBUGOUT( unit_name )
	--infantry
	if unit_name == "infantry_brigade" then
		type_template = 'infantry_template'
	elseif unit_name == "bergsjaeger_brigade" then
		type_template = 'mountain_template'
	elseif unit_name == "marine_brigade" then
		type_template = 'marine_template'
	elseif unit_name == "militia_brigade" then
		type_template = 'militia_template'
	elseif unit_name == "garrison_brigade" then
		type_template = 'garrison_template'
	elseif unit_name == "cavalry_brigade" then
		type_template = 'cavalry_template'
	elseif unit_name == "paratrooper_brigade" then
		type_template = 'paratrooper_template'
	--armor/motorized
	elseif unit_name == "light_armor_brigade" then
		type_template = 'light_armor_template'
	elseif unit_name == "armor_brigade" then
		type_template = 'armor_template'
	elseif unit_name == "motorized_brigade" then
		type_template = 'motorized_template'
	elseif unit_name == "mechanized_brigade" then
		type_template = 'mechanized_template'
	end

	--Utils.LUA_DEBUGOUT( "Start Load production function")
	-- Load country's division templates
	prod_ratio = LoadProductionRatio(minister, ministerCountry)

	local i = 1
	local j = 1
	local pourcent = 100
	local template_number = 0
	local rem = math.mod( CCurrentGameState.GetAIRand(), 100)

	-- Determine which template AI will builds
	while prod_ratio[type_template][i] and template_number == 0 do
		pourcent = pourcent - prod_ratio[type_template][i][1]
		--Utils.LUA_DEBUGOUT(prod_ratio[type_template][i][1])
		if rem >= pourcent then
			--Utils.LUA_DEBUGOUT( "Find")
			template_number = i
			j = 2
			-- Check every brigades in the template, if they are available
			while prod_ratio[type_template][template_number][j] do
				if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_ratio[type_template][template_number][j]) == false then
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
		while prod_ratio[type_template][template_number][j] do
			if ministerCountry:GetTechnologyStatus():IsUnitAvailable(prod_ratio[type_template][template_number][j]) then
				SubUnitList.Append( orderlist, prod_ratio[type_template][template_number][j] )
				AvailIC = AvailIC - ministerCountry:GetBuildCostIC( prod_ratio[type_template][template_number][j], 1, bBuildReserve ):Get()
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

function InfantryDivision(ministerCountry, bBuildReserve, orderlist, AvailIC)
	local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")

	SubUnitList.Append( orderlist, infantry )
	SubUnitList.Append( orderlist, infantry )

	orderlist, AvailIC = ChanceSupportBrigade(ministerCountry, bBuildReserve, orderlist, AvailIC)

	AvailIC = AvailIC - 2*ministerCountry:GetBuildCostIC( infantry, 1, bBuildReserve ):Get()
	return orderlist, AvailIC
end

function ChanceSupportBrigade(ministerCountry, bBuildReserve, orderlist, AvailIC)
	local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")
	local artillery = CSubUnitDataBase.GetSubUnit("artillery_brigade")
	local anti_tank = CSubUnitDataBase.GetSubUnit("anti_tank_brigade")
	local anti_air = CSubUnitDataBase.GetSubUnit("anti_air_brigade")

	--local rem = math.random(3)
	local rem = math.mod( CCurrentGameState.GetAIRand(), 5)
	-- 40% chance to make artillery, anti tank or 20% for AA
	if rem<2 and ministerCountry:GetTechnologyStatus():IsUnitAvailable(artillery) then
		SubUnitList.Append( orderlist, artillery )
		AvailIC = AvailIC - ministerCountry:GetBuildCostIC( artillery, 1, bBuildReserve ):Get()
		-- Utils.LUA_DEBUGOUT( tostring(artillery:GetKey()) )
	elseif rem<4  and ministerCountry:GetTechnologyStatus():IsUnitAvailable(anti_tank) then
		SubUnitList.Append( orderlist, anti_tank )
		AvailIC = AvailIC - ministerCountry:GetBuildCostIC( anti_tank, 1, bBuildReserve ):Get()
		-- Utils.LUA_DEBUGOUT( tostring(anti_tank:GetKey()) )
	elseif 5==rem  and ministerCountry:GetTechnologyStatus():IsUnitAvailable(anti_air) then
		SubUnitList.Append( orderlist, anti_air )
		AvailIC = AvailIC - ministerCountry:GetBuildCostIC( anti_air, 1, bBuildReserve ):Get()
		-- Utils.LUA_DEBUGOUT( tostring(anti_air:GetKey()) )
	else
		SubUnitList.Append( orderlist, infantry )
		AvailIC = AvailIC - ministerCountry:GetBuildCostIC( infantry, 1, bBuildReserve ):Get()
		-- Utils.LUA_DEBUGOUT( tostring(infantry:GetKey()) )
	end
	return orderlist, AvailIC
end


function ConstructConvoys(ai, minister, ministerTag, ministerCountry, AvailIC )
	if ministerCountry:GetNumOfPorts() > 0 then
		-- 10%
		local buffer = 0.1
		local minTransportNeed = ministerCountry:GetTotalIC() / 10

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
		local neededTransports = math.max(math.ceil(ministerCountry:GetTotalNeededTransports()*buffer/defines.economy.CONVOY_CONSTRUCTION_SIZE), minTransportNeed)

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
			local neededEscorts = math.max(math.ceil(minister:CountTotalDesiredEscorts()*buffer/defines.economy.CONVOY_CONSTRUCTION_SIZE), 1)
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
