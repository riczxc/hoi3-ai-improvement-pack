require('utils')

local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function ForeignMinister_ManageTrade(ai, ministerTag)
	if ministerTag:IsReal() and ministerTag:IsValid() and ministerTag:GetCountry():Exists() then	
		--if 'JAP' == tostring(ministerTag) then --math.mod( CCurrentGameState.GetAIRand(), 6) == 0 then
		if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.TRADE_DELAY) == 0 then
			--Utils.LUA_DEBUGOUT("ForeignMinister_ManageTrade - " .. tostring(ministerTag))
			ProposeTrades(ai, ministerTag)
		--if 'GER' == tostring(ministerTag) then -- or 'ENG' == tostring(ministerTag) then
			EvalutateExistingTrades(ai, ministerTag)
		end
	end
end

function EvalutateExistingTrades(ai, AliceTag)
	local AliceCountry = AliceTag:GetCountry()
	local AliceIC = AliceCountry:GetTotalIC()
	-- min stock pile, no more than 45k
	local AliceMinStock = math.min(45000, AliceIC*ai_configuration.MINIMUM_STOCKPILE)
	--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." eval trade ")
	for Bob in CCurrentGameState.GetCountries() do
		if (not (Bob:GetCountryTag() == AliceTag)) then
			local routes = AliceCountry:GetRelation( Bob:GetCountryTag() ):GetTradeRoutes()
			for route in routes do
				if route:IsValid() then
					--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." eval route ")
					if route:IsInactive() and ai:HasTradeGoneStale(route) then	--0==math.mod( CCurrentGameState.GetAIRand(), 10)
						--Utils.LUA_DEBUGOUT(tostring(AliceTag).."2"..tostring(Bob:GetCountryTag()).." Cancel stale route ")
						CancelTrade(ai, route, AliceTag, Bob:GetCountryTag())
					else -- ok, but can we do better?
						local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
						for goods = 0, MAX_GOODS do
							-- 'we' buy from Bob
							local Bob2Alice = route:GetTradedToOf(goods):Get()
							if goods ~= CGoodsPool._MONEY_ and 0~=Bob2Alice then
								local AliceStockFactor = AliceCountry:GetPool():Get( goods ):Get()/AliceMinStock
								-- direction?
								if tostring(route:GetConvoyResponsible()) == tostring(Bob:GetCountryTag()) then
									Bob2Alice = -1*Bob2Alice
								end

--~ 								if  Bob2Alice > 0 then
--~ 									Utils.LUA_DEBUGOUT(tostring(Bob:GetCountryTag()).." -> "..tostring(AliceTag).." "..tostring(GOODS_TO_STRING[goods]))
--~ 								else
--~ 									Utils.LUA_DEBUGOUT(tostring(AliceTag).." -> "..tostring(Bob:GetCountryTag()).." "..tostring(GOODS_TO_STRING[goods]))
--~ 								end

								if goods == CGoodsPool._SUPPLIES_ then
									-- if we (alice) sell supplies and make money..cancel
									if  Bob2Alice < 0 and IsRich(AliceCountry) then
										if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
--~ 											Utils.LUA_DEBUGOUT(tostring(AliceTag).." -> "..tostring(Bob:GetCountryTag()).." SUPPLY SELL Cancel: "..tostring(Bob2Alice).." Money: "
--~ 											..tostring(AliceCountry:GetDailyBalance(CGoodsPool._MONEY_):Get()).." Bank: "..tostring(AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get())
--~ 											.." and  CG: "
--~ 											..tostring( AliceCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()*1.1 )
--~ 											.."<"..tostring(AliceCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()))
											CancelTrade(ai, route, AliceTag, Bob:GetCountryTag())
										end
									end
									-- we (alice) buy supplies and have no money
									if Bob2Alice > 0 and IsPoor(AliceCountry) then
										if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
--~ 											Utils.LUA_DEBUGOUT(tostring(AliceTag).." <- "..tostring(Bob:GetCountryTag()).." SUPPLY BUY Cancel: "..tostring(Bob2Alice).." Money: "
--~ 											..tostring(AliceCountry:GetDailyBalance(CGoodsPool._MONEY_):Get()).." Bank: "..tostring(AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get())
--~ 											.." and  CG: "
--~ 											..tostring( AliceCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()*1.1 )
--~ 											.."<"..tostring(AliceCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()))
											CancelTrade(ai, route, AliceTag, Bob:GetCountryTag())
										end
									end
								--then
									--if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then

									--end
								elseif
									-- we buy oil but have lots and a positve balance of fuel?
									(goods == CGoodsPool._CRUDE_OIL_ and  Bob2Alice > 0 and
										AliceCountry:GetPool():Get( CGoodsPool._FUEL_ ):Get()/AliceMinStock > 2 and
										AliceCountry:GetDailyBalance(CGoodsPool._FUEL_):Get() > 0) or
									-- we buy a good but have lots and a positve balance
									(Bob2Alice > 0 and AliceStockFactor > 2 and
										AliceCountry:GetDailyBalance(goods):Get() > 0) or
									-- we sell a good, have less than we'd like and negative balance...not a good deal
									(Bob2Alice < 0 and AliceStockFactor < 1 and
										AliceCountry:GetDailyBalance(goods):Get() < 0)
								then
									-- cancel 1/3 so we hopefully ease to the right point of trade
									if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
--~ 										Utils.LUA_DEBUGOUT(tostring(AliceTag).."2"..tostring(Bob:GetCountryTag()).." Cancel: "..tostring(Bob2Alice).." Money: "
--~ 										..tostring(AliceCountry:GetDailyBalance(CGoodsPool._MONEY_):Get()).." and  CG: "
--~ 										..tostring( AliceCountry:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_CONSUMER_ ):GetNeeded():Get()*1.1 )
--~ 										.."<"..tostring(AliceCountry:GetICPart( CDistributionSetting._PRODUCTION_CONSUMER_ ):Get()))
										CancelTrade(ai, route, AliceTag, Bob:GetCountryTag())
									end
								end
							end
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


-- return true if country has money, makes money and doesn't overproduce CG to do so
function IsRich(AliceCountry)
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/math.min(45000, AliceCountry:GetTotalIC()*ai_configuration.MINIMUM_MONEY_STOCKPILE)
	if	-- loaded bank account 2* min money
		MoneyStockFactor > 2 and
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
	local MoneyStockFactor = AliceCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()/math.min(45000, AliceCountry:GetTotalIC()*ai_configuration.MINIMUM_MONEY_STOCKPILE)
	if	MoneyStockFactor < 1.5
	then
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." IsPoor ")
		return true
	else
		--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).." NOT IsPoor ")
		return false
	end
end

function ProposeTrades(ai, AliceTag)
	local AliceCountry = AliceTag:GetCountry()
	if '---' == AliceTag or AliceCountry:GetTransports() == 0 then
		--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." !!!!!!!!!!!!!!!!!!!!")
		return
	end
	local bestBuyingScore = -10000
	local bestBuyingAction = nil
	local AliceDemand = 0
	local BobDemand = 0
	-- > 10%
	local MinTradeSize = math.min(0.099*AliceCountry:GetTotalIC(), 5)

	-- see what we are low on and find someone who is hoarding it
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	for goods = 0, MAX_GOODS do
		if goods ~= CGoodsPool._MONEY_ then
			-- buy 110% to buffer
			AliceDemand = 1.1*DemandFor(AliceCountry, goods)
			if AliceDemand >= MinTradeSize then -- buying?
--~ 				Utils.LUA_DEBUGOUT(tostring( AliceTag ).." --- BUYING --- "..tostring(GOODS_TO_STRING[goods]))
				-- lets check every possible trading partner
				for BobCountry in CCurrentGameState.GetCountries() do
					-- 50:50 chance to skip this country to prevent bug in daily balance catch a country in endless cycle of trade offer -> deny
					if tostring(BobCountry:GetCountryTag()) ~= tostring(AliceTag) and math.mod( CCurrentGameState.GetAIRand(), 2) == 0 then
						BobDemand = DemandFor(BobCountry, goods)
						-- selling?,
						if	-1*BobDemand >= MinTradeSize then
--~ 							if tostring(AliceCountry:GetCountryTag())=='JAP' and math.mod( CCurrentGameState.GetAIRand(), 2) == 0 then
--~ 								Utils.LUA_DEBUGOUT(tostring( AliceTag ).."2"..tostring( BobCountry:GetCountryTag() )
--~ 									.." Find someone selling me "..tostring(GOODS_TO_STRING[goods]))
--~ 							end
							-- lets try and buy from Bob (min amount between buyer and seller demand and not more than 50)
							bestBuyingScore, bestBuyingAction = ProposeTradeCalc(ai, goods, math.min(AliceDemand, -1*BobDemand, 50), AliceCountry, BobCountry, bestBuyingScore, bestBuyingAction )
						end
					end
				end
--~ 				Utils.LUA_DEBUGOUT(tostring( AliceTag ).." --- DONE BUYING --- "..tostring(GOODS_TO_STRING[goods]))
			end -- otherwise not top stock but pos. balance so no action needed
		end
	end
	-- if 'PAN' == tostring( AliceTag ) then
		-- Utils.LUA_DEBUGOUT(tostring( AliceTag ).." <=")
	-- end

	if  bestBuyingAction then
		ai:PostAction( bestBuyingAction )
--~ 		if tostring(AliceCountry:GetCountryTag())=='JAP' then
--~  			Utils.LUA_DEBUGOUT(tostring( AliceTag ).." -- Posted Buying -- "..tostring(bestBuyingScore).."\n")
--~ 		end
	end
end

function ProposeTradeCalc(ai, goods, requested, BuyerCountry, SellerCountry, bestScore, bestAction )
	local BuyerTag = BuyerCountry:GetCountryTag()
	local SellerTag = SellerCountry:GetCountryTag()

	-- don't trade supplies if buyer isn't rich and seller isn't poor
	if  goods == CGoodsPool._SUPPLIES_ and (not IsRich(BuyerCountry) or not IsPoor(SellerCountry)) then
		return 	bestScore, bestAction
	end

	-- check some stuff for validity
	if	SellerCountry:Exists() and SellerTag:IsReal() and
		not (BuyerCountry:HasDiplomatEnroute(SellerTag)) and
		BuyerCountry:Exists() and BuyerTag:IsReal() and
		not (SellerTag == BuyerTag)
	then
		local MinTradeSize = math.min(BuyerCountry:GetTotalIC()/10, 5)
		--local SellerDemand = DemandFor(SellerCountry, goods)
		-- 110% demand to buffer
		--local BuyerDemand = 1.1*DemandFor(BuyerCountry, goods)
		-- try buyerdemand but no more than 50 or what the seller can spare
		--local requested = math.min( BuyerDemand, -1*SellerDemand, 50 )
		local rel = BuyerCountry:GetRelation( SellerTag )

		local TradeAction = CTradeAction( BuyerTag, SellerTag )
		-- test the trade offer
		if TradeAction:IsValid() and TradeAction:IsSelectable() then
			TradeAction:SetTrading( CFixedPoint(requested), goods )
			--  1 to 0
			local score = requested/math.min(50, 1.1*DemandFor(BuyerCountry, goods))
			-- 100 to 0
			local chance = TradeAction:GetAIAcceptance() - ai:GetSpamPenalty(SellerTag) --DiploScore_OfferTrade(ai, BuyerTag, SellerTag, nil, TradeAction)
			score = score*chance
			-- save score if 50% chance and better than previous score
			if	chance > 50 and
				score > bestScore and TradeAction:IsConvoyPossible() and
				(not ai:AlreadyTradingResourceOtherWay( TradeAction:GetRoute()))
			then
--~ 				if tostring(SellerCountry:GetCountryTag())=='JAP' or tostring(BuyerCountry:GetCountryTag())=='JAP' then
--~ 					Utils.LUA_DEBUGOUT("ProposeTradeCalc "..tostring( SellerTag ).."2"..tostring( BuyerTag )
--~ 					.." Good: " .. tostring(GOODS_TO_STRING[goods])
--~ 					.." Chance: " .. tostring(chance).."-" .. tostring(ai:GetSpamPenalty(SellerTag))
--~ 					.." Score: " .. tostring(score)
--~ 					.." Requested: "..tostring(requested))
--~ 				end
				return 	score, TradeAction
			else
				return 	bestScore, bestAction
			end
		end
	end
	return 	bestScore, bestAction
end


function ExistsTradsA2B(AliceTag, BobTag, goods)
 	--Utils.LUA_DEBUGOUT(tostring( AliceTag ).." "..tostring( BobTag ).." ExistsTradsA2B ")
	local AliceCountry = AliceTag:GetCountry()
	if (not (BobTag == AliceTag)) and goods ~= CGoodsPool._MONEY_ then
		local routes = AliceCountry:GetRelation( BobTag ):GetTradeRoutes()
		for route in routes do
			if route:IsValid() then
				-- 'we' buy from Bob
				local Bob2Alice = route:GetTradedToOf(goods):Get()
				if  0~=Bob2Alice then
					-- direction?
					if tostring(route:GetConvoyResponsible()) == tostring(BobTag) then
						Bob2Alice = -1*Bob2Alice
					end
 								-- if  Bob2Alice > 0 then
 									-- Utils.LUA_DEBUGOUT(tostring(BobTag).." -> "..tostring(AliceTag).." "..tostring(GOODS_TO_STRING[goods]).." Bob2Alice:"..tostring(Bob2Alice))
 								-- else
 									-- Utils.LUA_DEBUGOUT(tostring(AliceTag).." -> "..tostring(BobTag).." "..tostring(GOODS_TO_STRING[goods]).." Bob2Alice:"..tostring(Bob2Alice))
 								-- end
					-- ok Alice sends goods to Bob
					if Bob2Alice < 0 then
--~ 						Utils.LUA_DEBUGOUT(tostring(AliceTag).." -> "..tostring(BobTag).." "..tostring(GOODS_TO_STRING[goods]).." exists!")
						return true
					end
				end
			end
		end
	end
--~ 	Utils.LUA_DEBUGOUT(tostring(AliceTag).." -> "..tostring(BobTag).." "..tostring(GOODS_TO_STRING[goods]).." not yet!")
	-- none found
	return false
end

function DiploScore_OfferTrade(ai, Alice, Bob, observer, action)
	if observer == Alice then
		Utils.LUA_DEBUGOUT("DiploScore_OfferTrade"..tostring(Alice).." is observer so return 100")
		return 100 -- handled from foreign minister
	else -- evaluate offer of trade from Alice
		local score = 0
		local AliceCountry = Alice:GetCountry()
		local BobCountry = Bob:GetCountry()
		local route = action:GetRoute()

		-- DOES NOT WORK BUG!
--~ 		if ai:AlreadyTradingResourceOtherWay( action:GetRoute() ) then
--~ 			Utils.LUA_DEBUGOUT(" Already Importing! ")
--~ 			return 0
--~ 		end

		-- we need transports to trade
		if AliceCountry:NeedConvoyToTradeWith( Bob ) then
			if route:GetConvoyResponsible() == Bob and BobCountry:GetTransports() == 0 then
 				--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( Bob ))
				return 0
			elseif AliceCountry:GetTransports() == 0 then
 				--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( Alice ))
				return 0
			end
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
				-- route exists the other way already
				if (Bob2Alice > 0 and ExistsTradsA2B(Alice, Bob, goods)) or
					(Bob2Alice < 0 and ExistsTradsA2B(Bob, Alice, goods))
				then
					--Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." -> Bob2Alice "..tostring(Bob2Alice).." ".. tostring( GOODS_TO_STRING[goods]).." route exists!")
					return 0
				end

			local thisScore = ScoreTradeOfGood(goods, Alice2Bob, AliceCountry, Bob2Alice, BobCountry)
--~ 				Utils.LUA_DEBUGOUT(tostring(Alice).."2"..tostring(Bob).." -> Bob2Alice "..tostring(Bob2Alice).." ".. tostring( GOODS_TO_STRING[goods]))
--~ 				Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."<->"..tostring(BobCountry:GetCountryTag())..tostring( GOODS_TO_STRING[goods]).." Score: "..tostring(thisScore)
--~ 				.." Alice2Bob:"..tostring(Alice2Bob).." Bob2Alice:"..tostring(Bob2Alice))
				-- scored good?
				if thisScore ~= 0 then
					-- first score always counts
					if score == 0 then
						score = thisScore
					else
						-- take worst score
						score = math.min(score, thisScore)
					end
				end
--~ 				if Alice2Bob ~=0 or Bob2Alice ~=0 then
--~ 					Utils.LUA_DEBUGOUT(" Score ".. tostring( GOODS_TO_STRING[goods]) .. ": " ..tostring( score )
--~ 					.." Alice2Bob: "..tostring(Alice2Bob).." Bob2Alice: "..tostring(Bob2Alice))
--~ 				end
			end
--~ 			end

		end

	--Utils.LUA_DEBUGOUT(" Final Score: " ..tostring( score ))
	--Utils.LUA_DEBUGOUT("---------------")

--~ 		Utils.LUA_DEBUGOUT("score before strategy " .. score)
		if score > 30 then
			local rel = ai:GetRelation(Alice, Alice)
			local strategy = AliceCountry:GetStrategy()
			score = score - math.min(10, rel:GetThreat():Get() * CalculateAlignmentFactor(ai, AliceCountry, BobCountry))
			score = score - math.min(10, strategy:GetAntagonism(Alice) / 15)
			score = score + math.min(10, strategy:GetFriendliness(Alice) / 15)
			score = score - math.min(10, rel:GetThreat():Get() / 2)

			if rel:IsGuaranteed() then
				score = score + 5
			end
			if rel:HasFriendlyAgreement() then
				score = score + 10
			end
			if rel:AllowDebts() then
				score = score + 5
			end
			if rel:IsFightingWarTogether() then
				score = score + 15
			end

			-- -5 to +5
			local relation = rel:GetValue():GetTruncated()
			score = score + relation / 40
		end

 		--Utils.LUA_DEBUGOUT("DiploScore_OfferTrade "..tostring( Alice ).."2"..tostring( Bob ).." " .. tostring(score)) --.." -> " .. tostring(modScore))
		return math.min(100, score) --, Utils.CallScoredCountryAI(Alice, 'DiploScore_OfferTrade', score, ai, Alice, Alice, observer))
	end
end

function ScoreTradeOfGood(goods, Alice2Bob, AliceCountry, Bob2Alice, BobCountry)
--~ 	Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."2"..tostring(BobCountry:GetCountryTag()).." -> ScoreTradeOfGood ")
	if Bob2Alice > 0 then
--~ 		Utils.LUA_DEBUGOUT(tostring(BobCountry:GetCountryTag()).."2"..tostring(AliceCountry:GetCountryTag()).." -> ScoreTradeOfGood Bob2Alice:"..tostring(Bob2Alice))
		return ScoreTradeOfGoodCalc(goods, Bob2Alice, BobCountry, AliceCountry)
	end
	if Alice2Bob > 0 then
--~ 		Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."2"..tostring(BobCountry:GetCountryTag()).." -> ScoreTradeOfGood Alice2Bob:"..tostring(Alice2Bob))
		return ScoreTradeOfGoodCalc(goods, Alice2Bob, AliceCountry, BobCountry)
	end
	-- not a traded good
	return 0
end

-- returns 0 to 80 points
function ScoreTradeOfGoodCalc(goods, Amount, SellerCountry, BuyerCountry)
--~ 	Utils.LUA_DEBUGOUT(tostring(SellerCountry:GetCountryTag()).."2"..tostring(BuyerCountry:GetCountryTag()).." -> ScoreTradeOfGoodCalc ")
	local SellerDemand = DemandFor(SellerCountry, goods)
	local BuyerDemand = DemandFor(BuyerCountry, goods)

 	-- if tostring(SellerCountry:GetCountryTag())=='JAP' or tostring(BuyerCountry:GetCountryTag())=='JAP' then
 		-- Utils.LUA_DEBUGOUT(tostring(SellerCountry:GetCountryTag()).."2"..tostring(BuyerCountry:GetCountryTag()).." "
 		-- ..tostring( GOODS_TO_STRING[goods]).." "..tostring(SellerDemand).." <2> "..tostring(BuyerDemand).." Amount:"..tostring(Amount)	)
 	-- end

	-- asking more than we sell?
	if Amount > -1*SellerDemand then
		return 0
	end



	if SellerDemand < 0 and  BuyerDemand > 0 then
		-- satisfaction 2 to 0
		local buyerScore = 2*math.min(50, Amount)/math.min(50, BuyerDemand)
		-- seller size 2 to 0
		local sellerScore = math.min(2,(-1*SellerDemand)/math.min(50, Amount))
		-- 80 to 0, how well does the trade satisfy the buyer and seller 50:50
		return math.min(80, 20 *  (buyerScore + sellerScore))
	end

	return 0
end

-- e.g. return of 20 means want to buy 20
-- return of -12 means can sell 12
function DemandFor(AliceCountry, goods)
	-- we don't trade money
	if goods == CGoodsPool._MONEY_ or not AliceCountry:Exists() then
		return 0
	end

	--Utils.LUA_DEBUGOUT(tostring(AliceCountry:GetCountryTag()).."1")
	local AliceIC = AliceCountry:GetTotalIC()
	-- balance
	local AliceBalance = AliceCountry:GetDailyBalance(goods):Get()
	local StockFactor = AliceCountry:GetPool():Get( goods ):Get()/math.min(45000, AliceIC*ai_configuration.MINIMUM_STOCKPILE)

	-- if we need no fuel then we need no oil either
	if goods == CGoodsPool._CRUDE_OIL_ and DemandFor(AliceCountry, CGoodsPool._FUEL_)<=0 then
		-- we have oil income or massive stock...sell it
		if AliceBalance > 0 or StockFactor > 2 then
			return -50
		end
		-- do nothing
		return 0
	end

	if	goods == CGoodsPool._SUPPLIES_ then
		-- buy supplies if cashed up and supply stocks not exploding
		if IsRich(AliceCountry) and StockFactor < 90000  then
			-- buy IC or max 50, min 1
			return math.max(1, math.min(50, AliceIC/5))
		end
		if IsPoor(AliceCountry) then
			-- sell supplies to get cashed up :)
			return math.min(-1, math.max(-50, -1*AliceIC/5))
		end
		-- produce them yourself
		return 0
	end

	-- other goods -->>>
	-- under stocked
	if StockFactor < 0.5 then
		-- max 50 or IC size
		return math.min(50, AliceIC)
	end
	if StockFactor < 1 then
		-- 0 if balance + and -110% if balance is negative
		return math.max(0, -1.1*AliceBalance)
	end
	-- over stocked / AliceStock > 90000
	if StockFactor > 2 then
		-- sell 110% of income or 1.1 if neg. income
		return -1.1*math.max(1, AliceBalance)
	end
	-- reasonable stock, return demand (-1*balance)
	return -1*AliceBalance

	---- END ----
end
