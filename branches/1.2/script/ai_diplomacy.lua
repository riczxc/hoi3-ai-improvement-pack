-----------------------------------------------------------
-- Diplomatic action evaluation
--
-----------------------------------------------------------

require('utils')
require('helper_functions')
require('ai_trade')

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

	-- Make sure antagonism is high if we're preparing a war against them
	if diplomacyStatus:HasWar() or strategy:IsPreparingWarWith(countryTagB) then
		antagonism = 1
		friendliness = 0
	end

	-- If we've terretorial claims on them make sure we don't like them
	-- very much.
	if HasClaims(countryTagA, countryTagB) then
		antagonism = 0.6
		friendliness = 0
	end

	--if tostring(countryTagA) == 'GER' then
		--Utils.LUA_DEBUGOUT(tostring(countryTagA) .. " <-> " .. tostring(countryTagB))
		--Utils.LUA_DEBUGOUT("\trelation:" .. tostring(relation))
		--Utils.LUA_DEBUGOUT("\tthreat:" .. tostring(threat))
		--Utils.LUA_DEBUGOUT("\tantagonism:" .. tostring(antagonism))
		--Utils.LUA_DEBUGOUT("\tfriendliness:" .. tostring(friendliness))
	--end

	local strategicFactor = math.abs(friendliness - antagonism)
	return friendliness - antagonism + (1 - strategicFactor) * (relation - threat)
end

-- How important is B for A in economic terms.
-- 1 very important
-- 0 not important
function EconomicInfluenceScore(tagA, countryA, tagB, countryB)
	local leaderCountry = countryA:GetFaction():GetFactionLeader():GetCountry()
	local factorIC = math.min(countryB:GetMaxIC() / leaderCountry:GetMaxIC(), 1)

	-- If they don't have much IC see if we could use one of their resources.
	local negativeBalanceTotal = 0
	local balance = {}
	for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
		if goods ~= CGoodsPool._MONEY_ and goods ~= CGoodsPool._SUPPLIES_ then
			balance[goods] = GetAverageBalance(countryA, goods) - Importing(tagA, goods)
			if goods == CGoodsPool._CRUDE_OIL_ then
				balance[goods] = balance[goods] + GetAverageBalance(countryA, CGoodsPool._FUEL_)  - Importing(tagA, CGoodsPool._FUEL_)
			end

			if balance[goods] < 0 then
				negativeBalanceTotal = negativeBalanceTotal + math.floor(balance[goods])
			end
		end
	end

	local factorResources = 0
	if (math.abs(negativeBalanceTotal) / countryA:GetTotalIC()) > 0.1 then
		for goods = 0, CGoodsPool._GC_NUMOF_ - 1 do
			if goods ~= CGoodsPool._MONEY_ and goods ~= CGoodsPool._SUPPLIES_ then
				if balance[goods] < 0 then
					local balanceB = GetAverageBalance(countryB, goods) + Exporting(tagB, goods)
					-- A little cheating here...
					if balanceB > 0 and not ExistsImport(tagB, goods) then
						local resourceImportance = balance[goods] / negativeBalanceTotal
						factorResources = factorResources - math.max(balanceB / balance[goods], -1) * resourceImportance
					end
				end
			end
		end
	end

	return factorIC + (1 - factorIC) * math.min(factorResources, 1)
end

function StrategicInfluenceScore(tagA, countryA, tagB, countryB)
	local strategy = countryA:GetStrategy()

	if countryA:IsEnemy(tagB) or strategy:IsPreparingWarWith(tagB) then
		return -1
	end

	if countryA:GetFaction() == CCurrentGameState.GetFaction('axis') then
		-- Axis members want to conquer
		if (countryB:GetMaxIC() < 10) then
			return -1
		end
	end

	local score = 0

	-- A only neighbour to B if on same continent
	local isANeighbourToB = IsNeighbourOnSameContinent(tagA, countryA, tagB, countryB)

	for neighbour in countryB:GetNeighbours() do
		-- Neighbour of one of our potential enemies
		local neighbourCountry = neighbour:GetCountry()
		if neighbour ~= tagA and IsNeighbourOnSameContinent(neighbour, neighbourCountry, tagB, countryB) then
			local importanceFactor = 0

			if countryA:IsEnemy(neighbour) or strategy:IsPreparingWarWith(neighbour) then
				-- Neighbour is an enemy of us
				importanceFactor = 1
			elseif neighbourCountry:HasFaction() then
				local neighbourFaction = neighbourCountry:GetFaction()
				if neighbourFaction:IsValid() and neighbourFaction ~= countryA:GetFaction() then
					local factionLeader = neighbourFaction:GetFactionLeader()
					local leaderCountry = factionLeader:GetCountry()

					-- Base score on how important that neighbour is to the faction
					importanceFactor = neighbourCountry:GetMaxIC() / leaderCountry:GetMaxIC()
				end
			end

			if not isANeighbourToB and IsNeighbourOnSameContinent(neighbour, neighbourCountry, tagA, countryA) then
				-- B is not a neighbour of A, but neighbour of B is also neighbour of A
				-- Would open up a new front
				importanceFactor = importanceFactor * 1.5
			end

			-- Base score on damage B could inflict on potential enemy
			local damage = math.min(countryB:GetMaxIC() / neighbourCountry:GetMaxIC(), 1)
			score = math.max(importanceFactor * damage, score)
		end
	end

	-- Are we neighbours and don't have claims?
	if isANeighbourToB and not HasClaims(tagA, tagB) then
		score = score + 0.5
	end

	return math.min(score, 1)
end

function IsNeighbourOnSameContinent(tagA, countryA, tagB, countryB)
	local continentA = countryA:GetCapitalLocation():GetContinent()
	local continentB = countryB:GetCapitalLocation():GetContinent()
	return countryA:IsNeighbour(tagB) and (continentA == continentB)
end

-- How threatening is B to A. Includes alignment and IC in calculation.
-- Return value between 0 and 200
function CalculateThreat(ai, tagA, countryA, tagB, countryB)
	local threat = countryA:GetRelation(tagB):GetThreat():Get()
	threat = threat * CalculateAlignmentFactor(ai, countryA, countryB)
	threat = threat * math.min(math.max(countryB:GetTotalIC() / countryA:GetTotalIC(), 0.5), 1.5)
	return threat
end

function GetHighestCalculatedThreat(ai, tag, country)
	local threateningCountryTag = country:GetHighestThreat()
	local highestThreat = CalculateThreat(ai, tag, country, threateningCountryTag, threateningCountryTag:GetCountry())
	for neighbour in country:GetNeighbours() do
		local neighboursThreat = CalculateThreat(ai, tag, country, neighbour, neighbour:GetCountry())

		if neighboursThreat > highestThreat then
			highestThreat = neighboursThreat
			threateningCountryTag = neighbour
		end
	end
	return highestThreat, threateningCountryTag
end

-- Workaround function. As of 1.2 there's no way to check if a country
-- has territorial claims on another.
-- Returns true if A has claims on B.
function HasClaims(tagA, tagB)
	local a = tostring(tagA)
	local b = tostring(tagB)

	if a == 'BUL' then
		return b == 'ROM' or b == 'GRE' or b == 'YUG'
	elseif a == 'CZE' then
		return b == 'GER'
	elseif a == 'FIN' then
		return b == 'SOV'
	elseif a == 'GER' then
		return b == 'LIT' or b == 'POL'
	elseif a == 'HUN' then
		return b == 'CZE' or b == 'ROM' or b == 'YUG'
	elseif a == 'ITA' then
		return b == 'YUG'
	elseif a == 'JAP' then
		return b == 'MAN'
	elseif a == 'PAN' then
		return b == 'USA'
	elseif a == 'POL' then
		return b == 'SOV'
	elseif a == 'YEM' then
		return b == 'ENG'
	end

	return false
end

function DiplomaticInfluenceScore(tagA, countryA, tagB, countryB)
	local score = CalculateSympathy(tagA, tagB)

	local ideologyGroupA = countryA:GetFaction():GetIdeologyGroup()
	local ideologyGroupB = countryB:GetRulingIdeology():GetGroup()

	if ideologyGroupA == ideologyGroupB then
		score = math.min(score + 0.5, 1)
	else
		score = math.max(score - 0.5, -1)
	end

	return score
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

	local closeness = math.max((1000 - dist) / 1000, 0) -- closeness
	local progress = faction:GetNormalizedProgress():Get()
	local sympathy = CalculateSympathy(countryTag, leader)

	if faction:GetNumberOfMembers() > 1 then
		sympathyMembers = sympathyMembers / (faction:GetNumberOfMembers() - 1)
	end

	return closeness + (1 - closeness) * (0.25 * progress + 0.5 * sympathy + 0.25 * sympathyMembers)
end

function DiploScore_InfluenceNation(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT(tostring(actor) .. " DiploScore_InfluenceNation " .. tostring(recipient))
	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		local actorFaction = actorCountry:GetFaction()
		local leader = actorFaction:GetFactionLeader()
		local leaderCountry = leader:GetCountry()

		local al = recipient:GetCountry():GetAlignment()
		local towardsActorDrift = al:GetLastDrift(actorFaction:GetIdeologyGroup()):Get()
		local influencedByActor = recipientCountry:GetRelation(actor):IsBeingInfluenced()
		local influencedByActorFaction = towardsActorDrift > 5

		local dist = ai:GetNormalizedAlignmentDistance(recipientCountry, actorFaction):Get()
		local highestThreat, threateningCountryTag = GetHighestCalculatedThreat(ai, recipient, recipientCountry)
		local effectiveNeutrality = math.max(recipientCountry:GetNeutrality():Get() - highestThreat, 0)
		local neutrality = 1 - effectiveNeutrality / 100

		local score = 0

		--if tostring(actor) == 'GER' then
			--Utils.LUA_DEBUGOUT(tostring(recipient) .. " DIST: " .. tostring(dist) .. " NEUT: " .. tostring(neutrality))
		--end

		-- Not in our corner and neutrality low enough and not influenced by faction member
		if (dist > 10) and (influencedByActor or (neutrality > 0.125 and not influencedByActorFaction)) then
			--Utils.LUA_DEBUGOUT("----------------------------------------------------------")
			--Utils.LUA_DEBUGOUT(tostring(actor) .. " influencing " .. tostring(recipient))

			local strategic = StrategicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			--Utils.LUA_DEBUGOUT("\t" .. "strategic:" .. tostring(strategic))

			local diplomatic = DiplomaticInfluenceScore(actor, actorCountry, recipient, recipientCountry) * 0.3
			-- Get faction leader's opinion in diplomatic matters
			diplomatic = diplomatic + DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry) * 0.7
			--Utils.LUA_DEBUGOUT("\t" .. "diplomatic:" .. tostring(diplomatic))

			local economic = EconomicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			--Utils.LUA_DEBUGOUT("\t" .. "economic:" .. tostring(economic))

			local randomness = (math.mod(CCurrentGameState.GetAIRand(), 100) / 100) * 0.1 - 0.05 -- +/-5%

			score = 100 * neutrality * (strategic + diplomatic + economic + randomness)
			--Utils.LUA_DEBUGOUT("\t" .. "score:" .. tostring(score))
		end

		return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
	else
		return 100 -- we cant respond to this
	end
end
-- for debugging
local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }



function DiploScore_InviteToFaction(ai, actor, recipient, observer)
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	local actorFaction = actorCountry:GetFaction()
	local leader = actorFaction:GetFactionLeader()
	local leaderCountry = leader:GetCountry()

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

		-- Leader decides
		local strategic = StrategicInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		local diplomatic = DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		local economic = EconomicInfluenceScore(leader, leaderCountry, recipient, recipientCountry)

		local score = 100 * (strategic + diplomatic + economic)

		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			return Utils.CallScoredCustomAI('CustomFactionInviteRules', score, ai, actor, recipient, observer)
		else
			return Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
		end
	else -- do we, recipient want to accept invite to faction
		local score = CalculateFactionSympathy(ai, recipientCountry, actorFaction)

		--Utils.LUA_DEBUGOUT("----------------------------------------------------------")
		--Utils.LUA_DEBUGOUT("Probability of " .. tostring(recipient) .. " joining " .. tostring(leader))
		--Utils.LUA_DEBUGOUT("\t" .. "Base score:\t\t\t\t" .. tostring(score * 100))

		-- See if joining them would be helpful or suicide
		local recipientIC = recipientCountry:GetMaxIC()
		local enemyIC = 0
		local hostileIC = 0
		local friendlyIC = recipientIC
		for neighbour in recipientCountry:GetNeighbours() do
			local neighbourCountry = neighbour:GetCountry()
			if 	IsNeighbourOnSameContinent(recipient, recipientCountry, neighbour, neighbourCountry) then

				-- Only factor neighbours we're at peace with
				if not recipientCountry:IsEnemy(neighbour) then

					-- Neighbour is hostile to faction
					if neighbourCountry:IsEnemy(leader) then
						enemyIC = enemyIC + neighbourCountry:GetMaxIC()
						--Utils.LUA_DEBUGOUT(tostring(leader) .. " is enemy to " .. tostring(neighbour))

					-- Neighbour is in different faction and so maybe in future a threat
					elseif	neighbourCountry:GetFaction():IsValid() and
							neighbourCountry:GetFaction() ~= actorFaction
					then
						hostileIC = hostileIC + neighbourCountry:GetMaxIC()

					-- Neighbour is in same faction and could be of help
					elseif	neighbourCountry:GetFaction():IsValid() and
							neighbourCountry:GetFaction() == actorFaction
					then
						friendlyIC = friendlyIC + neighbourCountry:GetMaxIC()
					end
				end
			end
		end
		if enemyIC > 0 then
			score = score * math.min(recipientIC / enemyIC, 1)
			--Utils.LUA_DEBUGOUT("\t" .. "recipientIC / enemyIC:\t" .. tostring(math.min(recipientIC / enemyIC, 1)))
		elseif hostileIC > 0 then
			score = score * math.min(friendlyIC / hostileIC, 1)
			--Utils.LUA_DEBUGOUT("\t" .. "friendlyIC / hostileIC:\t" .. tostring(math.min(friendlyIC / hostileIC, 1)))
		end

		local highestThreat, threateningCountryTag = GetHighestCalculatedThreat(ai, recipient, recipientCountry)
		--Utils.LUA_DEBUGOUT("\t" .. "Highest threat:\t\t\t" .. tostring(highestThreat))
		--Utils.LUA_DEBUGOUT("\t" .. "caused by:\t\t\t\t" .. tostring(threateningCountryTag))
		local effectiveNeutrality = math.max(recipientCountry:GetNeutrality():Get() - highestThreat, 0)
		--Utils.LUA_DEBUGOUT("\t" .. "Neutrality:\t\t\t\t" .. tostring(recipientCountry:GetNeutrality():Get()))
		--Utils.LUA_DEBUGOUT("\t" .. "Effective neutrality:\t" .. tostring(effectiveNeutrality))
		score = 100 * score * (1 - effectiveNeutrality / 100)

		--Utils.LUA_DEBUGOUT("Final score: " .. tostring(score))

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

		if not IsNeighbourOnSameContinent(actor, actorCountry, recipient, recipientCountry) then
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

-- virtual neighbors for countries isolated by oceans
function IsOceanNeighbor(tagA, tagB)
	local a = tostring(tagA)
	local b = tostring(tagB)

	-- oceania
	if a == 'NZL' then
		return b == 'AST' or b == 'JAP' or b == 'PHI' or b == 'USA'
	elseif a == 'AST' then
		return b == 'NZL' or b == 'JAP' or b == 'PHI' or b == 'USA' or b == 'HOL'

	-- east asia
	elseif a == 'PHI' then
		return b == 'USA' or b == 'JAP' or b == 'CHI' or b == 'CGX' or b == 'INO' or b == 'HOL' or b == 'AST' or b == 'NZL'
	elseif a == 'CHI' then
		return b == 'JAP' or b == 'PHI'
	elseif a == 'CGX' then
		return b == 'PHI'
	elseif a == 'PRK' or a == 'KOR' then
		return b == 'JAP'

	-- north america and carribean
	elseif a == 'USA' then
		return b == 'PHI' or b == 'AST' or b == 'NZL' or b == 'JAP' or b == 'CUB' or b == 'DEN' or b == 'ICL' or b == 'ENG' or b == 'IRE' or b == 'POR'
	elseif a == 'CUB' then
		return b == 'USA' or b == 'MEX' or b == 'HAI'
	elseif a == 'MEX' then
		return b == 'CUB'
	elseif a == 'HAI' then
		return b == 'CUB'

	-- north atlantic
	elseif a == 'CAN' then
		return b == 'ENG' or b == 'FRA' or b == 'DEN' or b == 'ICL' or b == 'IRE'
	elseif a == 'ICL' then
		return b == 'USA' or b == 'IRE' or b == 'ENG' or b == 'CAN' or b == 'DEN'
	elseif a == 'POR' then
		return b == 'USA'

	-- UK and Ireland
	elseif a == 'ENG' then
		return b == 'USA' or b == 'CAN' or b == 'HOL' or b == 'BEL' or b == 'ICL' or b == 'NOR' or b == 'DEN'
	elseif a == 'IRE' then
		return b == 'FRA' or b == 'SPA' or b == 'SPR' or b == 'USA' or b == 'ICL' or b == 'CAN'
	elseif a == 'NOR' then
		return b == 'ENG' or b == 'DEN'
	elseif a == 'DEN' then
		return b == 'ENG' or b == 'NOR'
	elseif a == 'BEL' then
		return b == 'ENG'
	elseif a == 'SPA' then
		return b == 'IRE'
	elseif a == 'SPR' then
		return b == 'IRE'

	-- Holland is special
	elseif a == 'HOL' then
		return b == 'JAP' or b == 'AST' or b == 'NZL' or b == 'PHI' or b == 'ENG'
	end

	return false
end
