local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

-------------------------------------------------------------------------------
-- START Common helper functions
-------------------------------------------------------------------------------

gCommon = {}
gCommon["average_infra"] = {}
function IsValidCountry(country)
	local countryTag = country:GetCountryTag()
	return countryTag:IsReal() and countryTag:IsValid() and country:Exists()
end

function GetAverageInfrastructure(country)
	if IsValidCountry(country) then
		local key = tostring(country:GetCountryTag())
		-- re-calculate occasionally
		if gCommon["average_infra"][key] and 0~= math.mod( CCurrentGameState.GetAIRand(), 25) then
			return gCommon["average_infra"][key]
		end

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

		gCommon["average_infra"][key] = result
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
gEconomy["import"] = {}
gEconomy["export"] = {}
gEconomy["stock"] = {}
gEconomy["AI"] = {}
gEconomy["manual"] = {}
gDayCount = -1
G_MEASURED_TIME_PERIOD = 8 -- For how many days are we accounting for
G_AVERAGING_TIME_PERIOD = 7 -- How many days are averaged (must be < G_MEASURED_TIME_PERIOD)
G_MAX_GC_OVER_PRODUCTION = 15 -- How much IC are allowed to put into GC in %
TRADING_THRESHOLD = 0.4

-- Must be called by ForeignMinister_ManageTrade
function HFInit_ManageTrade(ai, ministerTag)
	-- Update gEconomy["stock"] once a day for all countries
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	if tostring(ministerTag) == '---' then -- Always first country called a day
		gDayCount = gDayCount + 1
		--Utils.LUA_DEBUGOUT("--> Day " .. tostring(gDayCount))
		-- save today's trades
		BufferingTrades()
		-- reset 'today'
		gEconomy["manual"] = {}

		day = math.mod(gDayCount, G_MEASURED_TIME_PERIOD) -- Measuring a period of G_MEASURED_TIME_PERIOD days
		for country in CCurrentGameState.GetCountries() do
			countryTag = country:GetCountryTag()

			if countryTag:IsReal() and countryTag:IsValid()
				and country:Exists()
			then
				strCountryTag = tostring(countryTag)
				--Utils.LUA_DEBUGOUT(strCountryTag)

				if gEconomy["stock"][strCountryTag] == nil then
					gEconomy["stock"][strCountryTag] = {}
					--Utils.LUA_DEBUGOUT("gEconomy["stock"] for " .. strCountryTag .. " not set!")
				end

				local pool = country:GetPool()

				for goods = 0, MAX_GOODS do
					if gEconomy["stock"][strCountryTag][goods] == nil then
						gEconomy["stock"][strCountryTag][goods] = {}
					end

					gEconomy["stock"][strCountryTag][goods][day] = pool:Get(goods):Get()

					--Utils.LUA_DEBUGOUT("	" .. GOODS_TO_STRING[goods] .. " - Income: " .. country:GetDailyIncome(goods):Get() .. " Expense: " .. country:GetDailyExpense(goods):Get() .. " Balance: " .. country:GetDailyBalance(goods):Get())
				end
				-- if country was not AI controlled 'yesterday'
				if gEconomy["AI"][strCountryTag] == nil then
					-- add country to list of manual (human) trading countries
					gEconomy["manual"][strCountryTag] = strCountryTag
					--Utils.LUA_DEBUGOUT("Trade of " .. strCountryTag .. " is controlled by human player.")
				end
			end
		end
		-- reset for 'tomorrow'
		gEconomy["AI"] = {}
	end

	-- Add this country to the list of AI controlled countries
	gEconomy["AI"][tostring(ministerTag)] = tostring(ministerTag)
end

--~ function TradeSpam( goods, BuyerCountry, SellerCountry)
--~ 	if not gEconomy["deal"][goods] then
--~ 		gEconomy["deal"][goods] = {}
--~ 	end
--~ 	if not gEconomy["deal"][goods][BuyerCountry] then
--~ 		gEconomy["deal"][goods][BuyerCountry] = {}
--~ 	end
--~ 	if not gEconomy["deal"][goods][BuyerCountry][SellerCountry] then
--~ 		gEconomy["deal"][goods][BuyerCountry][SellerCountry] = gDayCount-30
--~ 	end
--~ 	-- less than 30 days ago?
--~ 	if gEconomy["deal"][goods][BuyerCountry][SellerCountry] > gDayCount-30 then
--~ 		Utils.LUA_DEBUGOUT(tostring(gDayCount)..": "..tostring(SellerCountry:GetCountryTag()).." tries to SPAM "..tostring(BuyerCountry:GetCountryTag()).." with "
--~ 			..tostring( GOODS_TO_STRING[goods]).." after only "
--~ 			..tostring(gDayCount-gEconomy["deal"][goods][BuyerCountry][SellerCountry]).." days!")
--~ 		return true
--~ 	else -- ok
--~ 		return false
--~ 	end
--~ end

--~ function TradeSpamSet(goods, BuyerCountry, SellerCountry)
--~ 	--Utils.LUA_DEBUGOUT(tostring(gDayCount)..": "..tostring(SellerCountry:GetCountryTag()).." trying to sell to "..tostring(BuyerCountry:GetCountryTag()).." some "..tostring( GOODS_TO_STRING[goods]))
--~ 	gEconomy["deal"][goods][BuyerCountry][SellerCountry] = gDayCount
--~ 	--Utils.LUA_DEBUGOUT(tostring(gDayCount)..": ".."---")
--~ end

function BufferingTrades()
	--Utils.LUA_DEBUGOUT("->BufferingTrades")
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	gEconomy["import"] = {}
	gEconomy["export"] = {}
	gEconomy["trade_routes"] = {}
	local Iters = 0
	local Counter = 0
	for AliceCountry in CCurrentGameState.GetCountries() do
		local AliceTag = AliceCountry:GetCountryTag()
		gEconomy["trade_routes"][tostring(AliceTag)] = {}

		for BobCountry in CCurrentGameState.GetCountries() do
			local BobTag = BobCountry:GetCountryTag()
			--if tostring(BobTag) ~= tostring(AliceTag) then
				for route in AliceCountry:GetRelation( BobTag ):GetTradeRoutes() do
					if route:IsValid() then
						table.insert(gEconomy["trade_routes"][tostring(AliceTag)], route)
						if Counter < Iters then
							for goods = 0, MAX_GOODS do
								if goods ~= CGoodsPool._MONEY_ then
									local switch = false
									local Bob2Alice = route:GetTradedToOf(goods):Get()
									--local Alice2Bob = route:GetTradedFromOf(goods):Get()
									if  0~=Bob2Alice then
										-- direction?
										if tostring(route:GetConvoyResponsible()) == tostring(BobTag) and Bob2Alice>0 then
											--Utils.LUA_DEBUGOUT("Switch (1)")
											--Alice2Bob, Bob2Alice = Bob2Alice, Alice2Bob
											AliceTag, BobTag = BobTag, AliceTag
											switch = true
										end
										-- if tostring(route:GetConvoyResponsible()) == tostring(AliceTag) and Alice2Bob>0 then
											-- Utils.LUA_DEBUGOUT("Switch (2)")
											-- Alice2Bob, Bob2Alice = Bob2Alice, Alice2Bob
										-- end
										-- ok Bob sends to ALice
										if Bob2Alice>0 then
											-- Utils.LUA_DEBUGOUT(tostring(AliceTag).." 2 "..tostring(BobTag).." (1) "..tostring(Alice2Bob).." "..tostring( GOODS_TO_STRING[goods]))
										-- else
											--Utils.LUA_DEBUGOUT(tostring(BobTag).." 2 "..tostring(AliceTag).." (2) "..tostring(Bob2Alice).." "..tostring( GOODS_TO_STRING[goods]))
										end

										-- if Bob2Alice > 0 then
											-- AliceTag, BobTag = BobTag, AliceTag
										-- end
										if nil == gEconomy["export"][goods] then
											gEconomy["import"][goods] = {}
											gEconomy["export"][goods] = {}
										end
										if nil == gEconomy["export"][goods][tostring(BobTag)] then
											gEconomy["export"][goods][tostring(BobTag)] = {}
										end
										if nil == gEconomy["import"][goods][tostring(AliceTag)] then
											gEconomy["import"][goods][tostring(AliceTag)] = {}
										end
										gEconomy["export"][goods][tostring(BobTag)][tostring(AliceTag)]= Bob2Alice
										gEconomy["import"][goods][tostring(AliceTag)][tostring(BobTag)] = Bob2Alice
										-- reverse switch
										if switch then
											--Utils.LUA_DEBUGOUT("Switch (2)")
											--Alice2Bob, Bob2Alice = Bob2Alice, Alice2Bob
											AliceTag, BobTag = BobTag, AliceTag
										end
									end
								end
							end
						end
					end
				--end
			end
			Counter = Counter + 1
		end
		Iters = Iters + 1
		Counter = 0
	end
	--Utils.LUA_DEBUGOUT("<-BufferingTrades")
end

-- Returns true if trade of given country is controlled by human.
-- Note: This function needs one day to return correct results;
-- 		 will always return true on first day (gDayCount == 0).
function IsTradeControlledByHuman(countryTag)
	key = tostring(countryTag)
	if gEconomy["manual"][key] then
		return true
	else
		return false
	end
end

-- Returns average balance of given goods.
-- G_AVERAGING_TIME_PERIOD defines how much days are averaged.
-- Note: This function needs some days to return good results.
function GetAverageBalance(ministerCountry, goods)
	key = tostring(ministerCountry:GetCountryTag())
	if gEconomy["stock"][key] == nil then
		--Utils.LUA_DEBUGOUT(tostring(ministerCountry:GetCountryTag()).." GetAverageBalance - HFInit_ManageTrade wasn't called yet.")
		-- HFInit_ManageTrade wasn't called yet.
		return 0
	end

	period = math.min(gDayCount, G_AVERAGING_TIME_PERIOD)
	if period == 0 then
		--Utils.LUA_DEBUGOUT(tostring(ministerCountry:GetCountryTag()).." GetAverageBalance - No data yet!")
		return 0 -- we have nothing to compare with
	end

	today = math.mod(gDayCount, G_MEASURED_TIME_PERIOD)
	yesterday = math.mod(gDayCount - 1, G_MEASURED_TIME_PERIOD)

	sum = 0
	for i = 0, period - 1 do
		sum = sum + (gEconomy["stock"][key][goods][today] - gEconomy["stock"][key][goods][yesterday])
		today = Zmod(today - 1, G_MEASURED_TIME_PERIOD)
		yesterday = Zmod(yesterday - 1, G_MEASURED_TIME_PERIOD)
	end
	--Utils.LUA_DEBUGOUT(tostring(ministerCountry:GetCountryTag()).." GetAverageBalance: "..tostring(sum / period))
	return sum / period
end

-- Returns how much percent of ic is put into money production.
-- Value is between 0.0 and 1.0
function GetCGOverProductionRatio(ministerCountry)
	local totalIC = ministerCountry:GetTotalIC()
	local cgNeeded = ministerCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()
	local cgActual = ministerCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()
	return math.max((cgActual - cgNeeded) / totalIC, 0)
end

-- Penalty is 100% if ic put into cg reaches G_MAX_GC_OVER_PRODUCTION.
function GetCGOverProductionPenalty(ministerCountry)
	local icToCG = GetCGOverProductionRatio(ministerCountry)
	return icToCG * G_MAX_GC_OVER_PRODUCTION
end

-- Returns targeted stockpile for given goods.
function GetTargetStock(ministerCountry, goods)
	local pool = ministerCountry:GetPool()
	local totalIC = ministerCountry:GetTotalIC()
	local days = 100

	local targetStock = totalIC * days
	if goods == CGoodsPool._METAL_ then
		targetStock = targetStock / 2
	elseif goods == CGoodsPool._RARE_MATERIALS_ then
		targetStock = targetStock / 4
	elseif goods == CGoodsPool._FUEL_ then
		targetStock = targetStock * 2
	elseif goods == CGoodsPool._MONEY_ then
		targetStock = totalIC * 2
	end

	return targetStock
end

-- Returns a score between 1 and -1, the former for goods we're lacking
-- and the latter for goods we have stockpiled.
function GetDesireInGoods(ministerCountry, goods)
	local pool = ministerCountry:GetPool()
	local totalIC = ministerCountry:GetTotalIC()
	local stock = pool:Get(goods):Get()
	local balance = GetAverageBalance(ministerCountry, goods)
	local targetStock = GetTargetStock(ministerCountry, goods)

	if goods == CGoodsPool._FUEL_ then
		-- Also take oil into account
		stock = stock + pool:Get(CGoodsPool._CRUDE_OIL_):Get()
		balance = balance + GetAverageBalance(ministerCountry, CGoodsPool._CRUDE_OIL_)
	end

	factorStock = math.min((stock / targetStock) - 1, 1.0) * -1.0
	factorBalance = math.min(math.max(balance / totalIC, -1.0), 1.0) * -1.0

	return math.min(math.max(factorStock + factorBalance, -1.0), 1.0)
end

-- Returns a score between 1 and -1, the former for goods we want to buy
-- and the latter for goods we want to sell.
function GetTradeDesireInGoods(ministerCountry, goods)
	local score = GetDesireInGoods(ministerCountry, goods)

	-- The more we're overproducing the more we want to get rid of those expensive goods.
	if (goods == CGoodsPool._FUEL_) or (goods == CGoodsPool._CRUDE_OIL_) then
		local penalty = GetCGOverProductionPenalty(ministerCountry)
		score = math.max(score * (1 - penalty), -1)
	elseif (goods == CGoodsPool._SUPPLIES_) then
		-- We're interested in supplies if we have a lot of money.
		local desireInMoney = math.min(GetDesireInGoods(ministerCountry, CGoodsPool._MONEY_), 0.0) * -1
		local blendFactor = desireInMoney
		score = (1 - blendFactor) * score + blendFactor * desireInMoney
	end

	return score
end

-- Returns the needed amount of goods. Amount is positive if
-- the given country wants these goods and amount is negative if
-- it wants to get rid of these goods.
function GetNeededAmountOfGoods(ministerCountry, goods)
	local pool = ministerCountry:GetPool()
	local stock = pool:Get(goods):Get()
	local targetStock = GetTargetStock(ministerCountry, goods)
	local balance = GetAverageBalance(ministerCountry, goods)

	local period = 365 -- we want to reach targeted stockpile in one year
	if goods == CGoodsPool._MONEY_ then
		period = 14 -- in case of money in two weeks
	end

	local amount = (targetStock - stock) / period
	amount = amount - balance

	return amount
end

-- Returns the needed amount of goods. Amount is positive if
-- the given country wants these goods and amount is negative if
-- it wants to get rid of these goods.
-- This function will also take the countries money production
-- into account for all the expensive goods like oil, fuel and supplies.
function GetNeededTradeAmountOfGoods(ministerCountry, goods)
	local amount = GetNeededAmountOfGoods(ministerCountry, goods)

	if (goods == CGoodsPool._CRUDE_OIL_) or (goods == CGoodsPool._FUEL_) or (goods == CGoodsPool._SUPPLIES_) then
		local desire = GetTradeDesireInGoods(ministerCountry, goods)
		--amount = math.abs(amount) * desire
		if desire > 0 then
			-- Only buy so much goods we can pay for
			local dailyMoney = GetAverageBalance(ministerCountry, CGoodsPool._MONEY_)
			local cost = defines.goods_cost.CRUDE_OIL
			if goods == CGoodsPool._FUEL_ then
				cost = defines.goods_cost.FUEL
			elseif goods == CGoodsPool._SUPPLIES_ then
				cost = defines.goods_cost.SUPPLIES
			end
			amount = math.max(dailyMoney / cost, 0.5) -- dailyMoney could be < 0
			amount = amount * (1 + desire)
		end
	end

	return amount
end

-- Returns value between 0 (bad) and 1 (good).
function GetTradingScore(ministerCountry, goods, amount)
	local targetAmount = GetNeededTradeAmountOfGoods(ministerCountry, goods)
	if targetAmount == 0 then
		return 0
	end

	if math.abs(targetAmount - amount) > math.abs(targetAmount) then
		return 0
	end

	local x = math.abs(amount / targetAmount)
	--local score = 1.0 - math.abs(math.min(math.max((targetAmount - amount) / targetAmount, -1.0), 1.0))
	--return math.min(math.max(2 * math.pow(x, 0.5) - math.pow(x, 8), 0), 1)
	if x <= 1 then
		return math.pow(x, 1 / 7)
	else
		return 1 / math.pow(x, 4)
	end
end

-- return true if country has money, makes money and doesn't overproduce CG to do so
function IsRich(AliceCountry)
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/AliceCountry:GetTotalIC()
	if	-- loaded bank account
		MoneyStockFactor > 5 and
		-- current cg setting less than 110% need or dissent (so high cg allowed if dissent)
		(AliceCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()*1.1 > AliceCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get() or
			AliceCountry:GetDissent():Get() > 0.01)
	then
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsRich ")
		return true
	else
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." NOT IsRich ")
		return false
	end
end

-- return true if country has barely money
function IsPoor(AliceCountry)
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/AliceCountry:GetTotalIC()
	if	MoneyStockFactor < 2
	then
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsPoor ")
		return true
	else
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." NOT IsPoor ")
		return false
	end
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
