require('ai_configuration')

local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

-------------------------------------------------------------------------------
-- DEBUG Functions
-------------------------------------------------------------------------------
function PrintCountryTable(ai, minIC)
	for country1 in CCurrentGameState.GetCountries() do
		countryTag1 = country1:GetCountryTag()

		if IsValidCountry(country1) and country1:GetMaxIC() > minIC then
			Utils.LUA_DEBUGOUT("-------------------- " .. tostring(countryTag1) .. " --------------------")
			local neutrality = country1:GetNeutrality():Get()
			local effectiveNeutrality = country1:GetEffectiveNeutrality():Get()

			for country2 in CCurrentGameState.GetCountries() do
				countryTag2 = country2:GetCountryTag()

				if IsValidCountry(country2) and not (countryTag1 == countryTag2) and country2:GetMaxIC() > minIC then
					Utils.LUA_DEBUGOUT("\t---------- " .. tostring(countryTag2) .. " ----------")

					local diplomacyStatus = country1:GetRelation(countryTag2)
					local strategy = country1:GetStrategy()

					Utils.LUA_DEBUGOUT("\tCCountry")
					Utils.LUA_DEBUGOUT("\t\tGetDiplomaticDistance = " .. country1:GetDiplomaticDistance(countryTag2):Get())

					Utils.LUA_DEBUGOUT("\tCDiplomacyStatus")
					Utils.LUA_DEBUGOUT("\t\tGetValue = " .. diplomacyStatus:GetValue():Get())
					Utils.LUA_DEBUGOUT("\t\tGetThreat = " .. diplomacyStatus:GetThreat():Get())

					Utils.LUA_DEBUGOUT("\tCAIStrategy")
					Utils.LUA_DEBUGOUT("\t\tGetAntagonism = " .. strategy:GetAntagonism(countryTag2))
					Utils.LUA_DEBUGOUT("\t\tGetFriendliness = " .. strategy:GetFriendliness(countryTag2))
					Utils.LUA_DEBUGOUT("\t\tGetProtectionism = " .. strategy:GetProtectionism(countryTag2))
					Utils.LUA_DEBUGOUT("\t\tGetThreat = " .. strategy:GetThreat(countryTag2))

					Utils.LUA_DEBUGOUT("\tCAI")
					Utils.LUA_DEBUGOUT("\t\tGetCountryAlignmentDistance = " .. ai:GetCountryAlignmentDistance(country1, country2):Get())
				end
			end

			Utils.LUA_DEBUGOUT("\n")
		end
	end
end

-------------------------------------------------------------------------------
-- START Common helper functions
-------------------------------------------------------------------------------

gCommon = {
	result_cache = {}
}

function HFInit_Common()
	gCommon = {
		result_cache = {}
	}
end

function IsValidCountry(country)
	local countryTag = country:GetCountryTag()
	return countryTag:IsReal() and countryTag:IsValid() and country:Exists()
end

function GetAverageInfrastructure(country)
	-- Recalculate two times a year
	return CallTimesAYear(country:GetCountryTag(), 2, GetAverageInfrastructureImpl, country)
end

function GetAverageInfrastructureImpl(country)
	if IsValidCountry(country) then
		local provinceCount = 0
		local infrastructure = 0
		local result = 0

		for provinceId in country:GetOwnedProvinces() do
			local province = CCurrentGameState.GetProvince(provinceId)
			infrastructure = infrastructure + province:GetInfrastructure():Get()
			provinceCount = provinceCount + 1
		end

		if provinceCount > 0 then
			result = infrastructure / provinceCount
		end

		return result
	else
		return 1
	end
end

-- Modulo function with the property, that the remainder of a division z / d
-- and z < 0 is positive. For example: zmod(-2, 30) = 28.
function Zmod(z, d)
	return math.mod((math.mod(z, d) + d), d);
end

-- A function which shows compareable behaviour to php's in_array.
function in_table ( e, t )
 	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

-- Is country A capital on the same land mass as country B capital ?
function IsOnSameContinent(tagA, countryA, tagB, countryB)
	local a = tostring(tagA)
	local b = tostring(tagB)

	-- Bypass stupid question
	if a == b then
		return true
	end

	-- Island countries
	-- eg : No ENG mainland share border with other country
	if in_table( a, gGeography["island_countries"] ) or in_table( b, gGeography["island_countries"] ) then
		return false
	end

	-- Test if countries are part of a same island cluster
	-- eg : HAITI
	for _,v in ipairs(gGeography["island_clusters"]) do
		if in_table( a, v ) and in_table( b, v ) then
			return false
		end
	end

	local continentA = countryA:GetCapitalLocation():GetContinent()
	local continentB = countryB:GetCapitalLocation():GetContinent()

	-- European capital, asiatic lands
	if a == 'SOV' or b == 'SOV' then
		--I found no mean to get continent from string...
		local continentAsia = CCurrentGameState.GetProvince(4390):GetContinent() --Vladivostok

		if a == 'SOV' and ((continentA == continentB) or (continentAsia == continentB)) then
			return true
		elseif b == 'SOV' and ((continentA == continentB) or (continentAsia == continentA)) then
			return true
		end
		return false
	end

	-- Asian capital, european lands
	if a == 'TUR' or b == 'TUR' then
		--I found no mean to get continent from string...
		local continentEurope = CCurrentGameState.GetProvince(4503):GetContinent() --Istanbul

		if a == 'TUR' and ((continentA == continentB) or (continentEurope == continentB)) then
			return true
		elseif b == 'TUR' and ((continentA == continentB) or (continentEurope == continentA)) then
			return true
		end
		return false
	end
	
	return (continentA == continentB)
end

-- This function is convenient to detect colonies (invasions?).
-- useful no to spy colonial powers as Guanxi (for instance)
function IsNeighbourOnSameContinent(tagA, countryA, tagB, countryB)
	--Utils.debug("IsNeighbourOnSameContinent",tagA,"ROOT")
	return (IsOnSameContinent(tagA, countryA, tagB, countryB) and countryA:IsNeighbour(tagB))
end



-- virtual neighbours for countries isolated by oceans
-- Rule of thumb :
--  * Distance must be short (except for pacific area and strategic relationship)
--  	* The more the distance, the more it must concern major
--  * Colonies are not considered as part of mainland (ENG is not neighbour to CUB through bermudas or jamaica)
--  * Some colonies such as Batavia may be considered as mainland (HOL survive only through its colonies past '40)
--  * Islands country must provide an extended list.
--  * Third world countries surrounded by colonial empire (ETH, LIB, SIA) may be considered as island.
--  * Former colonial master may keep a unilateral connection for historical purpose
--
-- This function won't follow invasions and land possession. It may be unaccurate in ahistorical/world domination games.
function IsOceanNeighbour(tagA, tagB)
	--Utils.debug( "IsOceanNeighbour", tagA, "DEVEL")

	local a = tostring(tagA)
	local b = tostring(tagB)

	-- Bypass stupid question
	if a == b then
		return false
	end

	if gGeography["ocean_neighbour"][a] ~= nil then
		if in_table(b,gGeography["ocean_neighbour"][a]) then
			return CCountryDataBase.GetTag(b):IsValid()
		end
	end

	--Utils.debug("/IsOceanNeighbour")

	return false
end

function HasExtraManpowerLeft(country)
	-- We get a No such operator defined exception calling following code since 1.4
	-- Well let's hope this workaround is not necessary anymore in 1.4
	-- TODO: TEST THIS!!!!!!!!!
	--local mp = EstimateMPToMobilize(country)
	--local result = country:GetManpower():Get() > (2 * country:GetMaxIC() + mp)
	--return (result and country:HasExtraManpowerLeft())
	
	return country:HasExtraManpowerLeft()
end

function EstimateMPToMobilize(country)
	if not (country:IsAtWar() or country:IsMobilized()) then
		return CallTimesAYear(country:GetCountryTag(), 12, EstimateMPToMobilizeImpl, country)
	else
		return 0
	end
end

function EstimateMPToMobilizeImpl(country)
	local mp = 0
	
	for unit in country:GetUnits() do
		local children = false
		for child in unit:GetChildren() do
			children = true
			break
		end
		
		local unitName = string.lower(tostring(unit:GetName()))
		-- Filter out air, see and HQ units.
		if not (
			children or
			string.match(unitName, "fleet") or
			string.match(unitName, "flott") or
			string.match(unitName, "marin") or
			string.match(unitName, "kaigun") or
			string.match(unitName, "navy") or
			string.match(unitName, "trans") or
			string.match(unitName, "air") or
			string.match(unitName, "hq")
		) then
			dtools.debug("Added: " .. tostring(unit:GetName()), country, "DEVEL")
			mp = mp + 8
		else
			dtools.debug("Filtered: " .. tostring(unit:GetName()), country, "DEVEL")
		end
	end
	
	local reserveArmy = (gReserve[tostring(country:GetCountryTag())] or 1.0)
	local reservePenalty = country:GetGlobalModifier():GetValue(CModifier._MODIFIER_RESERVES_PENALTY_SIZE_):Get()
	local result = -mp * reservePenalty * reserveArmy
	
	dtools.debug(string.format("MP: %d, RP: %f, Reserve-Army: %f, Result: %f", mp, reservePenalty, reserveArmy, result), country, 'DEVEL')
	
	return result
end

-- Calls the function f times a year for country with tag countryTag and
-- caches and returns the result.
function CallTimesAYear(countryTag, times, f, ...)
	local countryString = tostring(countryTag)
	local functionName = tostring(f)
	local currentDate = CCurrentGameState.GetCurrentDate()
	-- This is not exact, but it doesn't need to be exact. Fast is better.
	local today = currentDate:GetYear() * 365 + currentDate:GetMonthOfYear() * 30.5 + currentDate:GetDayOfMonth()
	local resultCache = gCommon.result_cache
	
	if not resultCache[countryString] then
		resultCache[countryString] = {}
	end
	
	resultCache = resultCache[countryString]
	if not resultCache[functionName] then
		resultCache[functionName] = {
			day = 0,
			result = nil
		}
	end
	
	local timeSpan = today - resultCache[functionName].day
	if timeSpan > 365 / times then
		resultCache[functionName].result = f(...)
		resultCache[functionName].day = today
		dtools.debug(
			string.format(
				"Recalculated function %s with result %s.", 
				functionName, 
				tostring(resultCache[functionName].result)
			),
			countryString,
			'DEVEL'
		)
	end
	
	return resultCache[functionName].result
end

-------------------------------------------------------------------------------
-- END Common helper functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- START Trade specific functions
-------------------------------------------------------------------------------

-- Trade specific global variables and constants.
-- Variables will be updated by HFInit_ManageTrade.
gEconomy = {}
--~ gEconomy["deal"] = {}
gDayCount = -1
gLastDate = {
	day = 0,
	month = 0,
	year = 0
}
G_MEASURED_TIME_PERIOD = 8 -- For how many days are we accounting for
G_AVERAGING_TIME_PERIOD = 7 -- How many days are averaged (must be < G_MEASURED_TIME_PERIOD)
G_MAX_GC_OVER_PRODUCTION = 15 -- How much IC are allowed to put into GC in %
TRADING_THRESHOLD = 0.4

function HFInit_Economy()
	gEconomy["stock"] = {}
	gEconomy["goods_cost"] = {
 		[0] = 	defines.goods_cost.SUPPLIES,
 				defines.goods_cost.FUEL,
				defines.goods_cost.MONEY,
				defines.goods_cost.CRUDE_OIL,
				defines.goods_cost.METAL,
				defines.goods_cost.ENERGY,
				defines.goods_cost.RARE_MATERIALS
	}
end

HFInit_Economy()

-- Must be called by ForeignMinister_ManageTrade
function HFInit_ManageTrade(ai, ministerTag)
	-- Update gEconomy["stock"] once a day for all countries
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	if tostring(ministerTag) == '---' then -- Always first country called a day
		--Utils.LUA_DEBUGOUT("->HFInit_ManageTrade")
		--PrintCountryTable(ai, 40)

		-- Global variables won't be deleted if we load a new game.
		-- Check last saved date and if time difference is > 1 day we know we're in
		-- a new game.
		local currentDate = CCurrentGameState.GetCurrentDate()

		--Utils.LUA_DEBUGOUT(tostring(gLastDate.day) .. "." .. tostring(gLastDate.month) .. "." .. tostring(gLastDate.year))
		--Utils.LUA_DEBUGOUT(tostring(currentDate:GetDayOfMonth()) .. "." .. tostring(currentDate:GetMonthOfYear()) .. "." .. tostring(currentDate:GetYear()))

		-- If a new game is loaded up the minister tick functions are called twice
		-- on first day (at lease this behaviour is true in 1.2).
		-- Use this behaviour instead of measuring time difference but leave time
		-- measure here in case this behaviour changes in future patches.
		local init = false
		if 	gLastDate.year == currentDate:GetYear() and
			gLastDate.month == currentDate:GetMonthOfYear() and
			gLastDate.day == currentDate:GetDayOfMonth()
		then
			init = true
		end

		--[[
		local init = true
		if gLastDate.year ~= currentDate:GetYear() then
			-- Different year
			if	(currentDate:GetYear() - gLastDate.year) == 1 and
				gLastDate.month == 11 and
				currentDate:GetMonthOfYear() == 0 and
				gLastDate.day == 30 and
				currentDate:GetDayOfMonth() == 0
			then
				-- New year's eve -> ok
				init = false
			end
		else
			-- Same year
			if gLastDate.month ~= currentDate:GetMonthOfYear() then
				-- Different month
				if	(currentDate:GetMonthOfYear() - gLastDate.month) == 1 and
					currentDate:GetDayOfMonth() == 0 and
					(
						-- Month was february => Last day must be either 27 or 28 OR
						-- Month was even => Last day must be 30 OR
						-- Month was unevent => Last day must be 29
						(not (gLastDate.month == 1) or (gLastDate.day == 27 or gLastDate.day == 28)) or
						(not (math.mod(gLastDate.month, 2) == 0) or (gLastDate.day == 30)) or
						(not (math.mod(gLastDate.month, 2) == 1) or (gLastDate.day == 29))
					)
				then
					init = false
				end
			else
				-- Same month
				if (currentDate:GetDayOfMonth() - gLastDate.day) == 1 then
					-- Last date was yesterday -> ok
					init = false
				end
			end
		end
		]]

		if init then
			gDayCount = -1
			HFInit_Common()
			HFInit_Economy()
		end
		gLastDate.year = currentDate:GetYear()
		gLastDate.month = currentDate:GetMonthOfYear()
		gLastDate.day = currentDate:GetDayOfMonth()

		gDayCount = gDayCount + 1
		--Utils.LUA_DEBUGOUT("--> Day " .. tostring(gDayCount))

		local day = math.mod(gDayCount, G_MEASURED_TIME_PERIOD) -- Measuring a period of G_MEASURED_TIME_PERIOD days
		for country in CCurrentGameState.GetCountries() do
			local countryTag = country:GetCountryTag()
			local strCountryTag = tostring(countryTag)

			if IsValidCountry(country) then
				if not gEconomy["stock"][strCountryTag] then
					gEconomy["stock"][strCountryTag] = {}
				end

				local pool = country:GetPool()

				for goods = 0, MAX_GOODS do
					if not gEconomy["stock"][strCountryTag][goods] then
						gEconomy["stock"][strCountryTag][goods] = {}
					end

					gEconomy["stock"][strCountryTag][goods][day] = pool:Get(goods):Get()
				end
			else
				gEconomy["stock"][strCountryTag] = nil
			end
		end
	end
end

-- Returns true if trade of given country is controlled by human.
function IsTradeControlledByHuman(countryTag)
	-- TODO: Trades can be automated without necessarily having diplomacy automated.
	-- Ask PI to add a constant for this. Here's the request: http://forum.paradoxplaza.com/forum/showpost.php?p=10796834&postcount=156
	return (CCurrentGameState.GetPlayer() == countryTag and not CAI.IsAIControlledForPlayer(CAI._DIPLOMACY_))
end

-- Returns average balance of given goods.
-- G_AVERAGING_TIME_PERIOD defines how much days are averaged.
-- Note: This function needs some days to return good results.
function GetAverageBalance(ministerCountry, goods)
	local key = tostring(ministerCountry:GetCountryTag())
	if not gEconomy["stock"][key] then
		return 0
	end
	
	if not IsValidCountry(ministerCountry) then
		return 0
	end

	local period = math.min(gDayCount, G_AVERAGING_TIME_PERIOD)
	if period < 2 or Stock(ministerCountry, goods) >= 99990 then
		-- We either don't have enough data to compare or max stockpile reached.
		return ministerCountry:GetDailyBalance(goods):Get()
	end

	local today = math.mod(gDayCount, G_MEASURED_TIME_PERIOD)
	local yesterday = math.mod(gDayCount - 1, G_MEASURED_TIME_PERIOD)

	local sum = 0
	for i = 0, period - 1 do
		local stockToday = 0
		if gEconomy["stock"][key][goods][today] then
			stockToday = gEconomy["stock"][key][goods][today]
		end
		
		local stockYesterday = 0
		if gEconomy["stock"][key][goods][yesterday] then
			stockYesterday = gEconomy["stock"][key][goods][yesterday]
		end
		
		sum = sum + (stockToday - stockYesterday)
		today = Zmod(today - 1, G_MEASURED_TIME_PERIOD)
		yesterday = Zmod(yesterday - 1, G_MEASURED_TIME_PERIOD)
	end
	--Utils.LUA_DEBUGOUT(tostring(ministerCountry:GetCountryTag()).." GetAverageBalance: "..tostring(sum / period))
	return sum / period
end

-- Returns daily balance of a faction.
function GetFactionBalance(faction, goods)
	local sum = 0
	for countryTag in faction:GetMembers() do
		local country = countryTag:GetCountry()
		sum = sum + country:GetDailyBalance(goods)
	end
	return sum
end

function MinStock(country, goods)
	-- min for a 100 IC country in peace:
	-- 200 oil, rare
	-- 5k supply, fuel
	-- 500 energy and metal
	-- min for a 100 IC country in war:
	-- 400 oil, rare
	-- 10k supply, fuel
	-- 1k energy and metal
	local factor = ai_configuration.STOCKPILE_FACTOR/25 -- 2 -> oil, rare
	if goods == CGoodsPool._SUPPLIES_ or goods == CGoodsPool._FUEL_ then
		factor = ai_configuration.STOCKPILE_FACTOR -- 50
	elseif goods == CGoodsPool._METAL_ or goods == CGoodsPool._ENERGY_ then
		factor = ai_configuration.STOCKPILE_FACTOR/10 -- 5
	end
	if country:IsAtWar() or country:GetStrategy():IsPreparingWar() then
		return factor*2*country:GetTotalIC()
	end
	return factor*country:GetTotalIC()
end

function MaxStock(country, goods)
	if country:IsAtWar() or country:GetStrategy():IsPreparingWar() then
		return math.min(90000, 1000*country:GetTotalIC())
	end
	return math.min(90000, 500*country:GetTotalIC())
end

function HasMinStock(country, goods)
	return country:GetPool():Get( goods ):Get() > MinStock(country, goods)
end

function HasMaxStock(country, goods)
	return country:GetPool():Get( goods ):Get() > MaxStock(country, goods)
end

function Stock(country, goods)
	return country:GetPool():Get(goods):Get()
end

local _trade_cache = {}
function CalcImportExportTableImpl(country)
	local tagA = country:GetCountryTag()
	
	local result = {
		import = {},
		export = {}
	}
	
	for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
		result.import[goods] = 0
		result.export[goods] = 0
	end
	
	for countryB in CCurrentGameState.GetCountries() do
		local tagB = countryB:GetCountryTag()
		for route in country:GetRelation(tagB):GetTradeRoutes() do
			if route:IsValid() then
				for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
					local amount = route:GetTradedToOf(goods):Get()
					if amount > 0 then
						-- Import
						if route:GetConvoyResponsible() == tagA then
							result.import[goods] = result.import[goods] + amount
						-- Export
						else
							result.export[goods] = result.export[goods] + amount
						end
					end
				end
			end
		end
	end
	
	return result
end

function CalcImportExportTable(country, countryTag)
	local times = country:GetMaxIC()
	return CallTimesAYear(countryTag, times, CalcImportExportTableImpl, country)
end

function Importing(country, goods)
	local countryTag = country:GetCountryTag()
	local cache = CalcImportExportTable(country, countryTag)
	-- dtools.debug("Importing " .. cache.import[goods] .. " " .. GOODS_TO_STRING[goods], country, "DEVEL")
	return cache.import[goods]
end

function Exporting(country, goods)
	local countryTag = country:GetCountryTag()
	local cache = CalcImportExportTable(country, countryTag)
	-- dtools.debug("Exporting " .. cache.export[goods] .. " " .. GOODS_TO_STRING[goods], country, "DEVEL")
	return cache.export[goods]
end

function ExistsImport(country, goods)
	return (Importing(country, goods) > 0)
end

function ExistsExport(country, goods)
	return (Exporting(country, goods) > 0)
end

-- return true if country has money, makes money and doesn't overproduce CG to do so
function IsRich(AliceCountry)
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/AliceCountry:GetTotalIC()
	if	-- loaded bank account
		MoneyStockFactor > 5 and
		-- current cg setting less than 110% need or dissent (so high cg allowed if dissent)
		(AliceCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()*1.1 > AliceCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get() or
			AliceCountry:GetDissent():Get() > 0.01) and
		-- we can maintain our expenses for at least 100 days
		GetAverageBalance(AliceCountry, CGoodsPool._MONEY_) > -AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/100
	then
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsRich ")
		return true
	else
		-- If we're not importing anything other than supplies and have positive money balance
		-- we can consider ourselves as being rich.
		local importer = false
		local needResources = false
		for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
			if goods ~= CGoodsPool._SUPPLIES_ and goods ~= CGoodsPool._FUEL_ then
				if ExistsImport(AliceCountry, goods) then
					importer = true
					break
				end
				if GetAverageBalance(AliceCountry, goods) < 0 then
					needResources = true
					break
				end
			end
		end

		if 	not needResources and
			not importer and
			not ExistsExport(AliceCountry, CGoodsPool._SUPPLIES_) and
			GetAverageBalance(AliceCountry, CGoodsPool._MONEY_) > 0
		then
			--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsRich ")
			return true
		else
			--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." NOT IsRich ")
			return false
		end
	end
end

-- return true if country has barely money
function IsPoor(AliceCountry)
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/AliceCountry:GetTotalIC()
	if	MoneyStockFactor < 2
	and GetAverageBalance(AliceCountry, CGoodsPool._MONEY_) < 0
	then
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsPoor ")
		return true
	else
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." NOT IsPoor ")
		return false
	end
end

function IsResourceRich(country)
	-- Utils.LUA_DEBUGOUT("IsResourceRich started")
	local result = ExistsImport(country, CGoodsPool._ENERGY_) or (country:GetDailyBalance(CGoodsPool._ENERGY_):Get() <= 0)
	result = result or ExistsImport(country, CGoodsPool._METAL_) or (country:GetDailyBalance(CGoodsPool._METAL_):Get() <= 0)
	result = result or ExistsImport(country, CGoodsPool._RARE_MATERIALS_) or (country:GetDailyBalance(CGoodsPool._RARE_MATERIALS_):Get() <= 0)
	-- Utils.LUA_DEBUGOUT("IsResourceRich finished")
	return (not result)
end

function GetGoodsCost(goods)
	return gEconomy["goods_cost"][goods]
end

-------------------------------------------------------------------------------
-- END Trade specific functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- START Politics specific functions
-------------------------------------------------------------------------------

gPolitics = {}
gPolitics["law_tables"] = {}
gPolitics["law_group_tables"] = {}
gPoliticsInitialized = false

function HFInit_Politics()
	if gPoliticsInitialized then
		return
	end

	for law in CLawDataBase.GetLawList() do
		gPolitics["law_tables"][tostring(law:GetKey())] = law:GetIndex()
	end

	for group in CLawDataBase.GetGroups() do
		gPolitics["law_group_tables"][tostring(group:GetKey())] = group:GetIndex()
	end

	gPoliticsInitialized = true
end

function GetLawIndexByName(name)
	HFInit_Politics() -- Make sure gPolitics["law_tables"] is set up properly
	if gPolitics["law_tables"][name] then
		return gPolitics["law_tables"][name]
	else
		return 0 -- Index for no law
	end
end

function GetLawGroupIndexByName(name)
	HFInit_Politics() -- Make sure gPolitics["law_group_tables"] is set up properly
	if gPolitics["law_group_tables"][name] then
		return gPolitics["law_group_tables"][name]
	else
		return 0 -- Index for no law group
	end
end

-------------------------------------------------------------------------------
-- END Politics specific functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- START Tech specific functions
-------------------------------------------------------------------------------

gTech = {}
gTech["tech_table"] = {}
gTechInitialized = false

function HFInit_Tech()
	if gTechInitialized then
		return
	end

	for tech in CTechnologyDataBase.GetTechnologies() do
		gTech["tech_table"][tostring(tech:GetKey())] = tech
	end

	gTechInitialized = true
end

function GetTechByName(name)
	HFInit_Tech() -- Make sure gTech["tech_table"] is set up properly
	if gTech["tech_table"][name] then
		return gTech["tech_table"][name]
	else
		return nil
	end
end

-------------------------------------------------------------------------------
-- END Tech specific functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- START Diplomacy specific functions
-------------------------------------------------------------------------------

function GetWarRunningTime(tag1, tag2)
	local tag1Country = tag1:GetCountry()
	for diploStatus in tag1Country:GetDiplomacy() do
		local target = diploStatus:GetTarget()
		if target:IsValid() and diploStatus:HasWar() then
			local war = diploStatus:GetWar()
			if war:IsPartOfWar(tag2) then
				--If at war with tag2, return running time in months
				return war:GetCurrentRunningTimeInMonths()
			end
		end
	end
	return 0
end
-------------------------------------------------------------------------------
-- END Diplomacy specific functions
-------------------------------------------------------------------------------
