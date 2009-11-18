-----------------------------------------------------------
-- Diplomatic action evaluation
--
-----------------------------------------------------------

require('ai_trade')
require('helper_functions')
require('utils')
require('custom_triggers')

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

	if diplomacyStatus:HasWar() then
		return -1
	end

	local relation = diplomacyStatus:GetValue():Get() / 400
	local threat = diplomacyStatus:GetThreat():Get() / 200
	local antagonism = strategy:GetAntagonism(countryTagB) / 400
	local friendliness = strategy:GetFriendliness(countryTagB) / 400
	--local protectionism = strategy:GetProtectionism(countryTagB)

	--if tostring(countryTagA) == 'GER' then
		--Utils.LUA_DEBUGOUT(tostring(countryTagA) .. " <-> " .. tostring(countryTagB))
		--Utils.LUA_DEBUGOUT("\trelation:" .. tostring(relation))
		--Utils.LUA_DEBUGOUT("\tthreat:" .. tostring(threat))
		--Utils.LUA_DEBUGOUT("\tantagonism:" .. tostring(antagonism))
		--Utils.LUA_DEBUGOUT("\tfriendliness:" .. tostring(friendliness))
		--Utils.LUA_DEBUGOUT("\tprotectionism:" .. tostring(protectionism))
	--end

	local strategicFactor = math.abs(friendliness - antagonism)
	local score = friendliness - antagonism + (1 - strategicFactor) * (relation - threat)

	local ideologyGroupA = countryA:GetRulingIdeology():GetGroup()
	local ideologyGroupB = countryB:GetRulingIdeology():GetGroup()

	if ideologyGroupA == ideologyGroupB then
		score = math.min(score + 0.5, 1)
	else
		-- Axis hate comintern but not allied
		-- Allies and comintern hate everyone else
		local axisIdeologyGroup = CCurrentGameState.GetFaction('axis'):GetIdeologyGroup()

		if ideologyGroupA == axisIdeologyGroup then
			local comIdeologyGroup = CCurrentGameState.GetFaction('comintern'):GetIdeologyGroup()

			if ideologyGroupB == comIdeologyGroup then
				score = math.max(score - 0.5, -1)
			end
		else
			score = math.max(score - 0.5, -1)
		end
	end

	return score
end

function DiplomaticInfluenceScore(tagA, countryA, tagB, countryB)
	local score = CalculateSympathy(tagA, tagB)

	local faction = countryA:GetFaction()
	for member in faction:GetMembers() do
		if countryB:IsEnemy(member) then
			return -1
		end
	end

	return score
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
	if countryA:GetFaction() == CCurrentGameState.GetFaction('axis') then
		-- Axis members want to conquer
		if (countryB:GetMaxIC() < 15) then
			return -1
		end
	end

	local faction = countryA:GetFaction()
	for member in faction:GetMembers() do
		local memberCountry = member:GetCountry()
		if memberCountry:GetStrategy():IsPreparingWarWith(tagB) or HasClaims(member, tagB) then
			return -1
		end
	end

	local strategy = countryA:GetStrategy()

	local score = 0

	-- A only neighbour to B if on same continent
	--local isANeighbourToB = IsNeighbourOnSameContinent(tagA, countryA, tagB, countryB)
	local isANeighbourToB = countryA:IsNeighbour(tagB)

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

function StrategicJoinScore(tag, country, faction)
	local countryIC = country:GetMaxIC()
	local enemyIC = 0
	local hostileIC = 0
	local friendlyIC = countryIC
	local leader = faction:GetFactionLeader()

	for neighbour in country:GetNeighbours() do
		local neighbourCountry = neighbour:GetCountry()
		if IsNeighbourOnSameContinent(tag, country, neighbour, neighbourCountry) then

			-- Only factor neighbours we're at peace with
			if not country:IsEnemy(neighbour) then

				-- Neighbour is hostile to faction
				if neighbourCountry:IsEnemy(leader) then
					enemyIC = enemyIC + neighbourCountry:GetMaxIC()
					--Utils.LUA_DEBUGOUT(tostring(leader) .. " is enemy to " .. tostring(neighbour))

				-- Neighbour is in different faction and so maybe in future a threat
				elseif	neighbourCountry:GetFaction():IsValid() and
						neighbourCountry:GetFaction() ~= faction
				then
					hostileIC = hostileIC + neighbourCountry:GetMaxIC()

				-- Neighbour is in same faction and could be of help
				elseif	neighbourCountry:GetFaction():IsValid() and
						neighbourCountry:GetFaction() == faction
				then
					friendlyIC = friendlyIC + neighbourCountry:GetMaxIC()
				end
			end
		end
	end
	if enemyIC > 0 then
		return math.min(countryIC / enemyIC, 1)
	elseif hostileIC > 0 then
		return math.min(friendlyIC / hostileIC, 1)
	end

	return 1
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
	elseif a == 'CHI' then
		return b == 'CHC' or b == 'CGX' or b == 'CXB' or b == 'CYN' or b == 'CSX'
	elseif a == 'CHC' then
		return b == 'CHI' or b == 'CGX' or b == 'CXB' or b == 'CYN' or b == 'CSX'
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

function CalculateFactionSympathy(ai, country, faction)
	local countryTag = country:GetCountryTag()
	local leader = faction:GetFactionLeader()
	local dist = ai:GetNormalizedAlignmentDistance(country, faction):Get()

	for member in faction:GetMembers() do
		if country:IsEnemy(member) then
			return 0
		end
	end

	local closeness = math.max((10 - dist) / 10, 0) -- closeness
	local progress = faction:GetNormalizedProgress():Get()
	local sympathy = CalculateSympathy(countryTag, leader)

	--Utils.LUA_DEBUGOUT("---------------CalculateFactionSympathy---------------")
	--Utils.LUA_DEBUGOUT("dist: " .. tostring(dist))
	--Utils.LUA_DEBUGOUT("closeness: " .. tostring(closeness))
	--Utils.LUA_DEBUGOUT("progress: " .. tostring(progress))
	--Utils.LUA_DEBUGOUT("sympathy: " .. tostring(sympathy))

	if closeness == 0 then
		return 0
	end

	return closeness + (1 - closeness) * (0.25 * progress + 0.75 * sympathy)
end

function DiploScore_InfluenceNation(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_InfluenceNation " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		local actorFaction = actorCountry:GetFaction()
		local leader = actorFaction:GetFactionLeader()
		local leaderCountry = leader:GetCountry()

		local neutrality = recipientCountry:GetNeutrality():Get()
		-- Don't influence neutral countries
		if neutrality >= 90 then
			--Utils.LUA_DEBUGOUT("<-DiploScore_InfluenceNation")
			return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', 0, ai, actor, recipient, observer)
		end

		local effectiveNeutrality = recipientCountry:GetEffectiveNeutrality():Get() / 100
		local dist = ai:GetNormalizedAlignmentDistance(recipientCountry, actorFaction):Get()

		local score = 0

		--if tostring(actor) == 'GER' then
			--Utils.LUA_DEBUGOUT(tostring(recipient) .. " DIST: " .. tostring(dist) .. " NEUT: " .. tostring(effectiveNeutrality))
		--end

		-- Only counter influence if we don't hate them. If we hate them we don't care what happens to them.
		local diplomatic = DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		if ai_configuration.COUNTER_INFLUENCE == 1 and dist > 12 and diplomatic > -0.25 then
			-- Base interest if and how long we're counter influencing on our protectionism to them.
			local strategy = leaderCountry:GetStrategy()
			local protectionism = strategy:GetProtectionism(recipient)
			local maxDist = math.min(3 + protectionism / 10, 10)

			for faction in CCurrentGameState.GetFactions() do
				if faction:IsValid() and faction ~= actorFaction then
					dist = ai:GetNormalizedAlignmentDistance(recipientCountry, faction):Get()

					if dist > 0.75 and dist < maxDist then
						--Utils.LUA_DEBUGOUT("----------------------------------------------------------")
						--Utils.LUA_DEBUGOUT(tostring(actor) .. " COUNTER influencing " .. tostring(recipient))

						local factionLeader = faction:GetFactionLeader()

						score = DiploScore_InfluenceNation(ai, factionLeader, recipient, factionLeader)

						if not IsNeighbourOnSameContinent(actor, actorCountry, recipient, recipientCountry) then
							score = score * 0.75 -- penalize a bit to boost personal faction members
						end

						if score > 50 then
							if recipientCountry:CalculateNumberOfActiveInfluences() > 1 then
								score = 0 -- dont overdo it
							end
						end

						--Utils.LUA_DEBUGOUT("COUNTER score:" .. tostring(score))

						--Utils.LUA_DEBUGOUT("<-DiploScore_InfluenceNation")
						return score
					end
				end
			end
		-- Not in our corner and effectiveNeutrality low enough and interested in joining
		elseif dist > 0.5 and effectiveNeutrality < 0.8 and StrategicJoinScore(recipient, recipientCountry, actorFaction) > 0.5 then
			--Utils.LUA_DEBUGOUT("----------------------------------------------------------")
			--Utils.LUA_DEBUGOUT(tostring(actor) .. " influencing " .. tostring(recipient))
			--Utils.LUA_DEBUGOUT("\t" .. "effectiveNeutrality:" .. tostring(effectiveNeutrality))

			local strategic = StrategicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			--Utils.LUA_DEBUGOUT("\t" .. "strategic:" .. tostring(strategic))

			--local diplomatic = DiplomaticInfluenceScore(actor, actorCountry, recipient, recipientCountry) * 0.3
			-- Get faction leader's opinion in diplomatic matters
			diplomatic = diplomatic * 0.3 + DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry) * 0.7
			--Utils.LUA_DEBUGOUT("\t" .. "diplomatic:" .. tostring(diplomatic))

			local economic = EconomicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			--Utils.LUA_DEBUGOUT("\t" .. "economic:" .. tostring(economic))

			local randomness = (math.mod(CCurrentGameState.GetAIRand(), 100) / 100) * 0.1 - 0.05 -- +/-5%

			score = 100 * (1 - effectiveNeutrality) * (strategic + diplomatic + economic + randomness)
			--Utils.LUA_DEBUGOUT("\t" .. "score:" .. tostring(score))

			--Utils.LUA_DEBUGOUT("<-DiploScore_InfluenceNation")
			return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
		end

		--Utils.LUA_DEBUGOUT("<-DiploScore_InfluenceNation")
		return Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
	else
		--Utils.LUA_DEBUGOUT("<-DiploScore_InfluenceNation")
		return 100 -- we cant respond to this
	end
end
-- for debugging
local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }



function DiploScore_InviteToFaction(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_InviteToFaction " .. tostring(actor) .. " <-> " .. tostring(recipient))
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
						--Utils.LUA_DEBUGOUT("<-DiploScore_InviteToFaction")
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

		--Utils.LUA_DEBUGOUT("<-DiploScore_InviteToFaction")
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

		score = StrategicJoinScore(recipient, recipientCountry, actorFaction) * score
		--Utils.LUA_DEBUGOUT("\t" .. "StrategicJoinScore:\t" .. tostring(StrategicJoinScore(recipient, recipientCountry, actorFaction)))

		local effectiveNeutrality = recipientCountry:GetEffectiveNeutrality():Get() / 100
		--Utils.LUA_DEBUGOUT("\t" .. "Effective neutrality:\t" .. tostring(effectiveNeutrality))

		score = 100 * score * (1 - effectiveNeutrality)
		--Utils.LUA_DEBUGOUT("Final score: " .. tostring(score))

		--Utils.LUA_DEBUGOUT("<-DiploScore_InviteToFaction")
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			return Utils.CallScoredCustomAI('CustomFactionAcceptRules', score, ai, actor, recipient, observer)
		else
			return Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
		end
	end
end


function DiploScore_Guarantee(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_Guarantee " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local score = 0

	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()
		if actorCountry:HasFaction() and actorCountry:GetFaction() == recipientCountry:GetFaction() then
			--Utils.LUA_DEBUGOUT("<-DiploScore_Guarantee")
			return 0 -- pointless
		end

		if actorCountry:IsGovernmentInExile() then
			--Utils.LUA_DEBUGOUT("<-DiploScore_Guarantee")
			return 0 -- pointless
		end

		local strategy = actor:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(recipient) / 2
		score = score + strategy:GetProtectionism(recipient)
		score = score - strategy:GetAntagonism(recipient) / 2
		score = score - actor:GetCountry():GetDiplomaticDistance(recipient):GetTruncated()

	end

	score = Utils.CallScoredCountryAI(actor, 'DiploScore_Guarantee', score, ai, actor, recipient, observer)

	--Utils.LUA_DEBUGOUT("<-DiploScore_Guarantee")
	return score
end


function DiploScore_Embargo(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_Embargo " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		local score = 0
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		if actorCountry:IsAtWar() then
			for enemy in actorCountry:GetCurrentAtWarWith() do
				if recipient:GetCountry():IsFriend(enemy, true) then
					--Utils.LUA_DEBUGOUT( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. 100 )
					--Utils.LUA_DEBUGOUT("<-DiploScore_Embargo")
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

		--Utils.LUA_DEBUGOUT("<-DiploScore_Embargo")
		return Utils.CallScoredCountryAI(actor, 'DiploScore_Embargo', score, ai, actor, recipient, observer)
	else
		--Utils.LUA_DEBUGOUT("<-DiploScore_Embargo")
		return 0 -- cant respond to this action
	end
end


function DiploScore_NonAgression(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_NonAgression " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then -- we demand nap with recipient
		--Utils.LUA_DEBUGOUT("<-DiploScore_NonAgression")
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

		--Utils.LUA_DEBUGOUT("<-DiploScore_NonAgression")
		return Utils.CallScoredCountryAI(recipient, 'DiploScore_NonAgression', score, ai, actor, recipient, observer)
	end
end

function DiploScore_DemandMilitaryAccess(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_DemandMilitaryAccess " .. tostring(actor) .. " <-> " .. tostring(recipient))
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
			--Utils.LUA_DEBUGOUT("<-DiploScore_DemandMilitaryAccess")
			return 0
		end

		-- much bigger than us and bordering
        local actorCountry = actor:GetCountry()
		if ( ai:GetNumberOfOwnedProvinces(actor) / 5 > ai:GetNumberOfOwnedProvinces(recipient) )
        and actorCountry:IsNeighbour( recipient )
        then
			-- if we are not in faction and they are at war
            if actorCountry:IsAtWar()
            and not (recipient:GetCountry():HasFaction())
            then
                score = 50
            end
		end

		if rel:HasAlliance() then
			score = 80
		end

		--Utils.LUA_DEBUGOUT("<-DiploScore_DemandMilitaryAccess")
		return Utils.CallScoredCountryAI(recipient, 'DiploScore_DemandMilitaryAccess', score,ai, actor, recipient, observer)
	end
end

function DiploScore_OfferMilitaryAccess(ai, actor, recipient, observer, action)
	--Utils.LUA_DEBUGOUT("->DiploScore_OfferMilitaryAccess " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local score = 0
	if observer == actor then --should we offer access to recipient
		local rel = ai:GetRelation(actor, recipient)
		if rel:HasWar() then
			--Utils.LUA_DEBUGOUT("<-DiploScore_OfferMilitaryAccess")
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
	--Utils.LUA_DEBUGOUT("<-DiploScore_OfferMilitaryAccess")
	return score
end

function DiploScore_Alliance(ai, actor, recipient, observer, action)
	--Utils.LUA_DEBUGOUT("->DiploScore_Alliance " .. tostring(actor) .. " <-> " .. tostring(recipient))
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
			--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
			return 0
		end

		-- If we are in a faction don't make alliances
		if recipientCountry:HasFaction() then
			--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
			return 0
		end

		if not IsNeighbourOnSameContinent(actor, actorCountry, recipient, recipientCountry) then
			--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
			return 0
		end

		--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
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
			--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
			return 0
		end

		-- If we are in a faction don't make alliances
		if actorCountry:HasFaction() then
			--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
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
					--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
					return 0 -- fighting our friends
				end
			end

			if bMutualEnemies then
				score = score * 1.2
			else
				score = score / 2 -- better wait until they sorted their problems
			end
		end

		--Utils.LUA_DEBUGOUT("<-DiploScore_Alliance")
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


	local antagonism = strategy:GetAntagonism(target)
	local friendliness = strategy:GetFriendliness(target)

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
	--Utils.LUA_DEBUGOUT("->DiploScore_PeaceAction " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		--Utils.LUA_DEBUGOUT("<-DiploScore_PeaceAction")
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

		--Utils.LUA_DEBUGOUT("<-DiploScore_PeaceAction")
		return score
	end
end

function DiploScore_SendExpeditionaryForce(ai, actor, recipient, observer, action)
	--Utils.LUA_DEBUGOUT("->DiploScore_SendExpeditionaryForce " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		--Utils.LUA_DEBUGOUT("<-DiploScore_SendExpeditionaryForce")
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

			--Utils.LUA_DEBUGOUT("<-DiploScore_SendExpeditionaryForce")
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

		--Utils.LUA_DEBUGOUT("<-DiploScore_SendExpeditionaryForce")
		return 0
	end
end

function DiploScore_LicenceTechnology(ai, LicenceBuyer, LicenceGiver, observer, action)
	--Utils.LUA_DEBUGOUT("->DiploScore_LicenceTechnology " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == LicenceBuyer then
		--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
		return 0
	else
		--Utils.LUA_DEBUGOUT("-> LicenceTechnology " .. tostring(LicenceBuyer) .. " buying from " ..  tostring(LicenceGiver))
		if not action:GetSubunit() then
			--Utils.LUA_DEBUGOUT("LICENS -> not action:GetSubunit()")
			--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
			return 0
		end

		local score = 0
		local LicenceBuyerCountry = LicenceBuyer:GetCountry()
		local LicenceGiverCountry = LicenceGiver:GetCountry()
		local rel = ai:GetRelation(LicenceGiver, LicenceBuyer)

		if rel:HasWar() then
			--Utils.LUA_DEBUGOUT("LICENS -> rel:HasWar() "..tostring(rel:HasWar()))
			--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
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
				--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
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
					--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
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
		--Utils.LUA_DEBUGOUT("<-DiploScore_LicenceTechnology")
		return math.min(100, score)
	end
end

function DiploScore_Debt(ai, actor, recipient, observer)
	--Utils.LUA_DEBUGOUT("->DiploScore_Debt " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	local score = 0
	if observer == actor then
		if recipientCountry:IsAtWar()
		and ( recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction() )
		then
			if actorCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get() < 10
			and actorCountry:GetDailyBalance(CGoodsPool._MONEY_):Get() < 0
			then
				score = 100
			else
				score = 0
			end
		else
			score = 0
		end
	else
		if recipientCountry:IsAtWar()
		and ( recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction() )
		then
			local recipientMoney = recipientCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()
			local actorMoney = actorCountry:GetPool():Get( CGoodsPool._MONEY_ ):Get()
			if (recipientMoney * 5 > actorMoney)
			and (recipientMoney > 200) then
				score = 100
			else
				score = 0
			end
		else
			score = 0
		end
	end

	--Utils.LUA_DEBUGOUT("<-DiploScore_Debt")
	return score
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
	--Utils.LUA_DEBUGOUT("->DiploScore_CallAlly " .. tostring(actor) .. " <-> " .. tostring(recipient))

	local score = 0
	if observer == actor then
		score = 100
	else
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		if actorCountry:GetFaction() == recipientCountry:GetFaction() then
			score = 100
		elseif recipientCountry:GetOverlord() == actor then
			score = 100
		else
			local score = DiploScore_Alliance(ai, actor, recipient, observer, nil)
			if score < 50 then
				score = 40
			else
				score = 100
			end
		end
	end

	--Utils.LUA_DEBUGOUT("<-DiploScore_CallAlly")
	return score
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

