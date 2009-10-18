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

-- Returns score between -1 and 1.
-- -1 means they hate each other.
-- 0 means they are neutral.
-- 1 means they like each other.
function CalculateSympathy(countryTagA, countryTagB)
	local countryA = countryTagA:GetCountry()
	local countryB = countryTagB:GetCountry()

	local diplomacyStatus = countryA:GetRelation(countryTagB)
	local strategy = countryA:GetStrategy()

	local relation = diplomacyStatus:GetValue():Get() / 400
	local threat = diplomacyStatus:GetThreat():Get() / 200
	local antagonism = strategy:GetAntagonism(countryTagB) / 400
	local friendliness = strategy:GetFriendliness(countryTagB) / 400

	local strategicFactor = math.abs(friendliness - antagonism)
	return friendliness - antagonism + (1 - strategicFactor) * (relation - threat)
end

function CalculateFactionSympathy(ai, country, faction)
	local countryTag = country:GetCountryTag()
	local leader = faction:GetFactionLeader()
	local dist = ai:GetNormalizedAlignmentDistance(country, faction):Get() -- 0 to 4000

	local sympathyMembers = 0
	for member in faction:GetMembers() do
		if country:IsEnemy(member) then
			return 0
		end

		if member ~= leader then
			sympathyMembers = sympathyMembers + CalculateSympathy(countryTag, member)
		end
	end

	local closeness = math.max((500 - dist) / 500, 0) -- closeness
	local progress = faction:GetNormalizedProgress():Get()
	local sympathy = CalculateSympathy(countryTag, leader)

	if faction:GetNumberOfMembers() > 1 then
		sympathyMembers = sympathyMembers / (faction:GetNumberOfMembers() - 1)
	end

	return 0.5 * closeness + 0.5 * (0.25 * progress + 0.5 * sympathy + 0.25 * sympathyMembers)
end

function DiploScore_InfluenceNation(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT( " DiploScore_InfluenceNation Mod ")
	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		local actorFaction = actorCountry:GetFaction()
		local leader = actorFaction:GetFactionLeader()
		local leaderCountry = leader:GetCountry()

		local dist = ai:GetNormalizedAlignmentDistance(recipientCountry, actorFaction):Get()
		local invitationScore = DiploScore_InviteToFaction(ai, actor, recipient, observer)
		local maxIC = recipientCountry:GetMaxIC()

		-- Close to joining our faction and we want them in our faction
		if dist > 40 and dist < 1540 and invitationScore > 50 then
			local score = (1540 - dist) / 15 -- score between 0 and 100%

			local importanceFactor = maxIC / leaderCountry:GetMaxIC()

			-- factor neutrality
			local effectiveNeutrality = recipientCountry:GetNeutrality():Get() - recipientCountry:GetRelation(recipientCountry:GetHighestThreat()):GetThreat():Get()
			effectiveNeutrality = effectiveNeutrality / 100
			importanceFactor = importanceFactor + (1 - effectiveNeutrality)

			-- is neighbour
			if recipientCountry:IsNeighbour(actor) then
				importanceFactor = importanceFactor + 0.1
			end

			-- Our relations to them
			importanceFactor = importanceFactor + CalculateSympathy(actor, recipient) * 0.2

			score = score * (1 + importanceFactor)

			--Utils.LUA_DEBUGOUT("Importance factor = " .. tostring(factor ) )
			return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
		elseif ai_configuration.COUNTER_INFLUENCE == 1 and maxIC > ai_configuration.MINIMUM_IC_TO_INFLUENCE then
			-- close to other faction?
			for faction in CCurrentGameState.GetFactions() do
				if faction:IsValid() and not (faction == actorFaction) then
					dist = ai:GetNormalizedAlignmentDistance(recipientCountry, faction):Get()
					--Utils.LUA_DEBUGOUT("Align dist: " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. dist )
					if dist > 1 and dist < 301 then
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


						if driftDiff > 0 and driftDiff < 5 then
							affectable = true
						end

						local theirRelationToUs = recipientCountry:GetRelation(actor)

						if affectable or theirRelationToUs:IsBeingInfluenced() then --affectable or influenced by us then
							local score = (300 - (dist - 1)) / 3

							leader = faction:GetFactionLeader()
							leaderCountry = leader:GetCountry()

							local importanceFactor = maxIC / leaderCountry:GetMaxIC()

							-- factor neutrality
							local effectiveNeutrality = recipientCountry:GetNeutrality():Get() - recipientCountry:GetRelation(recipientCountry:GetHighestThreat()):GetThreat():Get()
							effectiveNeutrality = effectiveNeutrality / 100
							importanceFactor = importanceFactor + (1 - effectiveNeutrality)

							-- is neighbour
							if recipientCountry:IsNeighbour(actor) then
								importanceFactor = importanceFactor + 0.1
							end

							score = score * (1 + importanceFactor)

							return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
						end
					end
				end
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
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	if observer == actor then -- are recipient worth inviting
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
		end

		local score = CalculateSympathy(actor, recipient)

		local actorFaction = actorCountry:GetFaction()

		-- Does faction leader approve of this?
		if not actorCountry:IsFactionLeader() then
			local leader = actorFaction:GetFactionLeader()

			score = 0.2 * score + 0.8 * CalculateSympathy(leader, recipient)
		end

		score = score * 100

		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			return Utils.CallScoredCustomAI('CustomFactionInviteRules', score, ai, actor, recipient, observer)
		end

		return score
	else -- do we, recipient want to accept invite to faction
		--Utils.LUA_DEBUGOUT("-------------------------------------")
		--Utils.LUA_DEBUGOUT("DiploScore_InviteToFaction (" .. tostring( actor )  .. "->" .. tostring( recipient ) .. ")")
		local faction = actorCountry:GetFaction()

		--if recipient:GetCountry():IsNeighbourToFactionHostile(faction) then
		--	return 0
		--end

		local score = CalculateFactionSympathy(ai, recipientCountry, faction) * 100

		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			return Utils.CallScoredCustomAI('CustomFactionAcceptRules', score, ai, actor, recipient, observer)
		else
			return Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
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
	if observer == actor then -- We (actor) invite recipient
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--Utils.LUA_DEBUGOUT("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end

       	local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()

		 -- As a faction leader we dont want alliances, we want faction members
		if recipientCountry:IsFactionLeader() then
			return 0
		end

		-- If we are in a faction don't make alliances
		if recipientCountry:HasFaction() then
			return 0
		end

		return CalculateSympathy(actor, recipient) * 100
	else -- We (recipient) are invited by actor
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--Utils.LUA_DEBUGOUT("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end

		local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()

		 -- As a faction leader we dont want alliances, we want faction members
		if actorCountry:IsFactionLeader() then
			return 0
		end

		-- If we are in a faction don't make alliances
		if actorCountry:HasFaction() then
			return 0
		end

		local score = CalculateSympathy(recipient, actor) * 100

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
				score = score * 1.2
			else
				score = score / 2 -- better wait until they sorted their problems
			end
		end

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
