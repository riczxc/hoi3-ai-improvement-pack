require('utils')
require('helper_functions')

local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }

function ForeignMinister_ManageTrade(ai, ministerTag)
	--Utils.LUA_DEBUGOUT("ForeignMinister_ManageTrade - " .. tostring(ministerTag) )
	--Utils.LUA_DEBUGOUT("------------------------------------------------------------")

	-- It's important this function is called everytime
	HFInit_ManageTrade(ai, ministerTag)

	local ministerCountry = ministerTag:GetCountry()
	if not IsValidCountry(ministerCountry) then
		--Utils.LUA_DEBUGOUT("ForeignMinister_ManageTradeEnd - " .. tostring(ministerTag) )
		return
	end

	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.TRADE_DELAY) == 0 then
		ProposeTrades(ai, ministerTag)
	end
	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.TRADE_DELAY * 2) == 0 then
		EvalutateExistingTrades(ai, ministerTag)
	end

	--Utils.LUA_DEBUGOUT("ForeignMinister_ManageTradeEnd - " .. tostring(ministerTag) )
end

function EvalutateExistingTrades(ai, aliceTag)
	--if tostring(aliceTag) == 'GER' then
		--Utils.LUA_DEBUGOUT("------------------------------------------------------------")
		--Utils.LUA_DEBUGOUT("EvalutateExistingTrades - " .. tostring(aliceTag) )
	--end

	HFInit_TradedGoods(aliceTag)

	local aliceCountry = aliceTag:GetCountry()
	local desireInMoney = GetDesireInGoods(aliceCountry, CGoodsPool._MONEY_)
	local cgOpPenalty = GetCGOverProductionPenalty(aliceCountry)

	for bobCountry in CCurrentGameState.GetCountries() do
		local bobTag = bobCountry:GetCountryTag()
		if bobCountry:Exists() and bobTag:IsReal() and bobTag:IsValid()
			and not (aliceTag == bobTag)
		then
			local routes = aliceCountry:GetRelation(bobTag):GetTradeRoutes()
			for route in routes do
				if route:IsValid() then
					if route:IsInactive() and ai:HasTradeGoneStale(route) then
						--if tostring(aliceTag) == tostring(playerTag) then
							--Utils.LUA_DEBUGOUT("	Canceling a trade with " .. tostring(bobTag))
							--Utils.LUA_DEBUGOUT("		Reason: inactive")
						--end
						CancelTrade(ai, route, aliceTag, bobTag)
					else -- ok, but can we do better?
						local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
						for goods = 0, MAX_GOODS do
							-- 'we' buy from Bob
							local bob2Alice = route:GetTradedToOf(goods):Get()

							if goods ~= CGoodsPool._MONEY_ and bob2Alice ~= 0 then
								-- direction?
								-- < 0 we sell -> we make money
								-- > 0 we buy -> we lose money
								if tostring(route:GetConvoyResponsible()) == tostring(bobTag) then
									bob2Alice = -1*bob2Alice
								end

								-- > 0 we want these goods
								-- < 0 we want to get rid of them
								local desireOfAlice = GetDesireInGoods(aliceCountry, goods)
								local canceled = false

								if (goods == CGoodsPool._SUPPLIES_ or goods == CGoodsPool._FUEL_ or goods == CGoodsPool._CRUDE_OIL_)
									and (bob2Alice > 0) -- we buy
									and ((desireInMoney > ai_configuration.TRADING_CANCEL_THRESHOLD) or (cgOpPenalty > 1)) -- but we've no money for this
								then
									if goods == CGoodsPool._SUPPLIES_ then
										-- Cancel them
										if math.mod( CCurrentGameState.GetAIRand(), 2) == 0 then
											CancelTrade(ai, route, aliceTag, bobTag)
											canceled = true
										end
									elseif goods == CGoodsPool._FUEL_ or goods == CGoodsPool._CRUDE_OIL_ then
										-- Cancel if desire is not too high
										--if tostring(aliceTag) == 'GER' then
											--Utils.LUA_DEBUGOUT("	Desire is " .. tostring(desireOfAlice))
										--end
										if desireOfAlice < (ai_configuration.TRADING_THRESHOLD / 2) then
											if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
												CancelTrade(ai, route, aliceTag, bobTag)
												canceled = true
												--if tostring(aliceTag) == 'GER' then
													--Utils.LUA_DEBUGOUT("	Canceled trade with " .. tostring(bobTag) .. " of " .. tostring(bob2Alice) .. " " .. GOODS_TO_STRING[goods])
													--Utils.LUA_DEBUGOUT("		Reason: not enough money")
												--end
											end
										end
									end
								end

								if not canceled then
									if (bob2Alice * desireOfAlice < 0) -- not ok
										and (
												(desireOfAlice > (ai_configuration.TRADING_THRESHOLD / 2)) -- Cancel before we get the chance to buy again
											or
												(desireOfAlice < -ai_configuration.TRADING_CANCEL_THRESHOLD) -- We do really have enough
										)
									then
										if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
											CancelTrade(ai, route, aliceTag, bobTag)
											canceled = true
											--if tostring(aliceTag) == tostring(playerTag) then
												--Utils.LUA_DEBUGOUT("	Canceled trade with " .. tostring(bobTag) .. " of " .. tostring(bob2Alice) .. " " .. GOODS_TO_STRING[goods])
												--Utils.LUA_DEBUGOUT("		Reason: too low desire")
											--end
										end
									end
								end

								if not canceled then
									HFUpdate_TradedGoods(aliceTag, goods, bob2Alice)
								end
							end
						end
					end
				end
			end
		end
	end
	--Utils.LUA_DEBUGOUT("EvalutateExistingTradesEnd - " .. tostring(aliceTag) )
end

function CancelTrade(ai, route, AliceTag, BobTag)
	local cancel = CTradeAction(AliceTag, BobTag)
	cancel:SetRoute(route)
	cancel:SetValue(false)
	if cancel:IsValid() then
		ai:PostAction(cancel)
	end
end

function ProposeTrades(ai, aliceTag)
	--if 1 == 1 then
		--return
	--end
	--if tostring(aliceTag) == 'GER' then
		--Utils.LUA_DEBUGOUT("------------------------------------------------------------")
		--Utils.LUA_DEBUGOUT("ProposeTrades - " .. tostring(aliceTag) )
	--end

	local aliceCountry = aliceTag:GetCountry()

	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	for goods = 0, MAX_GOODS do
		if goods ~= CGoodsPool._MONEY_ then
			local desireOfAlice = GetDesireInGoods(aliceCountry, goods)
			local aliceBuysFromPlayer = false

			--if tostring(aliceTag) == 'GER' then
				--Utils.LUA_DEBUGOUT("Desire in " .. GOODS_TO_STRING[goods] .. " is " .. tostring(desireOfAlice) )
			--end

			-- We're only buying here
			if desireOfAlice > ai_configuration.TRADING_THRESHOLD then
				local tradeIntervalAlice = GetTradeInterval(aliceCountry, goods)
				--if tostring(aliceTag) == 'GER' then
					--Utils.LUA_DEBUGOUT("Trade interval between " .. tostring(tradeIntervalAlice[1]) .. " and " .. tostring(tradeIntervalAlice[2]))
				--end
				if tradeIntervalAlice[2] > 0 then
					local possibleTrades = {}
					local tradeAmountAlice = tradeIntervalAlice[2]
					local intervalNodes = IntervalTree.GetOverlappingIntervals(gGLOBALS["interval_trees"][goods], tradeIntervalAlice)

					for i = 1, #intervalNodes do
						local bobCountry = intervalNodes[i].data
						local bobTag = bobCountry:GetCountryTag()

						if not (aliceCountry:HasDiplomatEnroute(bobTag))
							and not (aliceTag == bobTag)
						then
							local tradeIntervalBob = intervalNodes[i].int
							local tradeAmountBob = tradeIntervalBob[2]

							--if tostring(aliceTag) == 'GER' then
								--Utils.LUA_DEBUGOUT("	Possible trading partner for " .. GOODS_TO_STRING[goods] .. ": " .. tostring(bobTag))
								--Utils.LUA_DEBUGOUT("		They would sell between " .. tradeIntervalBob[1] .. " and " .. tostring(tradeIntervalBob[2]))
							--end

							local tradeAmount = math.min(tradeAmountAlice, tradeAmountBob, 50)

							local tradeAction = CTradeAction(aliceTag, bobTag)
							if tradeAction:IsValid() and tradeAction:IsSelectable() then
								tradeAction:SetTrading( CFixedPoint(tradeAmount), goods )

								local acceptanceChance = tradeAction:GetAIAcceptance()
								acceptanceChance = acceptanceChance - ai:GetSpamPenalty(bobTag)

								if acceptanceChance > 50
									and tradeAction:IsConvoyPossible()
								then
									--if tostring(aliceTag) == 'GER' then
										--Utils.LUA_DEBUGOUT("	Possible trade with a chance of " .. tostring(acceptanceChance) .. "%:")
										--Utils.LUA_DEBUGOUT("		Trade amount:" .. tostring(tradeAmount) )
									--end

									--local price = GetTradePrice(ai, AliceTag, BobTag, goods)
									local price = tradeAction:GetTrading(CGoodsPool._MONEY_, aliceTag ):Get() / tradeAmount
									table.insert(possibleTrades, { price, tradeAmount, tostring(bobTag), tradeAction })

									--if bobTag == playerTag then
										--Utils.LUA_DEBUGOUT("	Possible buyer " .. tostring(aliceTag) .. " of " .. GOODS_TO_STRING[goods] .. " with a chance of " .. tostring(acceptanceChance) .. "%:")
										--Utils.LUA_DEBUGOUT("		Trade amount:" .. tostring(tradeAmount) )
										--Utils.LUA_DEBUGOUT("		Price:" .. tostring(price) )
										--aliceBuysFromPlayer = true
									--end
								end
							end
						end
					end

					if desireOfAlice > 0 then
						-- We want to buy, aim for lowest price
						table.sort(possibleTrades, function(x, y) return x[1] < y[1] end) -- lowest price first
					else
						-- We want to sell, aim for highest price
						table.sort(possibleTrades, function(x, y) return x[1] > y[1] end) -- highest price first
					end

					local i = 1
					while (tradeAmountAlice > 0) and not (possibleTrades[i] == nil) do
						local price = possibleTrades[i][1]
						local tradeAmount = possibleTrades[i][2]
						local bob = possibleTrades[i][3]
						local TradeAction = possibleTrades[i][4]

						-- Add some random factor
						if math.mod( CCurrentGameState.GetAIRand(), 3) == 0 then
							--if aliceBuysFromPlayer and bob ~= tostring(playerTag) then
								--Utils.LUA_DEBUGOUT(tostring(aliceTag) .. " is instead buying " .. tostring(tradeAmount) .. " " .. GOODS_TO_STRING[goods] .. " from " .. bob .. " for " .. tostring(price) .. " each.")
							--end

							--if tostring(aliceTag) == 'GER' then
								--if desireOfAlice > 0 then
									--Utils.LUA_DEBUGOUT("Try to buy " .. tostring(tradeAmount) .. " " .. GOODS_TO_STRING[goods] .. " from " .. bob .. " for " .. tostring(price) .. " each")
								--else
								--	Utils.LUA_DEBUGOUT("Try to sell " .. tostring(tradeAmount) .. " " .. GOODS_TO_STRING[goods] .. " to " .. bob .. " for " .. tostring(price) .. " each")
								--end
							--end

							ai:PostAction( TradeAction )

							tradeAmountAlice = tradeAmountAlice - tradeAmount
						end

						i = i + 1
					end
				end
			end
		end
	end
	--Utils.LUA_DEBUGOUT("ProposeTradesEnd - " .. tostring(aliceTag) )
end

function DiploScore_OfferTrade(ai, actor, recipient, observer, action)
	--Utils.LUA_DEBUGOUT(" DiploScore_OfferTrade - actor: " .. tostring(actor) .. " recipient: " .. tostring(recipient) .. " observer: " .. tostring(observer))

	--if ai:AlreadyTradingResourceOtherWay( action:GetRoute() ) then
		--return 0
	--end

	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()
	local route = action:GetRoute()

	-- we need transports to trade
	if actorCountry:NeedConvoyToTradeWith( recipient ) then
		if route:GetConvoyResponsible() == recipient and recipientCountry:GetTransports() == 0 then
			--Utils.LUA_DEBUGOUT("Recipient " .. tostring(recipient) .. " is responsible but doesn't have enough convoys.")
			return 0
		elseif actorCountry:GetTransports() == 0 then
			--Utils.LUA_DEBUGOUT("Actor " .. tostring(actor) .. " is responsible but doesn't have enough convoys.")
			return 0
		end
	end

	local totalAmount = 0
	local finalScore = 1
	local MAX_GOODS = CGoodsPool._GC_NUMOF_-1
	for goods = 0, MAX_GOODS do
		--if goods ~= CGoodsPool._MONEY_ then
			local amount2actor = route:GetTradedToOf(goods):Get()
			local amount2recipient = route:GetTradedFromOf(goods):Get()

			local amount = 0
			if amount2actor ~= 0 then
				amount = amount2actor
			elseif amount2recipient ~= 0 then
				amount = -amount2recipient
			end

			local scoreActor = 1
			local scoreRecipient = 1
			if amount ~= 0 then
				-- Actor should know what he's doing
				--if not IsTradeControlledByHuman(actor) then
					--local tradeInterval = GetTradeInterval(actorCountry, goods)
					local desire = GetDesireInGoods(actorCountry, goods)
					--if IntervalTree.Overlaps(tradeInterval, { amount, amount }) then
						--scoreActor = (desire + 1) / 2
					--else
						--scoreActor = 0
					--end
					--Utils.LUA_DEBUGOUT("Actor: Desire of " .. tostring(actor) .. " in " .. GOODS_TO_STRING[goods] .. " is " .. tostring(desire))
				--end
				if not IsTradeControlledByHuman(recipient) then
					local tradeInterval = GetTradeInterval(recipientCountry, goods)
					local desire = GetDesireInGoods(recipientCountry, goods)

					amount = -amount
					if IntervalTree.Overlaps(tradeInterval, { amount - math.abs(amount * 0.1), amount + math.abs(amount * 0.1) }) then
						if amount > 0 then
							if goods == CGoodsPool._MONEY_ then
								desire = math.max(desire, 0.2) -- always keep a light desire in money. to be rich is not soo bad...
							end
							scoreRecipient = (desire + 1) / 2
						else
							scoreRecipient = (-desire + 1) / 2
						end
					else
						scoreRecipient = 0
					end
					--if (scoreRecipient == 0) or (finalScore == 0) then
						--Utils.LUA_DEBUGOUT("Recipient: Desire of " .. tostring(recipient) .. " in " .. tostring(amount) .. " " .. GOODS_TO_STRING[goods] .. " is " .. tostring(desire) .. " -> " .. tostring(scoreRecipient))
						--Utils.LUA_DEBUGOUT("Tradeinterval between " .. tostring(tradeInterval[1]) .. " and " .. tostring(tradeInterval[2]))
					--end
				end
			end

			totalAmount = totalAmount + math.abs(amount)

			finalScore = math.min(scoreActor, scoreRecipient, finalScore)
			--Utils.LUA_DEBUGOUT(GOODS_TO_STRING[goods] .. " scoreActor: " .. tostring(scoreActor) .. " scoreRecipient: " .. tostring(scoreRecipient) .. " finalScore: " .. tostring(finalScore))
		--end
	end

	if totalAmount == 0 then
		return 0
	end

	local rel = ai:GetRelation(recipient, actor)
	local strategy = recipient:GetCountry():GetStrategy()
	local bonus = strategy:GetFriendliness(actor) / 15 - strategy:GetAntagonism(actor) / 15 - rel:GetThreat():Get() / 2
	if rel:IsGuaranteed() then
		bonus = bonus + 5
	end
	if rel:HasFriendlyAgreement() then
		bonus = bonus + 10
	end
	if rel:AllowDebts() then
		bonus = bonus + 5
	end
	if rel:IsFightingWarTogether() then
		bonus = bonus + 15
	end
	if rel:HasEmbargo() then
		return 0
	end

	--Utils.LUA_DEBUGOUT("Bonus between " .. tostring(actor) .. " and " .. tostring(recipient) .. " is " .. tostring(bonus) .. "%")

	finalScore = finalScore * (100 + bonus)

	--Utils.LUA_DEBUGOUT("Final score is " .. tostring(finalScore))

	return math.min(100, Utils.CallScoredCountryAI(recipient, 'DiploScore_OfferTrade', finalScore, ai, actor, recipient, observer))
end
