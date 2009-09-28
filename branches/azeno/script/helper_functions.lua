-- Trade specific global variables and constants.
local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

gGLOBALS = {
	day_count = -1,
	stockpile = {},
	trading_countries_ai = {},
	trading_countries_human = {},
	goods_cost = {
		[0] = 	defines.goods_cost.SUPPLIES,
				defines.goods_cost.FUEL,
				defines.goods_cost.MONEY,
				defines.goods_cost.CRUDE_OIL,
				defines.goods_cost.METAL,
				defines.goods_cost.ENERGY,
				defines.goods_cost.RARE_MATERIALS
	},
	interval_trees = {},
	traded_goods = {},
	law_tables = {}
}

-------------------------------------------------------------------------------
-- START Common helper functions
-------------------------------------------------------------------------------

-- Red Black tree
IntervalNode = { }
function IntervalNode.New(low, high, data)
	return {
		p = nil,
		left = nil,
		right = nil,
		key = low,
		color = false,
		int = { low, high },
		max = high,
		data = data
	}
end

IntervalTree = { }
function IntervalTree.New()
	local n = IntervalNode.New(0, 0, nil)
	n.p = n
	n.left = n
	n.right = n

	return {
		nil_node = n,
		root = n
	}
end

function IntervalTree.UpdateMaxField(T, x)
	x.max = math.max(x.int[2], x.left.max, x.right.max)
end

function IntervalTree.Overlaps(a, b)
	return (a[1] <= b[2]) and (b[1] <= a[2])
end

-- Returns first overlapping interval or T.nil_node
function IntervalTree.IntervalSearch(T, i)
	local x = T.root
	while (x ~= T.nil_node) and not IntervalTree.Overlaps(i, x.int) do
		if (x.left ~= T.nil_node) and (x.left.max >= i[1]) then
			x = x.left
		else
			x = x.right
		end
	end
	return x
end

-- Returns all overlapping intervals or empty list
function IntervalTree.GetOverlappingIntervals(T, i)
	local results = {}

	if T ~= nil then
		IntervalTree.IntervalSearchAll(T, T.root, i, results)
	else
		Utils.LUA_DEBUGOUT("Interval tree is nil!")
	end

	return results
end

function IntervalTree.IntervalSearchAll(T, n, i, results)
	if (n == nil) or (n == T.nil_node) then
		return
	end

	if i[1] > n.max then
		return
	end
	IntervalTree.IntervalSearchAll(T, n.left, i, results)

	if IntervalTree.Overlaps(n.int, i) then
		table.insert(results, n)
	end

	if i[2] < n.int[1] then
		return
	end
	IntervalTree.IntervalSearchAll(T, n.right, i, results)
end

function IntervalTree.LeftRotate(T, x)
	local y = x.right
	x.right = y.left
	if y.left ~= T.nil_node then
		y.left.p = x
	end
	y.p = x.p
	if x.p == T.nil_node then
		T.root = y
	else
		if x == x.p.left then
			x.p.left = y
		else
			x.p.right = y
		end
	end
	y.left = x
	x.p = y

	IntervalTree.UpdateMaxField(T, x)
	IntervalTree.UpdateMaxField(T, y)
end

function IntervalTree.RightRotate(T, x)
	local y = x.left
	x.left = y.right
	if y.right ~= T.nil_node then
		y.right.p = x
	end
	y.p = x.p
	if x.p == T.nil_node then
		T.root = y
	else
		if x == x.p.right then
			x.p.right = y
		else
			x.p.left = y
		end
	end
	y.right = x
	x.p = y

	IntervalTree.UpdateMaxField(T, x)
	IntervalTree.UpdateMaxField(T, y)
end

function IntervalTree.Insert(T, z)
	local y = T.nil_node
	local x = T.root
	while x ~= T.nil_node do
		y = x
		y.max = math.max(y.max, z.max)
		if z.key < x.key then
			x = x.left
		else
			x = x.right
		end
	end
	z.p = y
	if y == T.nil_node then
		T.root = z
	else
		if z.key < y.key then
			y.left = z
		else
			y.right = z
		end
	end
	z.left = T.nil_node
	z.right = T.nil_node
	z.color = true
	IntervalTree.InsertFixup(T, z)
end

function IntervalTree.InsertFixup(T, z)
	while z.p.color == true do
		if z.p == z.p.p.left then
			local y = z.p.p.right
			if y.color == true then
				z.p.color = false
				y.color = false
				z.p.p.color = true
				z = z.p.p
			else
				if z == z.p.right then
					z = z.p
					IntervalTree.LeftRotate(T, z)
				end
				z.p.color = false
				z.p.p.color = true
				IntervalTree.RightRotate(T, z.p.p)
			end
		else
			local y = z.p.p.left
			if y.color == true then
				z.p.color = false
				y.color = false
				z.p.p.color = true
				z = z.p.p
			else
				if z == z.p.left then
					z = z.p
					IntervalTree.RightRotate(T, z)
				end
				z.p.color = false
				z.p.p.color = true
				IntervalTree.LeftRotate(T, z.p.p)
			end
		end
	end
	T.root.color = false
end

function GetDayCount()
	return gGLOBALS["day_count"]
end

function IsValidCountry(country)
	local countryTag = country:GetCountryTag()
	return countryTag:IsReal() and countryTag:IsValid() and country:Exists()
end

function GetAverageInfrastructure(country)
	if IsValidCountry(country) then
		local provinceCount = 0
		local infrastructure = 0
		for provinceId in country:GetOwnedProvinces() do
			local province = CCurrentGameState.GetProvince(provinceId)
			infrastructure = infrastructure + province:GetInfrastructure():Get()
			provinceCount = provinceCount + 1
		end

		if provinceCount > 0 then
			return infrastructure / provinceCount
		else
			return 0
		end
	else
		return 1
	end
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
	return (icToCG * 100) / ai_configuration.G_MAX_GC_OVER_PRODUCTION
end

-- Returns stockpile for given goods.
function GetStock(ministerCountry, goods)
	local pool = ministerCountry:GetPool()
	return pool:Get(goods):Get()
end

-- Returns targeted stockpile for given goods.
function GetTargetStock(ministerCountry, goods)
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

-- Must be called by ForeignMinister_ManageTrade
function HFInit_ManageTrade(ai, ministerTag)
	-- Update gGLOBALS["stockpile"] once a day for all countries
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	if tostring(ministerTag) == '---' then -- Always first country called a day
		gGLOBALS["day_count"] = gGLOBALS["day_count"] + 1

		gGLOBALS["trading_countries_human"] = {}

		-- Init interval trees for all goods
		for goods = 0, MAX_GOODS do
			gGLOBALS["interval_trees"][goods] = IntervalTree.New()
		end

		local counter = 0

		local day = math.mod(gGLOBALS["day_count"], ai_configuration.G_MEASURED_TIME_PERIOD) -- Measuring a period of G_MEASURED_TIME_PERIOD days
		for country in CCurrentGameState.GetCountries() do
			local countryTag = country:GetCountryTag()

			if IsValidCountry(country) then
				local key = tostring(countryTag)

				if gGLOBALS["stockpile"][key] == nil then
					gGLOBALS["stockpile"][key] = {}
					Utils.LUA_DEBUGOUT("gGLOBALS[\"stockpile\"] for " .. key .. " not set!")
				end

				local pool = country:GetPool()

				for goods = 0, MAX_GOODS do
					if gGLOBALS["stockpile"][key][goods] == nil then
						gGLOBALS["stockpile"][key][goods] = {}
					end

					gGLOBALS["stockpile"][key][goods][day] = pool:Get(goods):Get()

					-- Put all average balance of this country into our interval tree
					-- to get a very fast trading partner lookup when a country tries
					-- to buy or sell goods.
					if goods ~= CGoodsPool._MONEY_ then
						local tradeInterval = GetInverseTradeInterval(country, goods)
						if (tradeInterval[1] ~= 0) then
							local node = IntervalNode.New(tradeInterval[1], tradeInterval[2], country)
							IntervalTree.Insert(gGLOBALS["interval_trees"][goods], node)
							counter = counter + 1
						end
					end
				end

				if gGLOBALS["trading_countries_ai"][key] == nil then
					gGLOBALS["trading_countries_human"][key] = key
				end
			end
		end

		--Utils.LUA_DEBUGOUT("#IntervalTree.Insert called: " .. tostring(counter))

		gGLOBALS["trading_countries_ai"]= {}
	end

	-- Add this country to the list of AI controlled countries
	gGLOBALS["trading_countries_ai"][tostring(ministerTag)] = tostring(ministerTag)
end

-- Sets up the gGLOBALS["traded_goods"] table.
-- Called from EvaluateExistingTrades.
function HFInit_TradedGoods(countryTag)
	local key = tostring(countryTag)
	if gGLOBALS["traded_goods"][key] == nil then
		gGLOBALS["traded_goods"][key] = {}
	end

	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	for goods = 0, MAX_GOODS do
		gGLOBALS["traded_goods"][key][goods] = 0
	end
end

-- Amount > 0 if we buy
--		  < 0 if we sell
-- Called from EvaluateExistingTrades.
function HFUpdate_TradedGoods(countryTag, goods, amount)
	local key = tostring(countryTag)
	gGLOBALS["traded_goods"][key][goods] = gGLOBALS["traded_goods"][key][goods] + amount
end

-- Returns traded amount of given goods.
-- Amount is > 0 if we buy, and < 0 if we sell.
-- Note: This function will always return 0 as long as HFInit_TradedGoods and
-- HFUpdate_TradedGoods are not called.
function GetTradedAmount(country, goods)
	local key = tostring(country:GetCountryTag())
	if gGLOBALS["traded_goods"][key] == nil then
		return 0
	end

	return gGLOBALS["traded_goods"][key][goods]
end

function GetTradeInterval(country, goods)
	local totalICOfAlice = country:GetTotalIC()
	local desire = (GetDesireInGoods(country, goods) + 1) / 2
	local stock = GetStock(country, goods)
	local minTradingAmount = math.min(totalICOfAlice / 11, 5)
	local tradingAmount = math.min(-GetAverageBalance(country, goods), 50)

	if tradingAmount < 0 then
		if math.abs(tradingAmount) < minTradingAmount then
			if desire > ai_configuration.TRADING_THRESHOLD then
				minTradingAmount = tradingAmount
				tradingAmount = tradingAmount * 1.1
			end
		end
	end

	-- Money is a special case
	if goods == CGoodsPool._MONEY_ then
		if tradingAmount < 0 then
			-- we do have money
			minTradingAmount = tradingAmount * (1 - desire) -- buy goods till up to this amount
		else
			 -- we don't have money
			minTradingAmount = -minTradingAmount -- do not buy goods
		end
		tradingAmount = 99999 -- we never say no to money
	else
		if goods == CGoodsPool._SUPPLIES_ then
			-- Also take target stockpile into account so that rich countries,
			-- like USA will also buy large amounts even if they have a positive
			-- balance.
			local targetStock = GetTargetStock(country, goods)
			local stock = GetStock(country, goods)
			tradingAmount = tradingAmount + math.max((targetStock - stock) / 100, 0)

			if (tradingAmount > 0) then
				-- Only buy if we've some money
				local desireInMoney = GetDesireInGoods(country, CGoodsPool._MONEY_)
				if desireInMoney > -0.1 then
					tradingAmount = 0
				else
					-- Money is fine, but now let's see where the money is coming from
					local tradedSupplies = GetTradedAmount(country, goods)
					if tradedSupplies < 0 then
						tradingAmount = 0
					else
						-- Don't make too heavy deals
						tradingAmount = tradingAmount * math.abs(desireInMoney)
					end
				end
			end
		else
			if (stock == 0) then
				-- Stock is empty
				tradingAmount = minTradingAmount * 2
			end
		end

		if (tradingAmount < 0) then -- We're selling
			minTradingAmount = -minTradingAmount
			-- Don't sell too much
			tradingAmount = tradingAmount * (1 - desire)
		end
	end

	local low = 0
	local high = 0
	if math.abs(tradingAmount) > math.abs(minTradingAmount) then
		low = math.min(minTradingAmount, tradingAmount)
		high = math.max(minTradingAmount, tradingAmount)
	end

	--if tostring(country:GetCountryTag()) == 'GER' and goods == CGoodsPool._ENERGY_ then
		--Utils.LUA_DEBUGOUT("desire " .. tostring(desire))
		--Utils.LUA_DEBUGOUT("stock " .. tostring(GetStock(country, goods)))
		--Utils.LUA_DEBUGOUT("minTradingAmount " .. tostring(minTradingAmount))
		--Utils.LUA_DEBUGOUT("tradingAmount " .. tostring(tradingAmount))
		--Utils.LUA_DEBUGOUT("low " .. tostring(low))
		--Utils.LUA_DEBUGOUT("high " .. tostring(high))
	--end

	return {low, high}
end

function GetInverseTradeInterval(country, goods)
	local tradeInterval = GetTradeInterval(country, goods)
	return {-tradeInterval[2], -tradeInterval[1]}
end

-- Returns average balance of given goods.
-- G_AVERAGING_TIME_PERIOD defines how much days are averaged.
-- Note: This function needs some days to return good results.
function GetAverageBalance(ministerCountry, goods)
	key = tostring(ministerCountry:GetCountryTag())
	if gGLOBALS["stockpile"][key] == nil then
		-- HFInit_ManageTrade wasn't called yet.
		return 0
	end

	period = math.min(gGLOBALS["day_count"], ai_configuration.G_AVERAGING_TIME_PERIOD)
	if period == 0 then
		return 0 -- we have nothing to compare with
	end

	today = math.mod(gGLOBALS["day_count"], ai_configuration.G_MEASURED_TIME_PERIOD)
	yesterday = math.mod(gGLOBALS["day_count"] - 1, ai_configuration.G_MEASURED_TIME_PERIOD)

	if gGLOBALS["stockpile"][key][goods][today] > 99000 then
		return 50
	end

	sum = 0
	for i = 0, period - 1 do
		sum = sum + (gGLOBALS["stockpile"][key][goods][today] - gGLOBALS["stockpile"][key][goods][yesterday])
		today = Zmod(today - 1, ai_configuration.G_MEASURED_TIME_PERIOD)
		yesterday = Zmod(yesterday - 1, ai_configuration.G_MEASURED_TIME_PERIOD)
	end

	return sum / period
end

-- Returns a score between 1 and -1, the former for goods we're lacking
-- and the latter for goods we have too much of.
function GetDesireInGoods(ministerCountry, goods)
	local stock = GetStock(ministerCountry, goods)
	local targetStock = GetTargetStock(ministerCountry, goods)

	if goods == CGoodsPool._FUEL_ then
		-- Also take oil into account
		stock = stock + GetStock(ministerCountry, CGoodsPool._CRUDE_OIL_)
	end

	local stockRatio = stock / targetStock
	return math.pow(2, (-stockRatio * stockRatio) + 1) - 1
end

-- Returns true if trade of given country is controlled by human.
-- This function needs one day to return correct results;
-- will always return true on first day (gGLOBALS["day_count"] == 0).
-- If trade automation is turned on by human player on day n
-- correct results are returned on day n + 2.
function IsTradeControlledByHuman(countryTag)
	key = tostring(countryTag)
	if gGLOBALS["trading_countries_human"][key] then
		return true
	else
		return false
	end
end

function GetTradePrice(ai, aliceTag, bobTag, goods)
	HFInit_Trade()

	local basePrice = gGLOBALS["goods_cost"][goods]
	local relations = ai:GetRelation(aliceTag, bobTag):GetValue():Get()

	-- From http://www.paradoxian.org/hoi3wiki/Trade_prices
	-- Price = Base Price * ( 1 - Relations * .00165)
	return basePrice * (1 - relations * 0.00165)
end

function GetGoodsCost(goods)
	return gGLOBALS["goods_cost"][goods]
end

-------------------------------------------------------------------------------
-- END Trade specific functions
-------------------------------------------------------------------------------

-------------------------------------------------------------------------------
-- START Politics specific functions
-------------------------------------------------------------------------------

function HFInit_Politics()
	if table.getn(gGLOBALS["law_tables"]) > 0 then
		return
	end

	for law in CLawDataBase.GetLawList() do
		gGLOBALS["law_tables"][tostring(law:GetKey())] = law:GetIndex()
	end
end

function GetLawIndexByName(name)
	HFInit_Politics() -- Make sure gGLOBALS["law_tables"] is set up properly
	if gGLOBALS["law_tables"][name] then
		return gGLOBALS["law_tables"][name]
	else
		return 0 -- Index for no law
	end
end

-------------------------------------------------------------------------------
-- END Politics specific functions
-------------------------------------------------------------------------------
