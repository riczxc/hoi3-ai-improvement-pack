require('utils')
require('helper_functions')

local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function ForeignMinister_ManageTrade(ai, ministerTag)
	--Utils.LUA_DEBUGOUT("->ForeignMinister_ManageTrade " .. tostring(ministerTag))
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
		IsValidCountry(ministerTag:GetCountry())
	then
		local ic = ministerTag:GetCountry():GetMaxIC()
		local delay = math.floor(100 / math.min(math.max(ic, 1), 100)) - 1
		if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.TRADE_DELAY + delay) == 0 then
			if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
				-- 1 out of 3
				--Utils.LUA_DEBUGOUT("->EvalutateExistingTrades")
				EvalutateExistingTrades(ai, ministerTag)
				--Utils.LUA_DEBUGOUT("<-EvalutateExistingTrades")
			else
				-- 2 out of 3
				--Utils.LUA_DEBUGOUT("->ProposeTrades")
				ProposeTrades(ai, ministerTag)
				--Utils.LUA_DEBUGOUT("<-ProposeTrades")
			end
		end
	end
	--Utils.LUA_DEBUGOUT("<-ForeignMinister_ManageTrade")
end

function EvalutateExistingTrades(ai, aliceTag)
	local aliceCountry = aliceTag:GetCountry()

	local tradeRoutes = {}
	local aliceKey = tostring(aliceTag)
	if gEconomy["trade_routes"] and gEconomy["trade_routes"][aliceKey] then
		tradeRoutes = gEconomy["trade_routes"][aliceKey]
	end

	local evaluationOrder = {
		CGoodsPool._FUEL_,
		CGoodsPool._CRUDE_OIL_,
		CGoodsPool._SUPPLIES_,
		CGoodsPool._RARE_MATERIALS_,
		CGoodsPool._METAL_,
		CGoodsPool._ENERGY_
	}

	if aliceCountry:IsAtWar() or aliceCountry:GetStrategy():IsPreparingWar() then
		evaluationOrder = {
		 	CGoodsPool._SUPPLIES_,
			CGoodsPool._CRUDE_OIL_,
			CGoodsPool._FUEL_,
			CGoodsPool._RARE_MATERIALS_,
			CGoodsPool._METAL_,
			CGoodsPool._ENERGY_
		}
	end

	--Utils.LUA_DEBUGOUT(tostring( aliceTag ).." eval trade ")
	for i = 1, table.getn(tradeRoutes) do
		local route = tradeRoutes[i]

		local bobTag = route:GetFrom()
		if tostring(bobTag) == tostring(aliceTag) then
			bobTag = route:GetTo()
		end

		local bobCountry = bobTag:GetCountry()

		-- cancel inactive routes
		if route:IsInactive() and ai:HasTradeGoneStale(route) then
			CancelTrade(ai, route, aliceTag, bobTag)
		else -- now check all goods transported on this route
			for _,goods in ipairs(evaluationOrder) do
				local bob2Alice = route:GetTradedToOf(goods):Get()
				-- Trade exists?
				if 0 ~= bob2Alice then
					-- direction?
					if route:GetConvoyResponsible() == bobTag then
						bob2Alice = -1 * bob2Alice
					end
					local aliceExport = math.max(0, -1 * bob2Alice)
					local aliceImport = math.max(0, bob2Alice)

					--[[
					if 'SIA' == tostring(aliceTag)
					then
						Utils.LUA_DEBUGOUT(tostring(aliceTag).." 2 "..tostring(bobTag).." (4) Cancel ".." aliceExport: "..tostring(aliceExport).." aliceImport: "..
							tostring(aliceImport).." HasMinStock("..tostring(aliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
							tostring(HasMinStock(aliceCountry, goods)).." HasMaxStock("..tostring(aliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
							tostring(HasMaxStock(aliceCountry, goods)).." HasMinStock("..tostring(bobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
							tostring(HasMinStock(bobTag:GetCountry(), goods)).." HasMaxStock("..tostring(bobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..
							tostring(HasMaxStock(bobTag:GetCountry(), goods))..
							" GetAverageBalance("..tostring(aliceTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..tostring(GetAverageBalance(aliceCountry, goods))..
							" GetAverageBalance("..tostring(bobTag)..", "..tostring(GOODS_TO_STRING[goods]).."): "..tostring(GetAverageBalance(bobTag:GetCountry(), goods))
							)
					end
					]]

					if goods == CGoodsPool._SUPPLIES_ then
						-- if we (alice) sell supplies and make money..cancel
						if  aliceExport > 0 and IsRich(aliceCountry) then
							CancelTrade(ai, route, aliceTag, bobTag)
							return
						-- we (alice) buy supplies and have no money
						elseif aliceImport > 0 and (not IsRich(aliceCountry) or HasMaxStock(aliceCountry, goods)) then
							CancelTrade(ai, route, aliceTag, bobTag)
							return
						end
					elseif
						-- we buy oil or fuel
						aliceImport > 0 and (goods == CGoodsPool._CRUDE_OIL_ or goods == CGoodsPool._FUEL_) and (
							-- and have max stock
							HasMaxStock(aliceCountry, goods) or
							-- or we're poor and have positive fuel balance
							(IsPoor(aliceCountry) and GetAverageBalance(aliceCountry, CGoodsPool._FUEL_) > 0)
						)
					then
						CancelTrade(ai, route, aliceTag, bobTag)
						return
					elseif
						-- we buy a good but have lots
						(aliceImport > 0 and HasMaxStock(aliceCountry, goods)) or
						-- we sell a good
						(aliceExport > 0 and
							(
								-- and have less than we'd like
								not HasMinStock(aliceCountry, goods) or
								-- or run out in one month
								(Stock(aliceCountry, goods) + GetAverageBalance(aliceCountry, goods) * 30) < MinStock(aliceCountry, goods)
							)
						)
					then
						CancelTrade(ai, route, aliceTag, bobTag)
						return
					elseif
						-- we cancel imports below balance if stock is above min
						(aliceImport > 0 and aliceImport < GetAverageBalance(aliceCountry, goods) and HasMinStock(aliceCountry, goods)) or
						-- we cancel exports below neg. balance
						(aliceExport > 0 and aliceExport < -1*GetAverageBalance(aliceCountry, goods))
					then
						--Utils.LUA_DEBUGOUT(tostring(aliceTag).." 2 "..tostring(bobTag).." cancelling trade")
						CancelTrade(ai, route, aliceTag, bobTag)
						return
					end
				end
			end
		end
	end
end

function CancelTrade(ai, route, aliceTag, bobTag)
	local cancel = CTradeAction(aliceTag, bobTag)
	cancel:SetRoute(route)
	cancel:SetValue(false)
	if cancel:IsValid() then
		ai:PostAction(cancel)
	end
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

	-- don't sell fuel if importing oil
	if goods == CGoodsPool._FUEL_ then
		if ExistsImport(country:GetCountryTag(), CGoodsPool._CRUDE_OIL_) then
			return 0
		end
	end

	if goods == CGoodsPool._SUPPLIES_ then
		-- sell supplies if are poor
		if IsPoor(country) then
			-- IC/4 (1-50)
			return math.min(50, math.max(1, country:GetTotalIC()/4))
		-- sell if have max stock and don't need IC in supplies
		elseif 	HasMaxStock(country, goods) and
				GetAverageBalance(country, goods) > 0
		then
			return math.min(50, math.max(1, country:GetTotalIC()/8))
		else
			return 0
		end
	end
	
	-- sell if max stock
	if HasMaxStock(country, goods) then
		return math.min(50, math.max(1, country:GetTotalIC()/4))
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

	-- buy supplies if we are rich and there's a need for supplies
	if goods == CGoodsPool._SUPPLIES_ then
		if 	IsRich(country) and 
			country:GetProductionDistributionAt( CDistributionSetting._PRODUCTION_SUPPLY_):GetNeeded():Get() > 0.1
		then
			local money = GetAverageBalance(country, CGoodsPool._MONEY_)
			local amount = money / GetGoodsCost(CGoodsPool._SUPPLIES_)
			return math.min(50, math.max(1, amount))
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

	-- Get our economy back on track
	local baseIC = country:GetMaxIC()
	local totalIC = country:GetTotalIC()
	local targetIC = baseIC * (1 + country:GetGlobalModifier():GetValue(CModifier._MODIFIER_GLOBAL_IC_):Get())
	local icDiff = targetIC - totalIC
	
	local amount = math.max(-1 * balance, 0)
	if goods == CGoodsPool._ENERGY_ then
		amount = math.max(amount, icDiff * 2)
	elseif goods == CGoodsPool._METAL_ then
		amount = math.max(amount, icDiff)
	elseif goods == CGoodsPool._RARE_MATERIALS_ then
		amount = math.max(amount, icDiff / 2)
	else
		-- Don't buy if economy is still not working
		if icDiff > 1 then
			return 0
		else
			local money = GetAverageBalance(country, CGoodsPool._MONEY_)
			if HasMinStock(country, goods) then
				-- Don't buy more than we can afford
				amount = math.min(amount, math.max(money / GetGoodsCost(goods), 0))
			end
		end
	end
	
	if amount > 0 and amount < MinTradeSize(country) then
		amount = MinTradeSize(country)
	end
	
	return amount * 1.25
end

function MinTradeSize(country)
	-- 10% IC but no more than 5
	return math.min(math.max(country:GetTotalIC()/10, country:GetMaxIC()/10), 5)
end

function ProposeTrades(ai, aliceTag)
	local aliceCountry = aliceTag:GetCountry()
	if aliceCountry:isPuppet() then
		return -- Trading for puppets not allowed
	end

	-- see what we are low on and find someone who is hoarding it

	-- Buy either fuel or oil
	local fuelOrOil = CGoodsPool._FUEL_
	if math.mod(CCurrentGameState.GetAIRand(), 2) == 0 then
		fuelOrOil = CGoodsPool._CRUDE_OIL_
	end

	local aliceMinTradeSize = MinTradeSize(aliceCountry)
	for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
		if goods ~= CGoodsPool._MONEY_ and goods ~= fuelOrOil then
			--Utils.LUA_DEBUGOUT(tostring( aliceTag ).." "..tostring(GOODS_TO_STRING[goods]))
			
			local bestScore = -10000
			local bestAction = nil

			-- buy
			local aliceBuys = Buying(aliceCountry, goods)
			-- we need it, we have no max stock, we are not exporting it
			--if tostring(aliceTag) == 'FRA' then
			--	Utils.LUA_DEBUGOUT("FRA buys " .. tostring(aliceBuys) .. " " .. GOODS_TO_STRING[goods])
			--end

			if aliceBuys >= aliceMinTradeSize then -- buying?
 				-- Utils.LUA_DEBUGOUT(tostring( aliceTag ).." --- BUYING --- " .. aliceBuys .. " " .. tostring(GOODS_TO_STRING[goods]))
				-- lets check every possible trading partner
				for bobCountry in CCurrentGameState.GetCountries() do
					local bobTag = bobCountry:GetCountryTag()
					
					local relation = aliceCountry:GetRelation(bobTag)

					if	bobTag ~= aliceTag and
						IsValidCountry(bobCountry) and
						(
							not bobCountry:isPuppet() or
							bobCountry:GetOverlord() == aliceTag
						) and
						not aliceCountry:HasDiplomatEnroute(bobTag) and
						not (aliceCountry:NeedConvoyToTradeWith(bobTag) and aliceCountry:GetTransports() == 0) and
						(
							-- There's no reason to buy anything if we can't afford it, except if we are allowed to make debts.
							not IsPoor(aliceCountry) or
							relation:AllowDebts()
						)
					then
						local bobSells = Selling(bobCountry, goods)
						if bobSells >= aliceMinTradeSize then
							-- Utils.LUA_DEBUGOUT(tostring( bobTag ).." --- SELLING --- " .. bobSells .. " " .. tostring(GOODS_TO_STRING[goods]))
							local tradeAction = CTradeAction(aliceTag, bobTag)
							
							if tradeAction:IsValid() and tradeAction:IsSelectable() and tradeAction:IsConvoyPossible() then
								tradeAction:SetTrading(CFixedPoint(math.min(aliceBuys, bobSells, 50)), goods)
								
								local score = relation:GetValue():Get() + 200
								local chance = tradeAction:GetAIAcceptance() - ai:GetSpamPenalty(bobTag)
								
								score = score * chance * (0.9 + math.mod(CCurrentGameState.GetAIRand(), 21) / 100)
								
								if chance > 50 and score > bestScore then
									bestAction = tradeAction
									bestScore = score
								end
							end
						end
					end
				end
 				--Utils.LUA_DEBUGOUT(tostring( aliceTag ).." --- DONE BUYING --- "..tostring(GOODS_TO_STRING[goods]))
				if bestAction then
					ai:PostAction(bestAction)
				end
			end -- otherwise not top stock but pos. balance so no action needed
		end
	end
end

function DiploScore_OfferTrade(ai, alice, bob, observer, action)
	-- if alice human and man trade return 100
	-- if bob human and human trade return 100

	if observer == alice then
		--Utils.LUA_DEBUGOUT("DiploScore_OfferTrade"..tostring(alice).." is observer so return 100")
		return 100 -- handled from foreign minister
	else -- evaluate offer of trade from alice
		local score = 666
		local aliceCountry = alice:GetCountry()
		local bobCountry = bob:GetCountry()
		local route = action:GetRoute()
		local isLandRoute = false

		--BUGGED: if ai:AlreadyTradingResourceOtherWay(action:GetRoute()) 
		if ai:AlreadyTradingDisabledResource(action:GetRoute())
		then
			--Utils.LUA_DEBUGOUT("+x+x++x+x+xalready trading that+x+x++x+x+x")
			return 0
		end

		-- we need transports to trade
		if aliceCountry:NeedConvoyToTradeWith( bob ) then
			if route:GetConvoyResponsible() == bob then
				if bobCountry:GetTransports() == 0 then
					--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( bob ))
					return 0
				end
			elseif aliceCountry:GetTransports() == 0 then
				--Utils.LUA_DEBUGOUT(" No convoys available! "..tostring( alice ))
				return 0
			end
		else
			isLandRoute = true
		end
		--Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." -> DiploScore_OfferTrade ")
		local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
		for goods = 0, MAX_GOODS do
			-- buggy
--~ 			if ai:AlreadyTradingResourceOtherWay( action:GetRoute() ) then
--~ 				Utils.LUA_DEBUGOUT(" Already Importing! ".. tostring( GOODS_TO_STRING[goods]))
--~ 				--return 0
--~ 			else

			-- 'we' sell to bob A2B good and B2A money
			local alice2Bob = route:GetTradedFromOf(goods):Get()
			-- 'we' buy from bob B2A good and A2B money
			local bob2Alice = route:GetTradedToOf(goods):Get()


			if goods ~= CGoodsPool._MONEY_ then
				-- to-do reverse check!!!
				if not IsTradeControlledByHuman(alice) then
					-- we try to sell to bob but bob already sells that good or we import it
					if alice2Bob>0 and (ExistsExport(bob, goods) or ExistsImport(alice, goods))	then
						--Utils.LUA_DEBUGOUT(tostring(bob).." export route exists (1)!")
						return 0
					end
					-- we try to buy but already export the good or bob imports it
					if bob2Alice>0 and (ExistsExport(alice, goods) or ExistsImport(bob, goods))	then
						--Utils.LUA_DEBUGOUT(tostring(alice).." export route exists (2)!")
						return 0
					end
				end

				if bob2Alice>0 or alice2Bob>0 then
					score = math.min(score, ScoreTradeOfGood(goods, alice2Bob, aliceCountry, bob2Alice, bobCountry))
					--Utils.LUA_DEBUGOUT(tostring(aliceCountry:GetCountryTag()).."<->"..tostring(bobCountry:GetCountryTag())
						--..tostring( GOODS_TO_STRING[goods]).." Score: "..tostring(score))
				end
--~ 				Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." -> bob2Alice "..tostring(bob2Alice).." ".. tostring( GOODS_TO_STRING[goods]))

--~ 				.." alice2Bob:"..tostring(alice2Bob).." bob2Alice:"..tostring(bob2Alice))
			end
		end
		if score == 666 then
			score = 0 -- no good scored
		elseif isLandRoute then
			score = score*1.1 -- land route is better
		end

	--Utils.LUA_DEBUGOUT(" Final Score: " ..tostring( score ))
	--Utils.LUA_DEBUGOUT("---------------")

 		--Utils.LUA_DEBUGOUT("score before strategy " .. score)
		if score ~= 0 then
			--Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." StrategicScore: " ..tostring( StrategicScore(ai, alice, bob) ))
			--Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." StrategicScore: " ..tostring( StrategicScore(ai, bob, alice) ))
			-- +/- 20%
			score = score + score*StrategicScore(ai, alice, bob)/100
		end
		--Utils.LUA_DEBUGOUT("score after strategy " .. score)
		-- 0 to 100
		return math.max(0, math.min(100, Utils.CallScoredCountryAI(alice, 'DiploScore_OfferTrade', score, ai, alice, bob, observer)))
	end
end

-- return -20 to +20
function StrategicScore(ai, alice, bob)
	local score = 0
	local rel = ai:GetRelation(alice, bob)
	local aliceCountry = alice:GetCountry()
	local bobCountry = bob:GetCountry()
	local strategy = aliceCountry:GetStrategy()

--~ 			Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." Score: " ..tostring( score )
--~ 				.." GetThreat: "..tostring(rel:GetThreat():Get())
--~ 				.." CalculateAlignmentFactor: "..tostring(CalculateAlignmentFactor(ai, aliceCountry, bobCountry))
--~ 				.." strategy:GetAntagonism("..tostring(alice).."): "..tostring(strategy:GetAntagonism(alice))
--~ 				.." strategy:GetFriendliness("..tostring(alice).."): "..tostring(strategy:GetFriendliness(alice))
--~ 				.." rel:GetValue():GetTruncated(): "..tostring(rel:GetValue():GetTruncated())
--~ 				)

	if rel:IsFightingWarTogether() then
--~ 	Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." IsFightingWarTogether")
		return 20
	else
		-- -10 to +10 (for -200 to 200 relationship)
		score = score + rel:GetValue():GetTruncated()/20 --
		-- 0 to -10 (for 0-100 thread * alignment)
		score = score - math.min(10, (rel:GetThreat():Get()* CalculateAlignmentFactor(ai, aliceCountry, bobCountry))/10)
		-- 0 to -10 (for 0 to 400)
		score = score - math.min(10, strategy:GetAntagonism(alice) / 40)
		-- 0 to +10 (for 0 to 400)
		score = score + math.min(10, strategy:GetFriendliness(alice) / 40)
		-- -5 to +5 (for 1 to 0 alignment)
		score = score + 5-10*CalculateAlignmentFactor(ai, aliceCountry, bobCountry)
		if rel:IsGuaranteed() then
--~ 		Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." IsGuaranteed")
			score = score + 5
		end
		if rel:HasFriendlyAgreement() then
--~ 		Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." HasFriendlyAgreement")
			score = score + 10
		end
		if rel:AllowDebts() then
--~ 		Utils.LUA_DEBUGOUT(tostring(alice).."2"..tostring(bob).." AllowDebts")
			score = score + 5
		end
	end
	return math.max(-20, math.min(20,score))
end

function ScoreTradeOfGood(goods, alice2Bob, aliceCountry, bob2Alice, bobCountry)
 	--Utils.LUA_DEBUGOUT(tostring(aliceCountry:GetCountryTag()).."2"..tostring(bobCountry:GetCountryTag()).." -> ScoreTradeOfGood ")
	if bob2Alice > 0 then
 		--Utils.LUA_DEBUGOUT(tostring(bobCountry:GetCountryTag()).."2"..tostring(aliceCountry:GetCountryTag()).." -> ScoreTradeOfGood bob2Alice:"..tostring(bob2Alice))
		return ScoreTradeOfGoodCalc(goods, bob2Alice, bobCountry, aliceCountry)
	end
	if alice2Bob > 0 then
 		--Utils.LUA_DEBUGOUT(tostring(aliceCountry:GetCountryTag()).."2"..tostring(bobCountry:GetCountryTag()).." -> ScoreTradeOfGood alice2Bob:"..tostring(alice2Bob))
		return ScoreTradeOfGoodCalc(goods, alice2Bob, aliceCountry, bobCountry)
	end
	-- not a traded good
	return 0
end

-- returns 0 to 100 points
function ScoreTradeOfGoodCalc(goods, amount, sellerCountry, buyerCountry)
 	--Utils.LUA_DEBUGOUT(tostring(sellerCountry:GetCountryTag()).."2"..tostring(buyerCountry:GetCountryTag()).." -> ScoreTradeOfGoodCalc ")
	local sellerDemand = Selling(sellerCountry, goods)
	local buyerDemand = Buying(buyerCountry, goods)

	if IsTradeControlledByHuman(sellerCountry:GetCountryTag()) then
		sellerDemand = amount
	end
	if IsTradeControlledByHuman(buyerCountry:GetCountryTag()) then
		buyerDemand = amount
	end

	-- if tostring(sellerCountry:GetCountryTag())=='JAP' or tostring(buyerCountry:GetCountryTag())=='JAP' then
		--Utils.LUA_DEBUGOUT(tostring(sellerCountry:GetCountryTag()).."2"..tostring(buyerCountry:GetCountryTag()).." "
		-- ..tostring( GOODS_TO_STRING[goods]).." "..tostring(sellerDemand).." <2> "..tostring(buyerDemand).." amount:"..tostring(amount)	)
	-- end
	
	if 	IsInBetween(amount, MinTradeSize(sellerCountry), sellerDemand) and
		IsInBetween(amount, MinTradeSize(buyerCountry), buyerDemand)
	then
		return 100
	else
		-- asking too much?
		if amount > sellerDemand or amount > buyerDemand then
			return 0
		end

		if sellerDemand > 0 and buyerDemand > 0 then
			-- buyer satisfaction 1 to 0
			local buyerScore = math.min(50, amount) / math.min(50, buyerDemand) --+ 0.5 * (1-math.min(1, BuyerStock/90000))
			-- seller satisfaction 1 to 0
			local sellerScore = math.min(MinTradeSize(sellerCountry), amount) / MinTradeSize(sellerCountry) --+ 0.5 * math.min(1, SellerStock/90000)
			return 100 * math.min(buyerScore, math.min(sellerScore + 0.5, 1))
		end
	end
	
	return 0
end

function IsInBetween(value, left, right)
	if value >= left and value <= right then
		return true
	else
		return false
	end
end

