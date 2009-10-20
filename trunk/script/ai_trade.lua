require('utils')
require('helper_functions')

local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function ForeignMinister_ManageTrade(ai, ministerTag)
	HFInit_ManageTrade(ai, ministerTag)
 	--if 'FRA' == tostring(ministerTag) then
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_SUPPLIES_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._SUPPLIES_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_FUEL_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._FUEL_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_MONEY_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._MONEY_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_CRUDE_OIL_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._CRUDE_OIL_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_METAL_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._METAL_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_ENERGY_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._ENERGY_)))
 		--Utils.LUA_DEBUGOUT(tostring(ministerTag).." GetAverageBalance(_RARE_MATERIALS_): " .. tostring(GetAverageBalance(ministerTag:GetCountry(), CGoodsPool._RARE_MATERIALS_)))
 		--Utils.LUA_DEBUGOUT(" - - - - - - - - ")
 	--end
	-- skip first week, config chance, only valid countries
	if	gDayCount > 6 and
		math.mod( CCurrentGameState.GetAIRand(), ai_configuration.TRADE_DELAY) == 0 and
		IsValidCountry(ministerTag:GetCountry()) then
		if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
			-- 1 out of 3
			EvalutateExistingTrades(ai, ministerTag)
		else
			-- 2 out of 3
			ProposeTrades(ai, ministerTag)
		end
	end
end

function EvalutateExistingTrades(ai, AliceTag)
	-- if IsTradeControlledByHuman(AliceTag) then
		-- Utils.LUA_DEBUGOUT(tostring(AliceTag).." is HUMAN o_O")
		-- return
	-- end
	local tradeRoutes = {}
	local AliceKey = tostring(AliceTag)
	if gEconomy["trade_routes"] and gEconomy["trade_routes"][AliceKey] then
		tradeRoutes = gEconomy["trade_routes"][AliceKey]
	end

	local AliceCountry = AliceTag:GetCountry()
	if AliceCountry:isPuppet() then
		return -- Trading with puppet nations seriously bugged in 1.2. Wait for 1.3
	end

	local evaluationOrder = {
		CGoodsPool._FUEL_,
		CGoodsPool._CRUDE_OIL_,
		CGoodsPool._SUPPLIES_,
		CGoodsPool._RARE_MATERIALS_,
		CGoodsPool._METAL_,
		CGoodsPool._ENERGY_
	}

	if AliceCountry:IsAtWar() or AliceCountry:GetStrategy():IsPreparingWar() then
		evaluationOrder = {
		 	CGoodsPool._SUPPLIES_,
			CGoodsPool._CRUDE_OIL_,
			CGoodsPool._FUEL_,
			CGoodsPool._RARE_MATERIALS_,
			CGoodsPool._METAL_,
			CGoodsPool._ENERGY_
		}
	end

	--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." eval trade ")
	for i = 1, table.getn(gEconomy["trade_routes"][AliceKey]) do
		local route = gEconomy["trade_routes"][AliceKey][i]
		local BobTag = route:GetFrom()
		if tostring(BobTag) == tostring(AliceTag) then
			BobTag = route:GetTo()
		end

		local BobCountry = BobTag:GetCountry()
		if not BobCountry:isPuppet() then -- Trading with puppet nations seriously bugged in 1.2. Wait for 1.3
			-- cancel inactive routes
			if route:IsInactive() and ai:HasTradeGoneStale(route) then
				CancelTrade(ai, route, AliceTag, BobTag)
			else -- now check all goods transported on this route
				for _,goods in ipairs(evaluationOrder) do
					local Bob2Alice = route:GetTradedToOf(goods):Get()
					-- Trade exists?
					if 0 ~= Bob2Alice then
						-- direction?
						if route:GetConvoyResponsible() == BobTag then
							Bob2Alice = -1 * Bob2Alice
						end
						local AliceExport = math.max(0, -1 * Bob2Alice)
						local AliceImport = math.max(0, Bob2Alice)

						-- if ('GER' == tostring(AliceTag) and 'JAP' == tostring(BobTag)) or
							-- ('JAP' == tostring(AliceTag) and 'GER' == tostring(BobTag))
						-- then
							-- Utils.LUA_DEBUGOUT(tostring(AliceTag).." 2 "..tostring(BobTag).." (4) Cancel ".." AliceExport: "..tostring(AliceExport).." AliceImport: "..
								-- tostring(AliceImport).." HasMinStock("..tostring(AliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
								-- tostring(HasMinStock(AliceCountry, goods)).." HasMaxStock("..tostring(AliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
								-- tostring(HasMaxStock(AliceCountry, goods)).." HasMinStock("..tostring(BobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
								-- tostring(HasMinStock(BobTag:GetCountry(), goods)).." HasMaxStock("..tostring(BobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
								-- tostring(HasMaxStock(BobTag:GetCountry(), goods))..
								-- " GetAverageBalance("..tostring(AliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..tostring(GetAverageBalance(AliceCountry, goods))..
								-- " GetAverageBalance("..tostring(BobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..tostring(GetAverageBalance(BobTag:GetCountry(), goods))
								-- )
						-- end
						if goods == CGoodsPool._SUPPLIES_ then
							-- if we (alice) sell supplies and make money..cancel
							if  AliceExport > 0 and IsRich(AliceCountry) then
								CancelTrade(ai, route, AliceTag, BobTag)
								return
							-- we (alice) buy supplies and have no money
							elseif AliceImport > 0 and (not IsRich(AliceCountry) or HasMaxStock(AliceCountry, goods)) then
								CancelTrade(ai, route, AliceTag, BobTag)
								return
							end
						elseif
							-- we buy oil or fuel
							AliceImport > 0 and (goods == CGoodsPool._CRUDE_OIL_ or goods == CGoodsPool._FUEL_) and (
								-- and have max stock
								HasMaxStock(AliceCountry, goods) or
								-- or we're poor and have positive fuel balance
								(IsPoor(AliceCountry) and GetAverageBalance(AliceCountry, CGoodsPool._FUEL_) > 0)
							)
						then
							CancelTrade(ai, route, AliceTag, BobTag)
							return
						elseif
							-- we buy a good but have lots
							(AliceImport > 0 and HasMaxStock(AliceCountry, goods)) or
							-- we sell a good
							(AliceExport > 0 and
							(
								-- and have less than we'd like
								not HasMinStock(AliceCountry, goods)) or
								-- or run out in one month
								(Stock(AliceCountry, goods) + GetAverageBalance(AliceCountry, goods) * 30) < MinStock(AliceCountry, goods)
							)
						then
							CancelTrade(ai, route, AliceTag, BobTag)
							return
						elseif
							-- we cancel imports below balance if stock is above min
							(AliceImport > 0 and AliceImport < GetAverageBalance(AliceCountry, goods) and HasMinStock(AliceCountry, goods)) or
							-- we cancel exports below neg. balance
							(AliceExport > 0 and AliceExport < -1*GetAverageBalance(AliceCountry, goods))
						then
							--Utils.LUA_DEBUGOUT(tostring(AliceTag).." 2 "..tostring(BobTag).." cancelling trade")
							CancelTrade(ai, route, AliceTag, BobTag)
							return
						end
					end
				end
			end
		end
	end
end

function CancelTrade(ai, route, AliceTag, BobTag)
	local cancel = CTradeAction(AliceTag, BobTag)
	cancel:SetRoute(route)
	cancel:SetValue(false)
	if cancel:IsValid() then
		ai:PostAction(cancel)
	end
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

function Selling(country, goods)
	if IsTradeControlledByHuman(country:GetCountryTag()) then
		if HasMinStock(country, goods) then
			return math.min(50, math.max(GetAverageBalance(country, goods), 0))
		else
			return 0
		end
	end

	-- cancel imports first
	if ExistsImport(country:GetCountryTag(), goods) then
		--Utils.LUA_DEBUGOUT(tostring(country:GetCountryTag()).." ExistsImport "..tostring(GOODS_TO_STRING[goods]))
		return 0
	end

	if goods == CGoodsPool._FUEL_ then
		if ExistsImport(country:GetCountryTag(), CGoodsPool._CRUDE_OIL_) then
			return 0
		end
	end

	-- sell if are poor
	if  goods == CGoodsPool._SUPPLIES_ then
		if IsPoor(country) then
			-- IC (1-50)
			return math.min(50, math.max(1, country:GetTotalIC()/4))
		else
			return 0
		end
	end

	if HasMaxStock(country, goods) then
		return 50
	end

	if HasMinStock(country, goods) then
		--Utils.LUA_DEBUGOUT(tostring(country:GetCountryTag()).." Selling avg. balance "..tostring(GOODS_TO_STRING[goods]).." "..tostring(math.max(0, GetAverageBalance(country, goods))))
		-- 0 or whatever income we have
		return math.max(0, GetAverageBalance(country, goods))
	else
		--Utils.LUA_DEBUGOUT(tostring(country:GetCountryTag()).." NO HasMinStock "..tostring(GOODS_TO_STRING[goods]))
		-- nothing to sell
		return 0
	end
end

function Buying(country, goods)
	if IsTradeControlledByHuman(country:GetCountryTag()) then
		--Utils.LUA_DEBUGOUT(tostring(country:GetCountryTag()).." is human buyer.")
		return 50
	end

	-- buy supplies if we are rich and not overstocked
	if goods == CGoodsPool._SUPPLIES_ then
		if IsRich(country) and not HasMaxStock(country, goods) then
			-- IC 1 to 50
			return math.min(50, math.max(1, country:GetTotalIC()/4))
		else
			return 0
		end
	end

	local balance = GetAverageBalance(country, goods)

		-- cancel exports first
	if	ExistsExport(country:GetCountryTag(), goods) or
		-- don't buy max stocked goods
		HasMaxStock(country, goods) or
		-- goods in positive balance and stock not empty
		(balance >= 0 and Stock(country, goods) > 10) --or
		-- trade balance loss smaller than min trade and min stock
		--(-balance<MinTradeSize(country) and HasMinStock(country, goods))
	then
		return 0
	end

	-- buy as much oil as we need fuel unless fuel import or war then go on to eval oil like any good
	if	goods == CGoodsPool._CRUDE_OIL_ and not ExistsImport(country:GetCountryTag(), CGoodsPool._FUEL_) and
		not (country:IsAtWar() or country:GetStrategy():IsPreparingWar())
	then
		return Buying(country, CGoodsPool._FUEL_)
	end

	if HasMinStock(country, goods) then
		return math.max(-1.05*balance, MinTradeSize(country))
	else
		return math.max(-1.25*balance, math.min(50, country:GetTotalIC()/10), MinTradeSize(country))
	end
end

function MinTradeSize(country)
	-- 10% IC but no more than 5
	return math.min(country:GetTotalIC()/10, 5)
end

function ProposeTrades(ai, AliceTag)
	local AliceCountry = AliceTag:GetCountry()
	local AliceBuys = 0
	local AliceMinTradeSize = MinTradeSize(AliceCountry)

	if AliceCountry:isPuppet() then
		return -- Trading with puppet nations seriously bugged in 1.2. Wait for 1.3
	end

	-- see what we are low on and find someone who is hoarding it

	-- Buy either fuel or oil
	local fuelOrOil = CGoodsPool._FUEL_
	if math.mod(CCurrentGameState.GetAIRand(), 2) == 0 then
		fuelOrOil = CGoodsPool._CRUDE_OIL_
	end

	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	for goods = 0, MAX_GOODS do
		if goods ~= CGoodsPool._MONEY_ and goods ~= fuelOrOil then
			local best = {}
			best["score"] = -10000
			best["action"] = nil
			--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." "..tostring(GOODS_TO_STRING[goods]))

			-- buy
			AliceBuys = Buying(AliceCountry, goods)
			-- we need it, we have no max stock, we are not exporting it
			--if tostring(AliceTag) == 'FRA' then
			--	Utils.LUA_DEBUGOUT("FRA buys " .. tostring(AliceBuys) .. " " .. GOODS_TO_STRING[goods])
			--end

			if AliceBuys >= AliceMinTradeSize then -- buying?
 				--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." --- BUYING --- "..tostring(GOODS_TO_STRING[goods]))
				-- lets check every possible trading partner
				for BobCountry in CCurrentGameState.GetCountries() do
					local BobTag = BobCountry:GetCountryTag()
					-- not same country, BobBalance>minTrade, BobStock>min
					if	tostring(BobTag) ~= tostring(AliceTag) and IsValidCountry(BobCountry) and
						not BobCountry:isPuppet() -- Trading with puppet nations seriously bugged in 1.2. Wait for 1.3
					then
						if not (AliceCountry:NeedConvoyToTradeWith( BobTag ) and AliceCountry:GetTransports() == 0) then
							local BobSells = Selling(BobCountry, goods)
							if BobSells >= AliceMinTradeSize then
								best = ProposeTradeCalc(ai, goods, math.min(AliceBuys, BobSells, 50), BobSells, AliceCountry, BobCountry, best )
							end
						end
					end
				end
 				--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." --- DONE BUYING --- "..tostring(GOODS_TO_STRING[goods]))
				if  best["action"] then
					ai:PostAction( best["action"] )
				end
			end -- otherwise not top stock but pos. balance so no action needed
		end
	end
end

function ProposeTradeCalc(ai, goods, requested, BobSells, BuyerCountry, SellerCountry, best )
	local BuyerTag = BuyerCountry:GetCountryTag()
	local SellerTag = SellerCountry:GetCountryTag()

	-- check some stuff for validity
	if	SellerCountry:Exists() and SellerTag:IsReal() and
		not (BuyerCountry:HasDiplomatEnroute(SellerTag)) and
		BuyerCountry:Exists() and BuyerTag:IsReal() and
		not (SellerTag == BuyerTag)
	then
		local rel = BuyerCountry:GetRelation( SellerTag )

		local TradeAction = CTradeAction( BuyerTag, SellerTag )
		-- test the trade offer
		if TradeAction:IsValid() and TradeAction:IsSelectable() and TradeAction:IsConvoyPossible() then
			TradeAction:SetTrading( CFixedPoint(requested), goods )
			--  1 to 0
			local score = requested/math.min(50, 1.1*BobSells)
			-- 100 to 0
			local chance = TradeAction:GetAIAcceptance() - ai:GetSpamPenalty(SellerTag) --DiploScore_OfferTrade(ai, BuyerTag, SellerTag, nil, TradeAction)
			score = score*chance*(0.9+math.mod( CCurrentGameState.GetAIRand(), 21)/10)
			-- save score if 50% chance and better than previous score
			if	chance > 50 and
				score > best["score"] --(not ai:AlreadyTradingResourceOtherWay( TradeAction:GetRoute()))
			then
				best["score"] = score
				best["action"] = TradeAction
				best["seller"] = SellerCountry
				best["buyer"] = BuyerCountry
				best["goods"] = goods
--~ 				if 'USA' == tostring(SellerTag) or 'USA' == tostring(BuyerTag) then
--~ 					Utils.LUA_DEBUGOUT(tostring( SellerTag ).."2"..tostring( BuyerTag )
--~ 						.." proposing "..tostring(requested).." of "..tostring(GOODS_TO_STRING[goods]).." scoring: "..tostring(score))
--~ 				end
			end
		end
	end
	return 	best
end

function ExistsExport(AliceTag, goods)
	if goods ~= CGoodsPool._MONEY_ and gEconomy["export"][goods] and gEconomy["export"][goods][tostring(AliceTag)] then
		-- Utils.LUA_DEBUGOUT(tostring( AliceTag ).." exports "..tostring(GOODS_TO_STRING[goods]).." "..tostring(gEconomy["export"][goods][tostring(AliceTag)]))
		-- for BobTag, Export in pairs(gEconomy["export"][goods][tostring(AliceTag)]) do
			-- Utils.LUA_DEBUGOUT(tostring( AliceTag ).." exports "..tostring(Export).." "..tostring(GOODS_TO_STRING[goods]).." to "..tostring(BobTag))
		-- end
		return true
	end
	return false
end

function ExistsImport(AliceTag, goods)
	if goods ~= CGoodsPool._MONEY_ and gEconomy["import"][goods] and gEconomy["import"][goods][tostring(AliceTag)] then
		--Utils.LUA_DEBUGOUT(tostring(gDayCount)..": "..tostring( AliceTag ).." imports "..tostring(GOODS_TO_STRING[goods]))
		-- for BobTag, Import in pairs(gEconomy["export"][goods][tostring(AliceTag)]) do
			-- Utils.LUA_DEBUGOUT(tostring( AliceTag ).." imports "..tostring(Import).." "..tostring(GOODS_TO_STRING[goods]).." from "..tostring(BobTag))
		-- end
		return true
	end
	return false
end

function DiploScore_OfferTrade(ai, Alice, Bob, observer, action)
	-- if Alice human and man trade return 100
	-- if Bob human and human trade return 100

	if observer == Alice then
		--Utils.LUA_DEBUGOUT("DiploScore_OfferTrade"..tostring(Alice).." is observer so return 100")
		return 100 -- handled from foreign minister
	else -- evaluate offer of trade from Alice
		local score = 666
		local AliceCountry = Alice:GetCountry()
		local BobCountry = Bob:GetCountry()
		local route = action:GetRoute()
		local LandRoute = false

		-- DOES NOT WORK BUG!
--~ 		if ai:AlreadyTradingResourceOtherWay( action:GetRoute() ) then
--~ 			Utils.LUA_DEBUGOUT(" Already Importing! ")
--~ 			return 0
--~ 		end

		-- we need transports to trade
		if AliceCountry:NeedConvoyToTradeWith( Bob ) then
			if route:GetConvoyResponsible() == Bob then
				if BobCountry:GetTransports() == 0 then
					--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( Bob ))
					return 0
				end
			elseif AliceCountry:GetTransports() == 0 then
				--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( Alice ))
				return 0
			end
		else
			LandRoute = true
		end
		--Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." -> DiploScore_OfferTrade ")
		local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
		for goods = 0, MAX_GOODS do
			-- buggy
--~ 			if ai:AlreadyTradingResourceOtherWay( action:GetRoute() ) then
--~ 				Utils.LUA_DEBUGOUT(" Already Importing! ".. tostring( GOODS_TO_STRING[goods]))
--~ 				--return 0
--~ 			else

			-- 'we' sell to Bob A2B good and B2A money
			local Alice2Bob = route:GetTradedFromOf(goods):Get()
			-- 'we' buy from Bob B2A good and A2B money
			local Bob2Alice = route:GetTradedToOf(goods):Get()


			if goods ~= CGoodsPool._MONEY_ then
				-- to-do reverse check!!!
				if not IsTradeControlledByHuman(Alice) then
					-- we try to sell to bob but bob already sells that good or we import it
					if Alice2Bob>0 and (ExistsExport(Bob, goods) or ExistsImport(Alice, goods))	then
						--Utils.LUA_DEBUGOUT(tostring(Bob).." export route exists (1)!")
						return 0
					end
					-- we try to buy but already export the good or bob imports it
					if Bob2Alice>0 and (ExistsExport(Alice, goods) or ExistsImport(Bob, goods))	then
						--Utils.LUA_DEBUGOUT(tostring(Alice).." export route exists (2)!")
						return 0
					end
				end

				if Bob2Alice>0 or Alice2Bob>0 then
					score = math.min(score, ScoreTradeOfGood(goods, Alice2Bob, AliceCountry, Bob2Alice, BobCountry))
					--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."<->"..tostring(BobCountry:GetCountryTag())
					--	..tostring( GOODS_TO_STRING[goods]).." Score: "..tostring(score))
				end
--~ 				Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." -> Bob2Alice "..tostring(Bob2Alice).." ".. tostring( GOODS_TO_STRING[goods]))

--~ 				.." Alice2Bob:"..tostring(Alice2Bob).." Bob2Alice:"..tostring(Bob2Alice))
			end
		end
		if score == 666 then
			score = 0 -- no good scored
		elseif LandRoute then
			score = score*1.1 -- land route is better
		end

	--Utils.LUA_DEBUGOUT(" Final Score: " ..tostring( score ))
	--Utils.LUA_DEBUGOUT("---------------")

 		--Utils.LUA_DEBUGOUT("score before strategy " .. score)
		if score ~= 0 then
			--Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." StrategicScore: " ..tostring( StrategicScore(ai, Alice, Bob) ))
			--Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." StrategicScore: " ..tostring( StrategicScore(ai, Bob, Alice) ))
			-- +/- 20%
			score = score + score*StrategicScore(ai, Alice, Bob)/100
		end
		--Utils.LUA_DEBUGOUT("score after strategy " .. score)
		-- 0 to 100
		return math.max(0, math.min(100, Utils.CallScoredCountryAI(Alice, 'DiploScore_OfferTrade', score, ai, Alice, Alice, observer)))
	end
end

-- return -20 to +20
function StrategicScore(ai, Alice, Bob)
	local score = 0
	local rel = ai:GetRelation(Alice, Bob)
	local AliceCountry = Alice:GetCountry()
	local BobCountry = Bob:GetCountry()
	local strategy = AliceCountry:GetStrategy()

--~ 			Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." Score: " ..tostring( score )
--~ 				.." GetThreat: "..tostring(rel:GetThreat():Get())
--~ 				.." CalculateAlignmentFactor: "..tostring(CalculateAlignmentFactor(ai, AliceCountry, BobCountry))
--~ 				.." strategy:GetAntagonism("..tostring(Alice).."): "..tostring(strategy:GetAntagonism(Alice))
--~ 				.." strategy:GetFriendliness("..tostring(Alice).."): "..tostring(strategy:GetFriendliness(Alice))
--~ 				.." rel:GetValue():GetTruncated(): "..tostring(rel:GetValue():GetTruncated())
--~ 				)

	if rel:IsFightingWarTogether() then
--~ 	Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." IsFightingWarTogether")
		return 20
	else
		-- -10 to +10 (for -200 to 200 relationship)
		score = score + rel:GetValue():GetTruncated()/20 --
		-- 0 to -10 (for 0-100 thread * alignment)
		score = score - math.min(10, (rel:GetThreat():Get()* CalculateAlignmentFactor(ai, AliceCountry, BobCountry))/10)
		-- 0 to -10 (for 0 to 400)
		score = score - math.min(10, strategy:GetAntagonism(Alice) / 40)
		-- 0 to +10 (for 0 to 400)
		score = score + math.min(10, strategy:GetFriendliness(Alice) / 40)
		-- -5 to +5 (for 1 to 0 alignment)
		score = score + 5-10*CalculateAlignmentFactor(ai, AliceCountry, BobCountry)
		if rel:IsGuaranteed() then
--~ 		Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." IsGuaranteed")
			score = score + 5
		end
		if rel:HasFriendlyAgreement() then
--~ 		Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." HasFriendlyAgreement")
			score = score + 10
		end
		if rel:AllowDebts() then
--~ 		Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." AllowDebts")
			score = score + 5
		end
	end
	return math.max(-20, math.min(20,score))
end

function ScoreTradeOfGood(goods, Alice2Bob, AliceCountry, Bob2Alice, BobCountry)
 	--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."2"..tostring(BobCountry:GetCountryTag()).." -> ScoreTradeOfGood ")
	if Bob2Alice > 0 then
 		--Utils.LUA_DEBUGOUT(tostring(BobCountry:GetCountryTag()).."2"..tostring(AliceCountry:GetCountryTag()).." -> ScoreTradeOfGood Bob2Alice:"..tostring(Bob2Alice))
		return ScoreTradeOfGoodCalc(goods, Bob2Alice, BobCountry, AliceCountry)
	end
	if Alice2Bob > 0 then
 		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."2"..tostring(BobCountry:GetCountryTag()).." -> ScoreTradeOfGood Alice2Bob:"..tostring(Alice2Bob))
		return ScoreTradeOfGoodCalc(goods, Alice2Bob, AliceCountry, BobCountry)
	end
	-- not a traded good
	return 0
end

-- returns 0 to 100 points
function ScoreTradeOfGoodCalc(goods, Amount, SellerCountry, BuyerCountry)
 	--Utils.LUA_DEBUGOUT(tostring(SellerCountry:GetCountryTag()).."2"..tostring(BuyerCountry:GetCountryTag()).." -> ScoreTradeOfGoodCalc ")
	local SellerDemand = Selling(SellerCountry, goods)
	local BuyerDemand = Buying(BuyerCountry, goods)

	if IsTradeControlledByHuman(SellerCountry:GetCountryTag()) then
		SellerDemand = Amount
	end
	if IsTradeControlledByHuman(BuyerCountry:GetCountryTag()) then
		BuyerDemand = Amount
	end

	-- if tostring(SellerCountry:GetCountryTag())=='JAP' or tostring(BuyerCountry:GetCountryTag())=='JAP' then
		--Utils.LUA_DEBUGOUT(tostring(SellerCountry:GetCountryTag()).."2"..tostring(BuyerCountry:GetCountryTag()).." "
		-- ..tostring( GOODS_TO_STRING[goods]).." "..tostring(SellerDemand).." <2> "..tostring(BuyerDemand).." Amount:"..tostring(Amount)	)
	-- end

	-- asking too much?
	if Amount > SellerDemand or Amount > BuyerDemand then
		return 0
	end

	if SellerDemand > 0 and BuyerDemand > 0 then
		-- buyer satisfaction 1 to 0
		local buyerScore = math.min(50, Amount)/math.min(50, BuyerDemand) --+ 0.5 * (1-math.min(1, BuyerStock/90000))
		-- seller satisfaction 1 to 0
		local sellerScore = math.min(MinTradeSize(SellerCountry), Amount) / MinTradeSize(SellerCountry) --+ 0.5 * math.min(1, SellerStock/90000)
		return 100 * math.min(buyerScore, sellerScore)
	end

	return 0
end

