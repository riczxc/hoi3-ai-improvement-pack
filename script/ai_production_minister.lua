-----------------------------------------------------------
-- production
-----------------------------------------------------------

require('ai_trade')

function ProductionMinister_Tick(minister)
	local ministerCountry = minister:GetCountry()
	local AvailIC = ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_PRODUCTION_ ):Get() - ministerCountry:GetUsedIC():Get()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local capitalProvId =  ministerCountry:GetActingCapitalLocation():GetProvinceID()
	local StartIC = AvailIC
	local TotalIC = ministerCountry:GetTotalIC()

	-- we need convoys at all?
	AvailIC = ConstructConvoys(ai, minister, ministerTag, ministerCountry, AvailIC )

	if AvailIC <= 0 then
		return 0
	end

	-- ai list of requests, in prio order
	local bBuildReserve = not (ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar())
	local requestQueue = ai:GetReqProdQueue()
	while (not requestQueue:IsEmpty()) and AvailIC > 0.0 do
		local unit = requestQueue:GetTailData().pUnit
		local cost = ministerCountry:GetBuildCostIC( unit, 1, bBuildReserve ):Get()
		-- only build sensible stuff
		if cost < TotalIC then
			local orderlist = SubUnitList()
			-- if infantry and 1/3 chance then build support brigade
			if tostring(unit:GetKey()) == "infantry_brigade" and math.mod( CCurrentGameState.GetAIRand(), 3)>1 then
				-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " messing with queue " .. tostring(unit:GetKey()) .. " changed to")
				orderlist, AvailIC = ChanceSupportBrigade(ministerCountry, bBuildReserve, orderlist, AvailIC)
			else
				-- if ENG tries to build transport del it in 9 out of 10
				if tostring(unit:GetKey()) == "transport_ship" and 'ENG' == tostring(ministerTag) and 0~=math.mod( CCurrentGameState.GetAIRand(), 10) then
					--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " failed to build " .. tostring(unit:GetKey()))
				else
					AvailIC = AvailIC - cost
					SubUnitList.Append( orderlist, unit )
					--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built queue " .. tostring(unit:GetKey()))
				end
			end
			local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bBuildReserve, CNullTag(), CID() )
			ai:Post( construct )
		end
		requestQueue:RemoveTail()
	end

	-- any requests by strategic ai
	for subunit in CSubUnitDataBase.GetSubUnitList() do
		local count = ministerCountry:GetStrategy():GetWantedSubUnits(subunit)
		local cost = ministerCountry:GetBuildCostIC( subunit, 1, bBuildReserve ):Get()
		if count > 0.0 and cost < TotalIC then
			local orderlist = SubUnitList()
			SubUnitList.Append( orderlist, subunit )
			AvailIC = AvailIC - cost
			local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, count, false, CNullTag(), CID() )
			ai:Post( construct )
			-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built (S) " .. tostring(subunit:GetKey()))
		end
	end

	-- got AvailIC left not built something yet?
	if AvailIC > 0 then
		-- 50% building or inf
		if 1==math.mod( CCurrentGameState.GetAIRand(), 2) then
			--Utils.LUA_DEBUGOUT("1")
			-- get provinces
			local provinceCount = 0
			provinces = {}
			for provinceId in ministerCountry:GetOwnedProvinces() do
				--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " province " .. tostring(provinceId) )
				provinces[provinceCount] = provinceId
				provinceCount = provinceCount+1
			end
			-- got provinces?
			if provinceCount > 0 then
				--Utils.LUA_DEBUGOUT("2")
				-- def costs and buildings
				local costalFort = CBuildingDataBase.GetBuilding( "coastal_fort" )
				local costalCost = ministerCountry:GetBuildCost( costalFort ):Get()
				local factory = CBuildingDataBase.GetBuilding( "industry" )
				local factoryCost = ministerCountry:GetBuildCost( factory ):Get()
				local navalBase = CBuildingDataBase.GetBuilding( "naval_base" )
				local navalCost = ministerCountry:GetBuildCost( navalBase ):Get()
				local antiAir = CBuildingDataBase.GetBuilding( "anti_air" )
				local aaCost = ministerCountry:GetBuildCost( antiAir ):Get()
				local airBase = CBuildingDataBase.GetBuilding( "air_base" )
				local airBaseCost = ministerCountry:GetBuildCost( airBase ):Get()
				local landFort = CBuildingDataBase.GetBuilding( "land_fort" )
				local landCost = ministerCountry:GetBuildCost( landFort ):Get()
				local radarStation = CBuildingDataBase.GetBuilding( "radar_station" )
				local radarCost = ministerCountry:GetBuildCost( radarStation ):Get()
				local infra = CBuildingDataBase.GetBuilding( "infra" )
				local infraCost = ministerCountry:GetBuildCost( infra ):Get()

				-- count
				local counter = 0
				--Utils.LUA_DEBUGOUT("3")
				-- do it 100 times or until sth is build or no IC
				while counter < 100 and AvailIC  > 0 do
					-- count
					counter = counter+1
					local index = math.mod( CCurrentGameState.GetAIRand(), provinceCount)
					local provinceId = provinces[index]
					--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " Picked " .. tostring(xxx) .. " @ " .. tostring(index).. " of " .. tostring(provinceCount))
					local province = CCurrentGameState.GetProvince( provinceId  )
					-- try equally to build different improvements
					local chance = math.mod( CCurrentGameState.GetAIRand(), 8)

					-- build infra if possible
					if 0==chance and ministerCountry:IsBuildingAllowed(infra, province) and province:GetInfrastructure():Get() < 1
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, infra, infraCost, provinceId)
					end

					if 1==chance and ministerCountry:IsBuildingAllowed(radarStation, province) and
					( province:HasBuilding( antiAir ) or province:HasBuilding( costalFort ) or province:HasBuilding( navalBase ) or
						province:HasBuilding( landFort ) or province:HasBuilding( airBase )) and not province:HasBuilding( radarStation )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, radarStation, radarCost, provinceId)
					end

					-- build factory but not at the front and not in or before war
					if 2==chance and ministerCountry:IsBuildingAllowed(factory, province)
					and (not province:IsFrontProvince(false) ) and province:GetInfrastructure():Get() > 0.3
					and ( not ( ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() ) )
					-- not the USA...engouh IC already
					and not ministerTag == CCountryDataBase.GetTag('USA')
					and province:HasBuilding( factory )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, factory, factoryCost, provinceId)
					end

					if 3==chance and ministerCountry:IsBuildingAllowed(landFort, province) and province:IsFrontProvince(false) and province:HasBuilding( landFort )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, landFort, landCost, provinceId)
					end

					if 4==chance and ministerCountry:IsBuildingAllowed(costalFort, province) and (province:HasBuilding( costalFort ) or province:HasBuilding( navalBase ))
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, costalFort, costalCost, provinceId)
					end

					if 5==chance and ministerCountry:IsBuildingAllowed(navalBase, province) and province:HasBuilding( navalBase )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, navalBase, navalCost, provinceId)
					end

					if 6==chance and ministerCountry:IsBuildingAllowed(airBase, province) and (not province:IsFrontProvince(false) ) and province:HasBuilding( airBase )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, airBase, airBaseCost, provinceId)
					end

					if 7==chance and ministerCountry:IsBuildingAllowed(antiAir, province) and
					( province:HasBuilding( antiAir ) or province:HasBuilding( costalFort ) or province:HasBuilding( navalBase ) or
						province:HasBuilding( factory ) or province:HasBuilding( landFort ) or province:HasBuilding( airBase ) or province:HasBuilding( radarStation ) )
					and AvailIC > 0 then
						AvailIC = BuildImprovement(ai, AvailIC, ministerTag, antiAir, aaCost, provinceId)
					end
					--Utils.LUA_DEBUGOUT("-"..tostring(counter).."- "..tostring(AvailIC))
				end
				--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " IC " .. tostring(AvailIC) .. " counter " .. tostring(counter))
			end
		else
			-- always fill out with more infantry if AvailIC and manpower is left
			if ministerCountry:GetOfficerRatio():Get() > 0.75
			 and AvailIC > 0 and  ministerCountry:GetManpower():Get() > TotalIC then
			 --and 0 == math.mod( CCurrentGameState.GetAIRand(),20) then
				local orderlist = SubUnitList()
				local infantry = CSubUnitDataBase.GetSubUnit("infantry_brigade")
				local militia = CSubUnitDataBase.GetSubUnit("militia_brigade")
				if ministerCountry:GetTechnologyStatus():IsUnitAvailable(infantry) then
					-- Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built inf div with... ")
					orderlist, AvailIC = InfantryDivision(ministerCountry, bBuildReserve, orderlist, AvailIC)
				else
					SubUnitList.Append( orderlist, militia )
					SubUnitList.Append( orderlist, militia )
					SubUnitList.Append( orderlist, militia )
					AvailIC = AvailIC - 3*ministerCountry:GetBuildCostIC( militia, 1, bBuildReserve ):Get()
					--Utils.LUA_DEBUGOUT( tostring(ministerTag) .. " built mil ")
				end
				--Utils.LUA_DEBUGOUT( "builds a division." )
				local construct = CConstructUnitCommand( ministerTag, orderlist, capitalProvId, 1, bBuildReserve, CNullTag(), CID() )
				ai:Post( construct )
			end
		end
	end

	--return math.max(AvailIC, 0)


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
	local SupplyStockFactor = ministerCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get()/(10*ministerCountry:GetTotalIC())
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
	ConsumerNeed = ConsumerNeed + MaxIC * math.min(math.max(dissent/10, 2-MoneyStockFactor), 0.9)

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
	elseif 4==rem  and ministerCountry:GetTechnologyStatus():IsUnitAvailable(anti_air) then
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
		local neededTransports = math.max(math.ceil(ministerCountry:GetTotalNeededTransports()*buffer/defines.economy.CONVOY_CONSTRUCTION_SIZE), 1)

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
