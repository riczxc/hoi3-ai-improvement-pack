-----------------------------------------------------------
-- Diplomatic action evaluation
-- 
-----------------------------------------------------------

require('utils')
require('helper_functions')

function CalculateAlignmentFactor(ai, country1, country2)
	local dist = ai:GetCountryAlignmentDistance( country1, country2 ):Get()
	return math.min(dist / 400.0, 1.0)
end

function DiploScore_InfluenceNation(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT( " DiploScore_InfluenceNation Mod ")
	if observer == actor then
		local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()
		local actorFaction = actorCountry:GetFaction() 
		local dist = ai:GetNormalizedAlignmentDistance(recipientCountry, actorFaction):Get() / 50
		-- close to joining our faction?
		if dist > 1.0 and dist < 21.0 and actorCountry:GetMaxIC() > ai_configuration.MINIMUM_IC_TO_INFLUENCE then
			local factor = 21.0 - (dist - 1.0)
			factor = 2.5 * factor
				--Utils.LUA_DEBUGOUT("Factor = " .. tostring(factor ) )
			if recipientCountry:IsNeighbour(actor) then
				factor = factor + 10
			end
			
			local importanceFactor = 0
			local maxIC = recipientCountry:GetMaxIC()
			local maxActorIC = actorCountry:GetMaxIC()
			
			importanceFactor = importanceFactor + ( 50 * ( maxIC / maxActorIC ) )
				--Utils.LUA_DEBUGOUT("Factor 2 = " .. tostring(factor ) )		
			-- factor neutrality
			if importanceFactor > 0 then
				local effectiveNeutrality = recipientCountry:GetNeutrality():Get() - recipientCountry:GetRelation( recipientCountry:GetHighestThreat() ):GetThreat():Get()
				if effectiveNeutrality > 90 then
					importanceFactor = importanceFactor - 50
				elseif effectiveNeutrality > 80 then
					importanceFactor = importanceFactor - 30
				elseif effectiveNeutrality > 60 then
					importanceFactor = importanceFactor - 10
				end
			end
			factor = factor + importanceFactor

			--Utils.LUA_DEBUGOUT("Importance factor = " .. tostring(factor ) )
			return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', factor, ai, actor, recipient, observer)
		elseif ai_configuration.COUNTER_INFLUENCE == 1 then
			-- close to other faction?
			for faction in CCurrentGameState.GetFactions() do
				if faction:IsValid() and not (faction == actorFaction) then
					dist = ai:GetNormalizedAlignmentDistance(recipientCountry, faction):Get()
					--Utils.LUA_DEBUGOUT("Align dist: " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. dist )
					if dist > 0.5 and dist < 2.0 then
					
						-- check if its futile to try and move them
						local affectable = false
						local al = recipient:GetCountry():GetAlignment()
						local towardsActorDrift = al:GetLastDrift( actorFaction:GetIdeologyGroup() ):Get()
						local factionDrift = al:GetLastDrift( faction:GetIdeologyGroup() ):Get() 
						local driftDiff = factionDrift - towardsActorDrift
						
						--Utils.LUA_DEBUGOUT("*** close to other *****")
						--Utils.LUA_DEBUGOUT("factionDrift: " .. factionDrift)
						--Utils.LUA_DEBUGOUT("towardsActordrift: " .. towardsActorDrift)
						--Utils.LUA_DEBUGOUT("driftDiff: " .. driftDiff)
						--Utils.LUA_DEBUGOUT("factor: " .. (1 / driftDiff) )
						--Utils.LUA_DEBUGOUT("******************")


						if driftDiff > 0 then 
							local factor = 1 / driftDiff
							if factor > 0.2 then
								affectable = true
							end
						end

						if true then --affectable then
							local factor = 1.0 - (dist - 1.0)
							factor = factor * 100
							
							--Utils.LUA_DEBUGOUT( tostring(actor) .. " trying to counter  influence " .. tostring(recipient) .. " - affectable - factor: " ..	factor )
							
							if recipientCountry:IsNeighbour(actor) then
								factor = factor + 10
							end
							-- calculate importance
							local importanceFactor = 0
							local maxIC = recipientCountry:GetMaxIC()
							local ourMaxIC = actorCountry:GetMaxIC()

							importanceFactor = importanceFactor + ( 50 * ( maxIC / maxActorIC ) )

							--if maxIC > ourMaxIC then
							--	importanceFactor = math.max(importanceFactor, importanceFactor + math.min(60, ((maxIC/ourMaxIC)-1)*15) )
							--else
							--	importanceFactor = math.max(importanceFactor, importanceFactor + math.max(-40, ((ourMaxIC/maxIC)-1)*44.444) )
							--end
							


							-- factor neutrality
							--if importanceFactor > 0 then
								--local effectiveNeutrality = recipientCountry:GetNeutrality():Get() - recipientCountry:GetRelation( recipientCountry:GetHighestThreat() ):GetThreat():Get()
								-- reisender
								--importanceFactor = math.min(importanceFactor, importanceFactor - math.min(30, effectiveNeutrality-60) )
							--end		

							if importanceFactor > 0 then
								local effectiveNeutrality = recipientCountry:GetNeutrality():Get() - recipientCountry:GetRelation( recipientCountry:GetHighestThreat() ):GetThreat():Get()
								if effectiveNeutrality > 90 then
									importanceFactor = importanceFactor - 50
								elseif effectiveNeutrality > 80 then
									importanceFactor = importanceFactor - 30
								elseif effectiveNeutrality > 60 then
									importanceFactor = importanceFactor - 10
								end
							end

		
							factor = factor + importanceFactor
							return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', factor, ai, actor, recipient, observer)
						end
					end	
				end
			end
			
			-- neighbor?
			if recipientCountry:IsNeighbour(actor) then
				local score = 0
				local rel = ai:GetRelation(recipient, actor)
				local strategy = recipient:GetCountry():GetStrategy()
				score = score + strategy:GetFriendliness(actor) / 4
				score = score - strategy:GetAntagonism(actor) / 4
				score = score - rel:GetThreat():Get() / 2
			
				if score > 0 then
					local relation = rel:GetValue():GetTruncated()
					score = score + relation / 2
				end
				
				if score > 65 then
					score = 65 -- dont want to overshadow other juicy targets
				end
				
				return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
			end
		end

		return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', 0, ai, actor, recipient, observer)
	else
		return 100 -- we cant respond to this
	end
end
-- for debugging
local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }



function DiploScore_InviteToFaction(ai, actor, recipient, observer)
	if observer == actor then -- are recipient worth inviting
		local recipientCountry = recipient:GetCountry()
		if recipientCountry:IsAtWar() then
			-- is our war target at war with the faction
			for diploStatus in recipientCountry:GetDiplomacy() do
				local target = diploStatus:GetTarget()
				if target:IsValid() and diploStatus:HasWar() then
					if actor:GetCountry():GetRelation(target):HasWar() then
						return 100
					end
				end				
			end
			score = 100 --at war with someone is no problem
		
			if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
				score = Utils.CallScoredCustomAI('CustomFactionInviteRules', score, ai, actor, recipient, observer)
			else
				--score = CustomFactionJoinRules( score, ai, actor, recipient, observer)
			end
			return score
		else
			score = 100 --at war with someone is no problem
			if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
				score = Utils.CallScoredCustomAI('CustomFactionInviteRules', score, ai, actor, recipient, observer)
			else
				--score = CustomFactionJoinRules( score, ai, actor, recipient, observer)
			end
			return score
		end
	else -- do we, recipient want to accept invite to faction
		--Utils.LUA_DEBUGOUT("-------------------------------------")
		--Utils.LUA_DEBUGOUT("DiploScore_InviteToFaction (" .. tostring( actor )  .. "->" .. tostring( recipient ) .. ")")
		local faction = actor:GetCountry():GetFaction()
		
		--if recipient:GetCountry():IsNeighbourToFactionHostile(faction) then
		--	return 0
		--end
		
		local dist = ai:GetNormalizedAlignmentDistance(recipient:GetCountry(), faction):Get() / 50
		--Utils.LUA_DEBUGOUT("dist: " .. dist)
		if dist < 1 then
			local score = 100 * (1.0 - (dist/2.0)) -- closeness
			local progress = faction:GetNormalizedProgress() 
			score = score + 100 * progress
			--Utils.LUA_DEBUGOUT("score: " .. dist)
			
			local strategy = recipient:GetCountry():GetStrategy()
			score = score + strategy:GetFriendliness(actor) / 2
			score = score + strategy:GetThreat(actor) / 2
			score = score - strategy:GetAntagonism(actor) / 2
			--Utils.LUA_DEBUGOUT("score: " .. dist)
			--Utils.LUA_DEBUGOUT("-------------------------------------")
			--return CustomFactionAcceptRules( score, ai, actor, recipient, observer)			
			-- at war with someone is no problem
			if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
				score = Utils.CallScoredCustomAI('CustomFactionAcceptRules', score, ai, actor, recipient, observer)
			else
				score = Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
			end
			return score
		else
			return 0
		end
	end
end


function DiploScore_Guarantee(ai, actor, recipient, observer)
	local score = 0

	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()
		if actorCountry:HasFaction() and actorCountry:GetFaction() == recipientCountry:GetFaction() then
			return 0 -- pointless
		end
		
		if actorCountry:IsGovernmentInExile() then
			return 0 -- pointless
		end
		
		local strategy = actor:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(recipient) / 2
		score = score + strategy:GetProtectionism(recipient)
		score = score - strategy:GetAntagonism(recipient) / 2
		score = score - actor:GetCountry():GetDiplomaticDistance(recipient):GetTruncated() 
		
	end

	score = Utils.CallScoredCountryAI(actor, 'DiploScore_Guarantee', score, ai, actor, recipient, observer)
	return score
end


function DiploScore_Embargo(ai, actor, recipient, observer)
	if observer == actor then
		local score = 0
		local actorCountry = actor:GetCountry() 
		local recipientCountry = recipient:GetCountry() 

		if actorCountry:IsAtWar() then
			for enemy in actorCountry:GetCurrentAtWarWith() do
				if recipient:GetCountry():IsFriend(enemy, true) then
					--Utils.LUA_DEBUGOUT( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. 100 )
					return 80 -- fighting our friends
				end
			end
		end
		--Utils.LUA_DEBUGOUT( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. score )
		-- dont use up the last of our points for this
		if actorCountry:GetDiplomaticInfluence():Get() < (defines.diplomacy.EMBARGO_INFLUENCE_COST + 2) then
			score = score / 2 - 1
		end
		--Utils.LUA_DEBUGOUT( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. score )
		return Utils.CallScoredCountryAI(actor, 'DiploScore_Embargo', score, ai, actor, recipient, observer)
	else
		return 0 -- cant respond to this action
	end
end


function DiploScore_NonAgression(ai, actor, recipient, observer)
	if observer == actor then -- we demand nap with recipient
		return DiploScore_NonAgression(ai, recipient, actor, observer)
	else -- actor demands nap with us
		local score = 0
		local rel = ai:GetRelation(recipient, actor)
		local relation = 100 + rel:GetValue():GetTruncated()
		
		if relation > 150 then -- we like them
			score = score + (relation - 150)
		elseif ai:GetNumberOfOwnedProvinces(actor) / 2 >
		       ai:GetNumberOfOwnedProvinces(recipient) then -- much bigger than us
			score = score + 5 + relation / 5
		end
		
		local recipientCountry = recipient:GetCountry()
		local strategy = recipientCountry:GetStrategy()
		score = score + strategy:GetFriendliness(actor) / 4
		score = score - strategy:GetAntagonism(actor) / 4
		--score = score + strategy:GetThreat(actor) / 4
		
		if not recipientCountry:IsNeighbour( actor ) then
			score = score / 2
		end

		score = score - recipientCountry:GetDiplomaticDistance(actor):GetTruncated() 
		--if score > 0 then
			--Utils.LUA_DEBUGOUT("NAP score: " .. score .. " for " .. tostring(actor) .. " - " .. tostring(recipient) )
			--Utils.LUA_DEBUGOUT("friendlyness: " .. strategy:GetFriendliness(actor) ) 
			--Utils.LUA_DEBUGOUT("antagonism: " .. strategy:GetAntagonism(actor) ) 
			--Utils.LUA_DEBUGOUT("threat: " .. strategy:GetThreat(actor) ) 
			--Utils.LUA_DEBUGOUT("d. dist: " ..  recipientCountry:GetDiplomaticDistance(actor):GetTruncated() ) 
			--Utils.LUA_DEBUGOUT("------------------------")
		--end

		return Utils.CallScoredCountryAI(recipient, 'DiploScore_NonAgression', score, ai, actor, recipient, observer)
	end
end

function DiploScore_DemandMilitaryAccess(ai, actor, recipient, observer)
	if observer == actor then -- we demand access of recipient
		local actorCountry = actor:GetCountry()
		local strategy = actorCountry:GetStrategy()
		local score = strategy:GetAccessScore(recipient)

		return score
	else -- actor demands access from us
		--Utils.LUA_DEBUGOUT("DiploScore_DemandMilitaryAccess_________________")
		local score = 0
		local rel = ai:GetRelation(recipient, actor)
		if rel:HasWar() then
			return 0
		end
		
		local relation = 200 + rel:GetValue():GetTruncated()
		--Utils.LUA_DEBUGOUT("relation: " .. relation)
		if relation > 150 then -- we like them
			score = score + (relation - 150)
		elseif ai:GetNumberOfOwnedProvinces(actor) / 2 >
		        ai:GetNumberOfOwnedProvinces(recipient) then -- much bigger than us
			score = score + 5 + relation / 5
		end

		--Utils.LUA_DEBUGOUT("score: " .. score)
		local strategy = recipient:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(actor) / 2
		score = score - rel:GetThreat():Get() / 2
		score = score - strategy:GetAntagonism(actor) / 2
		--Utils.LUA_DEBUGOUT("score+strat: " .. score)
		if rel:HasAlliance() then
			score = 80
		end
		--Utils.LUA_DEBUGOUT("score: " .. score)
		--Utils.LUA_DEBUGOUT("_________________")
		return Utils.CallScoredCountryAI(recipient, 'DiploScore_DemandMilitaryAccess', score,ai, actor, recipient, observer)
	end
end

function DiploScore_OfferMilitaryAccess(ai, actor, recipient, observer, action)
	local score = 0
	if observer == actor then --should we offer access to recipient
		local rel = ai:GetRelation(actor, recipient)
		if rel:HasWar() then
			return 0
		end

		local recipientCountry = recipient:GetCountry()
		if recipientCountry:IsNeighbour( actor ) then -- only for neighbors
			local strategy = actor:GetCountry():GetStrategy()
			score = (200 + rel:GetValue():GetTruncated()) / 4
			score = score + strategy:GetFriendliness(recipient) / 4
			score = score - strategy:GetAntagonism(recipient) / 4
			score = score - rel:GetThreat():Get() / 2

			if not recipientCountry:IsAtWar() then
				score = score / 4 -- why would we if they dont need it
			end
		end
 	end

	score = Utils.CallScoredCountryAI(recipient, 'DiploScore_OfferMilitaryAccess', score, ai, actor, recipient, observer, action)
	return score
end

function DiploScore_Alliance(ai, actor, recipient, observer, action)
	if observer == actor then 
       	local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()
		local strategy = actorCountry:GetStrategy()
		
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--Utils.LUA_DEBUGOUT("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end
		
		if recipientCountry:IsFactionLeader() then -- as a faction leader we dont want alliances, we want faction members
			return 0
		end
		
		return strategy:GetFriendliness(recipient)
	else 
		local rel = ai:GetRelation(recipient, actor)
		local relation = 200 + rel:GetValue():GetTruncated()
		
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--Utils.LUA_DEBUGOUT("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end
		
		if relation < 100 then
			return 0
		end
		
		local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()
		
		local score = relation / 12.0
		
				
		if actorCountry:IsFactionLeader() then -- as a faction leader we dont want alliances, we want faction members
			return 0
		end
		
		-- check location
		if not recipientCountry:IsNeighbour(actor) then
			-- check if on same continent first
			local recipientContinent = recipientCountry:GetActingCapitalLocation():GetContinent()
			local actorContinent = actorCountry:GetActingCapitalLocation():GetContinent()
			if not (recipientContinent == actorContinent) then
				score = score / 2
			end
		end
		
		-- check their wars
		if actorCountry:IsAtWar() then
			local bMutualEnemies = false
			for enemy in actorCountry:GetCurrentAtWarWith() do
				if recipientCountry:IsEnemy(enemy) then -- use threat as well?
					bMutualEnemies = true
				elseif recipientCountry:IsFriend(enemy, false) then
					return 0 -- fighting our friends
				end
			end
			
			if bMutualEnemies then
				score = score + 20
			else
				score = score / 2 -- better wait until they sorted their problems
			end
		end

		score = score - recipientCountry:GetDiplomaticDistance(actor):GetTruncated() / 10

		local strategy = recipientCountry:GetStrategy()
		score = score + strategy:GetFriendliness(actor) / 2
		score = score - strategy:GetAntagonism(actor) / 2
		score = score - rel:GetThreat():Get() / 2
	

		return Utils.CallScoredCountryAI(recipient, 'DiploScore_Alliance', score, ai, actor, recipient, observer, action)
	end
end


function CalculateWarDesirability(ai, country, target)
	local score = 0
	local countryTag = country:GetCountryTag()
	local targetCountry = target:GetCountry()
	local strategy = country:GetStrategy()

	-- can we even declare war?
	if not ai:CanDeclareWar( countryTag, target ) then
	  return 0
	end

	--Utils.LUA_DEBUGOUT("we can declare war: " .. tostring(minister:GetCountryTag()) .. " -> " .. tostring(target) )


	local antagonism = strategy:GetAntagonism(target);
	local friendliness = strategy:GetFriendliness(target);

	-- dont declare war on people we like
	if friendliness > 0 and antagonism < 1 then
		return 0
	end

	-- no suicide :S
	if country:GetNumberOfControlledProvinces() < targetCountry:GetNumberOfControlledProvinces() / 4 then
		return 0
	end

	-- watch out if we have bad intel, should be infiltrating more
	local intel = CAIIntel(countryTag, target)
	if intel:GetFactor() < 0.1 then
		return 0
	end

	-- compare military power
	local theirStrength = intel:CalculateTheirPercievedMilitaryStrengh()
	local ourStrength = intel:CalculateOurMilitaryStrength()
	local strengthFactor = ourStrength / theirStrength

	if strengthFactor < 1.0 then
		score = score - 75 * (1.0 - strengthFactor)
	else
		score = score + 20 * (strengthFactor - 1.0)
	end

	-- personality
	if strategy:IsMilitarist() then
		score = score * 1.3
	end
	
	return Utils.CallScoredCountryAI(countryTag, 'CalculateWarDesirability', score, ai, country, target)

end

function DiploScore_PeaceAction(ai, actor, recipient, observer, action)
	if observer == actor then
		return 0
	else
		score = 0
		
		-- intel first
		--Utils.LUA_DEBUGOUT("----------")
		local intel = CAIIntel(recipient, actor)
		if intel:GetFactor() > 0.1 then
			local recipientStrength = intel:CalculateTheirPercievedMilitaryStrengh()
			local actorStrength = intel:CalculateOurMilitaryStrength()
			local strengthFactor = actorStrength / recipientStrength - 0.5
			score = 100 * strengthFactor
		end
		--Utils.LUA_DEBUGOUT("score: " .. score )
		
		local sizeFactor = actor:GetCountry():GetNumberOfControlledProvinces() / recipient:GetCountry():GetNumberOfControlledProvinces()
		--Utils.LUA_DEBUGOUT("sizeFactor: " .. sizeFactor )
		sizeFactor = (sizeFactor - 1) * 100
				
		score = score + math.min(sizeFactor, 100)
		
		score = score + recipient:GetCountry():GetSurrenderLevel():Get() * 100
		--Utils.LUA_DEBUGOUT("score: " .. score )
		score = score - actor:GetCountry():GetSurrenderLevel():Get() * 100
		--Utils.LUA_DEBUGOUT("score: " .. score )
		
		local strategy = recipient:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(actor) / 2
		score = score - strategy:GetAntagonism(actor) / 2
		--score = score + strategy:GetThreat(actor) / 2
		--Utils.LUA_DEBUGOUT("score: " .. score )
		return score
	end
end

function DiploScore_SendExpeditionaryForce(ai, actor, recipient, observer, action)
	if observer == actor then
		return 0 
	else
		-- do we want to accept?
		local recipientCountry = recipient:GetCountry()
		if recipientCountry:GetDailyBalance( CGoodsPool._SUPPLIES_ ):Get() > 1.0 then
			local  score = 0
			-- maybe we have enough stockpiles
			local supplyStockpile = recipientCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get()
			local weeksSupplyUse = recipientCountry:GetDailyExpense( CGoodsPool._SUPPLIES_ ):Get() * 7
			if supplyStockpile > weeksSupplyUse * 20.0 then
				score = score + 70
			elseif supplyStockpile > weeksSupplyUse * 10.0 then
				score = score + 40
			end
			
			if recipientCountry:IsAtWar() then
				score = score + 20
			else
				score = 0 -- no war, no need for troops
			end
			
			return score
		else
			local score = 0
			-- maybe we have enough stockpiles
			local supplyStockpile = recipientCountry:GetPool():Get( CGoodsPool._SUPPLIES_ ):Get()
			local weeksSupplyUse = recipientCountry:GetDailyExpense( CGoodsPool._SUPPLIES_ ):Get() * 7
			if supplyStockpile > weeksSupplyUse * 24.0 then
				score = score + 70
			elseif supplyStockpile > weeksSupplyUse * 12.0 then
				score = score + 40
			end

			if recipientCountry:IsAtWar() then
				score = score + 20
			else
				score = 0 -- no war, no need for troops
			end
			
		end
		return 0
	end
end

function DiploScore_LicenceTechnology(ai, LicenceBuyer, LicenceGiver, observer, action)
	if observer == LicenceBuyer then
		return 0 
	else
		--Utils.LUA_DEBUGOUT("-> LicenceTechnology " .. tostring(LicenceBuyer) .. " buying from " ..  tostring(LicenceGiver))
		if not action:GetSubunit() then
			--Utils.LUA_DEBUGOUT("LICENS -> not action:GetSubunit()")
			return 0
		end
	
		local score = 0
		local LicenceBuyerCountry = LicenceBuyer:GetCountry()
		local LicenceGiverCountry = LicenceGiver:GetCountry()
		local rel = ai:GetRelation(LicenceGiver, LicenceBuyer)
		
		if rel:HasWar() then			
			--Utils.LUA_DEBUGOUT("LICENS -> rel:HasWar() "..tostring(rel:HasWar()))
			return 0
		end
		--Utils.LUA_DEBUGOUT("1 LICENS " .. tostring(LicenceBuyer) .. " -> " ..  tostring(LicenceGiver) .. " = " .. score)
		-- we can give tech to
		-- - people in faction
		-- - people in alliance
		-- - people fighting our enemies
		-- - people close in triangle (not far away! scale price here too)
		if ( LicenceGiverCountry:HasFaction() and LicenceGiverCountry:GetFaction() == LicenceBuyerCountry:GetFaction() ) then
			score = 70
		elseif rel:HasAlliance() then
			score = 60
		else
			if rel:GetValue():GetTruncated() < 0 then
				--Utils.LUA_DEBUGOUT("LICENS -> rel:GetValue():GetTruncated() < 0 "..tostring(rel:GetValue():GetTruncated()))
				return 0
			end
			-- relationship - threat
			score = rel:GetValue():GetTruncated()/5 - rel:GetThreat():Get() * CalculateAlignmentFactor(ai, LicenceBuyerCountry, LicenceGiverCountry)
		end
		
		--Utils.LUA_DEBUGOUT("2 LICENS " .. tostring(LicenceBuyer) .. " -> " ..  tostring(LicenceGiver) .. " = " .. score)
		local MutualEnemy = false
		if LicenceBuyerCountry:IsAtWar() then
			for EnemyOfBuyer in LicenceBuyerCountry:GetCurrentAtWarWith() do
				if LicenceGiverCountry:IsEnemy(EnemyOfBuyer) then
					--Utils.LUA_DEBUGOUT("mutual enemy: " .. tostring(EnemyOfBuyer) .. " for " ..  tostring(LicenceBuyer) .. " and " .. tostring(LicenceGiver))
					MutualEnemy = true
					--Utils.LUA_DEBUGOUT("mutual EnemyOfBuyer")
				elseif LicenceGiverCountry:IsFriend(EnemyOfBuyer, true)
				and ai:GetRelation(EnemyOfBuyer, LicenceBuyer):GetValue():GetTruncated() > 20
				then
					-- Giver is friend of EnemyOfBuyer
					return 0
				end
			end
		end
		
		--Utils.LUA_DEBUGOUT("3 LICENS " .. tostring(LicenceBuyer) .. " -> " ..  tostring(LicenceGiver) .. " = " .. score)
		if MutualEnemy then
			score = score + 30
			--Utils.LUA_DEBUGOUT("MutualEnemy")
		else
			--Utils.LUA_DEBUGOUT("CalculateAlignmentFactor: " .. CalculateAlignmentFactor(ai, LicenceBuyerCountry, LicenceGiverCountry) * 50)
			score = score - CalculateAlignmentFactor(ai, LicenceBuyerCountry, LicenceGiverCountry) * 50			
		end
		-- consider the money
		local boost = 1
		if IsPoor(LicenceGiverCountry) then
			boost = 2
		end		
		score = score*math.min(2, (boost*action:GetMoney():Get())/(LicenceGiverCountry:GetTotalIC()+LicenceBuyerCountry:GetTotalIC()))
	
		--Utils.LUA_DEBUGOUT("<- LicenceTechnology " .. tostring(LicenceBuyer) .. " buying from " ..  tostring(LicenceGiver) .. " = " .. score)
		return math.min(100, score)
	end
end

function DiploScore_Debt(ai, actor, recipient, observer)
	if observer == actor then
		actorCountry = actor:GetCountry()
		recipientCountry = recipient:GetCountry()
		if recipientCountry:IsAtWar() 
		and ( recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction() )
		then
			if actorCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get() < 10 
			and actorCountry:GetDailyBalance(CGoodsPool._MONEY_):Get() < 0
			then 
				return 100
			else
				return 0
			end
		else
			return 0
		end
	else
		actorCountry = actor:GetCountry()
		recipientCountry = recipient:GetCountry()
		if recipientCountry:IsAtWar() 
		and ( recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction() )
		then
			local recipientMoney = recipientCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()
			local actorMoney = actorCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()
			if (recipientMoney * 5 > actorMoney) 
			and (recipientMoney > 200) then 
				return 100
			else
				return 0
			end
		else
			return 0
		end
	end
end

function CustomFactionJoinRules( score, ai, actor, recipient, observer)
	if tostring(actor) == 'GER' then
		--Utils.LUA_DEBUGOUT("Yep getting in the GER custom script")	
		if tostring(recipient) == 'AUS' then -- we got better plans for you...
			return 0
		end
	
		local year = ai:GetCurrentDate():GetYear()
		local month = ai:GetCurrentDate():GetMonthOfYear()

		if tostring(recipient) == 'ITA' then
			if year >= 1939 and CCurrentGameState.GetProvince( 1928 ):GetController() == actor then
				return 100
			else
				return 0
			end
		elseif tostring(recipient) == 'JAP' then
			if year >= 1939 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				return 100
			else
				return 0
			end
		elseif tostring(recipient) == 'HUN' or tostring(recipient) == 'ROM' or tostring(recipient) == 'BUL' or tostring(recipient) == 'SPA' then
			if year >= 1940 and CCurrentGameState.GetProvince( 2613 ):GetController() == actor then
				return 100
			else
				return 0
			end
		else
			--Utils.LUA_DEBUGOUT("WE DO NOT SEE THOSE OPTIONS!")	
			return score
		end		
	end

	--Utils.LUA_DEBUGOUT("Gets after the if!")
	return score
end


function DiploScore_CallAlly(ai, actor, recipient, observer, action)
	if observer == actor then
		return 100
	else
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()
		
		if actorCountry:GetFaction() == recipientCountry:GetFaction() then
			return 100
		elseif recipientCountry:GetOverlord() == actor then
			return 100
		else
			local score = DiploScore_Alliance(ai, actor, recipient, observer, nil)
			if score < 50 then
				return 40
			else
				return 100
			end
		end
	end
end
