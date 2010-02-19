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
		--dtools.debug(tostring(countryTagA) .. " <-> " .. tostring(countryTagB))
		--dtools.debug("\trelation:" .. tostring(relation))
		--dtools.debug("\tthreat:" .. tostring(threat))
		--dtools.debug("\tantagonism:" .. tostring(antagonism))
		--dtools.debug("\tfriendliness:" .. tostring(friendliness))
		--dtools.debug("\tprotectionism:" .. tostring(protectionism))
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
			balance[goods] = GetAverageBalance(countryA, goods) - Importing(countryA, goods)
			if goods == CGoodsPool._CRUDE_OIL_ then
				balance[goods] = balance[goods] + GetAverageBalance(countryA, CGoodsPool._FUEL_)  - Importing(countryA, CGoodsPool._FUEL_)
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
					local balanceB = GetAverageBalance(countryB, goods) + Exporting(countryB, goods)
					-- A little cheating here...
					if balanceB > 0 and not ExistsImport(countryB, goods) then
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
	local score = 0
	local factionA = countryA:GetFaction()
	local leaderA = factionA:GetFactionLeader()
	local leaderCountryA = leaderA:GetCountry()
	
	local blackList = {}
	if factionA == CCurrentGameState.GetFaction('axis') then
		-- Axis members want to conquer
		if (countryB:GetMaxIC() < 20) then
			return -10
		end

		blackList = {
			CCountryDataBase.GetTag('POL'),
			CCountryDataBase.GetTag('AUS'),
			CCountryDataBase.GetTag('NOR'),
			CCountryDataBase.GetTag('SWE'),
			CCountryDataBase.GetTag('DEN'),
			CCountryDataBase.GetTag('YUG'),
			CCountryDataBase.GetTag('HOL'),
			CCountryDataBase.GetTag('BEL'),
			CCountryDataBase.GetTag('LUX')
		}
	elseif factionA == CCurrentGameState.GetFaction('comintern') then
		blackList = {
			CCountryDataBase.GetTag('POL'),
			CCountryDataBase.GetTag('AUS'),
			CCountryDataBase.GetTag('FIN')
		}
	end

	for _,ignoreTag in ipairs(blackList) do
		if tagB == ignoreTag then
			return -10
		end
	end

	local factionDislike = 0
	for member in factionA:GetMembers() do
		local memberCountry = member:GetCountry()
		if memberCountry:GetStrategy():IsPreparingWarWith(tagB) then
			factionDislike = factionDislike + (memberCountry:GetMaxIC() / leaderCountryA:GetMaxIC())
		elseif HasClaims(member, tagB) then
			factionDislike = factionDislike + 0.5 * (memberCountry:GetMaxIC() / leaderCountryA:GetMaxIC())
		end
	end

	local strategy = countryA:GetStrategy()

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
				if neighbourFaction:IsValid() and neighbourFaction ~= factionA then
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
			local damage = math.min(0.5 + countryB:GetMaxIC() / neighbourCountry:GetMaxIC(), 1)
			score = math.max(importanceFactor * damage, score)
		end
	end

	-- Are we neighbours and don't have claims?
	if isANeighbourToB and not HasClaims(tagA, tagB) then
		score = score + 0.5
	end

	-- local distanceScore = math.max((countryA:GetDiplomaticDistance(tagB):GetTruncated() / 12000) - 0.25, 0)
	-- score = score * (1 - distanceScore)

	return math.min(score * (1 - factionDislike), 1)
end

function StrategicJoinScore(tag, country, faction)
	local countryIC = country:GetMaxIC()
	local enemyIC = 0
	local hostileIC = 0
	local friendlyIC = countryIC
	local leader = faction:GetFactionLeader()
	local leaderCountry = leader:GetCountry()

	local neighbourToLeader = false

	for neighbour in country:GetNeighbours() do
		if neighbour == leader then
			neighbourToLeader = true
		end
		
		local neighbourCountry = neighbour:GetCountry()
		if IsNeighbourOnSameContinent(tag, country, neighbour, neighbourCountry) then

			-- Only factor neighbours we're at peace with
			if not country:IsEnemy(neighbour) then

				-- Neighbour is hostile to faction
				if neighbourCountry:IsEnemy(leader) then
					enemyIC = enemyIC + neighbourCountry:GetMaxIC()
					--dtools.debug(tostring(leader) .. " is enemy to " .. tostring(neighbour))

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
	
	if not neighbourToLeader and IsOnSameContinent(tag, country, leader, leaderCountry) then
		-- Add IC of faction leader to friendlyIC
		friendlyIC = friendlyIC + leaderCountry:GetMaxIC() * (1 - country:GetDiplomaticDistance(leader):Get() / 6000)
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
	elseif a == 'PAN' then
		return b == 'USA'
	elseif a == 'POL' then
		return b == 'SOV'
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

	--dtools.debug("---------------CalculateFactionSympathy---------------")
	--dtools.debug("dist: " .. tostring(dist))
	--dtools.debug("closeness: " .. tostring(closeness))
	--dtools.debug("progress: " .. tostring(progress))
	--dtools.debug("sympathy: " .. tostring(sympathy))

	if closeness == 0 then
		return 0
	end

	return closeness + (1 - closeness) * (0.25 * progress + 0.75 * sympathy)
end

function DiploScore_InfluenceNation(ai, actor, recipient, observer)
	dtools.debug("----------------------------------------------------------")
	
	local score = 0
	
	if observer == actor then
		dtools.debug("Probability of " .. tostring(actor) .. " influencing " .. tostring(recipient))
		
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		local actorFaction = actorCountry:GetFaction()
		local leader = actorFaction:GetFactionLeader()
		local leaderCountry = leader:GetCountry()

		local neutrality = recipientCountry:GetNeutrality():Get()
		-- Don't influence neutral countries
		if neutrality >= 75 then
			score = Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', 0, ai, actor, recipient, observer)
			dtools.debug("Final score: " .. score)
			return score
		end

		local effectiveNeutrality = math.max(recipientCountry:GetEffectiveNeutrality():Get() / 100, 0)
		dtools.debug("\tEffective neutrality: " .. tostring(effectiveNeutrality * 100))
		
		local dist = ai:GetNormalizedAlignmentDistance(recipientCountry, actorFaction):Get()
		dtools.debug("\tDist to faction: " .. dist)
		
		if dist < 0.5 then
			dtools.debug("Final score: " .. 0)
			return 0
		end

		-- Only counter influence if we don't hate them. If we hate them we don't care what happens to them.
		local diplomatic = DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		dtools.debug("\tDiplomatic influence: " .. tostring(diplomatic * 100))
		local strategic_join_score = StrategicJoinScore(recipient, recipientCountry, actorFaction)
		dtools.debug("\tStrategic join: " .. tostring(strategic_join_score * 100))
		
		if ai_configuration.COUNTER_INFLUENCE == 1 and dist > 12 and diplomatic > -0.25 then
			-- Base interest if and how long we're counter influencing on our protectionism to them.
			local strategy = leaderCountry:GetStrategy()
			local protectionism = strategy:GetProtectionism(recipient)
			local maxDist = math.min(3 + protectionism / 10, 10)

			for faction in CCurrentGameState.GetFactions() do
				if faction:IsValid() and faction ~= actorFaction then
					dist = ai:GetNormalizedAlignmentDistance(recipientCountry, faction):Get()

					if dist > 0.75 and dist < maxDist then
						--dtools.debug("----------------------------------------------------------")
						--dtools.debug(tostring(actor) .. " COUNTER influencing " .. tostring(recipient))

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

						--dtools.debug("COUNTER score:" .. tostring(score))

						--dtools.debug("<-DiploScore_InfluenceNation")
						return score
					end
				end
			end
		-- Not in our corner but nearly enough and effectiveNeutrality low enough and interested in joining
		elseif dist > 0.5 and dist < 10 and effectiveNeutrality < 0.8 and strategic_join_score > 0.5 then
			local strategic = StrategicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			dtools.debug("\tStrategic influence: " .. tostring(strategic * 100))

			local economic = EconomicInfluenceScore(actor, actorCountry, recipient, recipientCountry)
			dtools.debug("\tEconomic influence: " .. tostring(economic * 100))

			local randomness = (math.mod(CCurrentGameState.GetAIRand(), 100) / 100) * 0.1 - 0.05 -- +/-5%
			dtools.debug("\tRandomness: " .. tostring(randomness * 100))

			score = 100 * (1 - effectiveNeutrality) * (strategic + diplomatic + economic + randomness)
			dtools.debug("\tScore: " .. score)

			score = Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
		end

		score = Utils.CallScoredCountryAI(actor, 'DiploScore_InfluenceNation', score, ai, actor, recipient, observer)
	else
		dtools.debug("Probability of " .. recipient .. " allowing to be influenced by " .. actor)
		
		score = 100 -- we cant respond to this
	end
	
	dtools.debug("Final score: " .. score)
	return score
end
-- for debugging
local GOODS_TO_STRING = { [0] = "_SUPPLIES_","_FUEL_",	"_MONEY_",	"_CRUDE_OIL_",	"_METAL_",	"_ENERGY_",	"_RARE_MATERIALS_" }



function DiploScore_InviteToFaction(ai, actor, recipient, observer)
	dtools.debug("----------------------------------------------------------")
	
	local score = 0

	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()

	local actorFaction = actorCountry:GetFaction()
	local leader = actorFaction:GetFactionLeader()
	local leaderCountry = leader:GetCountry()

	if observer == actor then -- are recipient worth inviting
		dtools.debug("Probability of " .. tostring(actor) .. " inviting " .. tostring(recipient))
	
		if recipientCountry:IsAtWar() then
			-- is our war target at war with the faction
			for diploStatus in recipientCountry:GetDiplomacy() do
				local target = diploStatus:GetTarget()
				if target:IsValid() and diploStatus:HasWar() then
					if actor:GetCountry():GetRelation(target):HasWar() then
						dtools.debug("Final score: " .. 100)
						return 100
					end
				end
			end
		end

		-- Leader decides
		local strategic = StrategicInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		dtools.debug("\t" .. "StrategicInfluenceScore: " .. tostring(strategic * 100))
		
		local diplomatic = DiplomaticInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		dtools.debug("\t" .. "DiplomaticInfluenceScore: " .. tostring(diplomatic * 100))
		
		local economic = EconomicInfluenceScore(leader, leaderCountry, recipient, recipientCountry)
		dtools.debug("\t" .. "EconomicInfluenceScore: " .. tostring(economic * 100))

		score = 100 * (strategic + diplomatic + economic)

		--dtools.debug("<-DiploScore_InviteToFaction")
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			score = Utils.CallScoredCustomAI('CustomFactionInviteRules', score, ai, actor, recipient, observer)
		else
			score = Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
		end
	else -- do we, recipient want to accept invite to faction
		score = CalculateFactionSympathy(ai, recipientCountry, actorFaction)

		dtools.debug("Probability of " .. tostring(recipient) .. " joining " .. tostring(leader))
		dtools.debug("\t" .. "Faction sympathy: " .. tostring(score * 100))

		local strategic = StrategicJoinScore(recipient, recipientCountry, actorFaction)
		dtools.debug("\t" .. "Strategic join score: " .. tostring(strategic * 100))

		local effectiveNeutrality = math.max(recipientCountry:GetEffectiveNeutrality():Get() / 100, 0)
		dtools.debug("\t" .. "Effective neutrality: " .. tostring(effectiveNeutrality * 100))

		score = 100 * score * (1 - effectiveNeutrality) * strategic

		--dtools.debug("<-DiploScore_InviteToFaction")
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			score = Utils.CallScoredCustomAI('CustomFactionAcceptRules', score, ai, actor, recipient, observer)
		else
			score = Utils.CallScoredCountryAI(recipient, 'DiploScore_InviteToFaction', score, ai, actor, recipient, observer)
		end
	end
	
	dtools.debug("Final score: " .. tostring(score))
	return score
end


function DiploScore_Guarantee(ai, actor, recipient, observer)
	--dtools.debug("->DiploScore_Guarantee " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local score = 0

	if observer == actor then
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()
		if actorCountry:HasFaction() and actorCountry:GetFaction() == recipientCountry:GetFaction() then
			--dtools.debug("<-DiploScore_Guarantee")
			return 0 -- pointless
		end

		if actorCountry:IsGovernmentInExile() then
			--dtools.debug("<-DiploScore_Guarantee")
			return 0 -- pointless
		end

		local strategy = actor:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(recipient) / 2
		score = score + strategy:GetProtectionism(recipient)
		score = score - strategy:GetAntagonism(recipient) / 2
		score = score - actor:GetCountry():GetDiplomaticDistance(recipient):GetTruncated()

	end

	score = Utils.CallScoredCountryAI(actor, 'DiploScore_Guarantee', score, ai, actor, recipient, observer)

	--dtools.debug("<-DiploScore_Guarantee")
	return score
end


function DiploScore_Embargo(ai, actor, recipient, observer)
	--dtools.debug("->DiploScore_Embargo " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		local score = 0
		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		if actorCountry:IsAtWar() then
			for enemy in actorCountry:GetCurrentAtWarWith() do
				if recipient:GetCountry():IsFriend(enemy, true) then
					--dtools.debug( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. 100 )
					--dtools.debug("<-DiploScore_Embargo")
					return 80 -- fighting our friends
				end
			end
		end
		--dtools.debug( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. score )
		-- dont use up the last of our points for this
		if actorCountry:GetDiplomaticInfluence():Get() < (defines.diplomacy.EMBARGO_INFLUENCE_COST + 2) then
			score = score / 2 - 1
		end
		--dtools.debug( "embargo score " .. tostring(actor) .. " -> " .. tostring(recipient) .. " = " .. score )

		--dtools.debug("<-DiploScore_Embargo")
		return Utils.CallScoredCountryAI(actor, 'DiploScore_Embargo', score, ai, actor, recipient, observer)
	else
		--dtools.debug("<-DiploScore_Embargo")
		return 0 -- cant respond to this action
	end
end


function DiploScore_NonAgression(ai, actor, recipient, observer)
	--dtools.debug("->DiploScore_NonAgression " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then -- we demand nap with recipient
		--dtools.debug("<-DiploScore_NonAgression")
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
			--dtools.debug("NAP score: " .. score .. " for " .. tostring(actor) .. " - " .. tostring(recipient) )
			--dtools.debug("friendlyness: " .. strategy:GetFriendliness(actor) )
			--dtools.debug("antagonism: " .. strategy:GetAntagonism(actor) )
			--dtools.debug("threat: " .. strategy:GetThreat(actor) )
			--dtools.debug("d. dist: " ..  recipientCountry:GetDiplomaticDistance(actor):GetTruncated() )
			--dtools.debug("------------------------")
		--end

		--dtools.debug("<-DiploScore_NonAgression")
		return Utils.CallScoredCountryAI(recipient, 'DiploScore_NonAgression', score, ai, actor, recipient, observer)
	end
end

function DiploScore_DemandMilitaryAccess(ai, actor, recipient, observer)
	--dtools.debug("->DiploScore_DemandMilitaryAccess " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then -- we demand access of recipient
		local actorCountry = actor:GetCountry()
		local strategy = actorCountry:GetStrategy()
		local score = strategy:GetAccessScore(recipient)

		return score
	else -- actor demands access from us
		--dtools.debug("DiploScore_DemandMilitaryAccess_________________")
		local score = 0
		local rel = ai:GetRelation(recipient, actor)
		if rel:HasWar() then
			--dtools.debug("<-DiploScore_DemandMilitaryAccess")
			return 0
		end

		-- much bigger than us and bordering
        local actorCountry = actor:GetCountry()
		if ( ai:GetNumberOfOwnedProvinces(actor) / 5 > ai:GetNumberOfOwnedProvinces(recipient) )
        and actorCountry:IsNeighbour( recipient )
        then
			-- if we are not in faction and they are at war
            if actorCountry:IsAtWar()
            and not (recipient:GetCountry():HasFaction() and recipient:GetCountry():GetFaction():IsValid())
            then
                score = 50
            end
		end

		if rel:HasAlliance() then
			score = 80
		end

		--dtools.debug("<-DiploScore_DemandMilitaryAccess")
		return Utils.CallScoredCountryAI(recipient, 'DiploScore_DemandMilitaryAccess', score,ai, actor, recipient, observer)
	end
end

function DiploScore_OfferMilitaryAccess(ai, actor, recipient, observer, action)
	--dtools.debug("->DiploScore_OfferMilitaryAccess " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local score = 0
	if observer == actor then --should we offer access to recipient
		local rel = ai:GetRelation(actor, recipient)
		if rel:HasWar() then
			--dtools.debug("<-DiploScore_OfferMilitaryAccess")
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
	--dtools.debug("<-DiploScore_OfferMilitaryAccess")
	return score
end

function DiploScore_Alliance(ai, actor, recipient, observer, action)
	--dtools.debug("->DiploScore_Alliance " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then -- We (actor) invite recipient
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--dtools.debug("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end

       	local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()

		-- As a faction leader we dont want alliances, we want faction members
		if recipientCountry:IsFactionLeader() then
			--dtools.debug("<-DiploScore_Alliance")
			return 0
		end

		-- If we are in a faction don't make alliances
		if recipientCountry:HasFaction() then
			--dtools.debug("<-DiploScore_Alliance")
			return 0
		end

		if not IsNeighbourOnSameContinent(actor, actorCountry, recipient, recipientCountry) then
			--dtools.debug("<-DiploScore_Alliance")
			return 0
		end

		--dtools.debug("<-DiploScore_Alliance")
		return CalculateSympathy(actor, recipient) * 100
	else -- We (recipient) are invited by actor
		-- If Custom Triggers are used
		if ai_configuration.USE_CUSTOM_TRIGGERS > 0 then
			--dtools.debug("Use Custom Triggers Alliance")
			if Utils.CallScoredCustomAI('CustomAllianceRules', ai, actor, recipient, observer) == 0 then
				return 0
			end
		end

		local recipientCountry = recipient:GetCountry()
		local actorCountry = actor:GetCountry()

		 -- As a faction leader we dont want alliances, we want faction members
		if actorCountry:IsFactionLeader() then
			--dtools.debug("<-DiploScore_Alliance")
			return 0
		end

		-- If we are in a faction don't make alliances
		if actorCountry:HasFaction() then
			--dtools.debug("<-DiploScore_Alliance")
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
					--dtools.debug("<-DiploScore_Alliance")
					return 0 -- fighting our friends
				end
			end

			if bMutualEnemies then
				score = score * 1.2
			else
				score = score / 2 -- better wait until they sorted their problems
			end
		end

		--dtools.debug("<-DiploScore_Alliance")
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

	--dtools.debug("we can declare war: " .. tostring(minister:GetCountryTag()) .. " -> " .. tostring(target) )


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
	--dtools.debug("->DiploScore_PeaceAction " .. tostring(actor) .. " <-> " .. tostring(recipient))
	if observer == actor then
		--dtools.debug("<-DiploScore_PeaceAction")
		return 0
	else
		score = 0

		-- intel first
		--dtools.debug("----------")
		local intel = CAIIntel(recipient, actor)
		if intel:GetFactor() > 0.1 then
			local recipientStrength = intel:CalculateTheirPercievedMilitaryStrengh()
			local actorStrength = intel:CalculateOurMilitaryStrength()
			local strengthFactor = actorStrength / recipientStrength - 0.5
			score = 100 * strengthFactor
		end
		--dtools.debug("score: " .. score )

		local sizeFactor = actor:GetCountry():GetNumberOfControlledProvinces() / recipient:GetCountry():GetNumberOfControlledProvinces()
		--dtools.debug("sizeFactor: " .. sizeFactor )
		sizeFactor = (sizeFactor - 1) * 100

		score = score + math.min(sizeFactor, 100)

		score = score + recipient:GetCountry():GetSurrenderLevel():Get() * 100
		--dtools.debug("score: " .. score )
		score = score - actor:GetCountry():GetSurrenderLevel():Get() * 100
		--dtools.debug("score: " .. score )

		local strategy = recipient:GetCountry():GetStrategy()
		score = score + strategy:GetFriendliness(actor) / 2
		score = score - strategy:GetAntagonism(actor) / 2
		--score = score + strategy:GetThreat(actor) / 2
		--dtools.debug("score: " .. score )

		--dtools.debug("<-DiploScore_PeaceAction")
		return score
	end
end

function DiploScore_SendExpeditionaryForce(ai, actor, recipient, observer, action)
	-- Exp forces are bugged. Do same thing like in vanilla 1.3 for now, retun 0.
	-- TODO: Revise this in 1.4
	return 0
end


-- actor tries to buy a licence from recipient.
function DiploScore_LicenceTechnology(ai, actor, recipient, observer, action)
	if observer == actor then
		return 0
	else
		if not action:GetSubunit() then
			return 0
		end

		local rel = ai:GetRelation(recipient, actor)
		if rel:GetValue():GetTruncated() < 0 then
			return 0
		end
		if rel:HasWar() then
			return 0
		end

		local actorCountry = actor:GetCountry()
		local recipientCountry = recipient:GetCountry()

		local strategy = recipientCountry:GetStrategy()
		if 	strategy:GetThreat(actor) > 0 or
			strategy:GetAntagonism(actor) > 0 or
			strategy:IsPreparingWarWith(actor)
		then
			-- Do not give technology to countries we feel threaten from or
			-- we don't like or we're preparing a war against.
			return 0
		end

		-- we give discount to
		-- - people in faction
		-- - people in alliance
		-- - people fighting our enemies
		-- - people close in triangle (not far away! scale price here too)
		local discount = 1.0
		if (recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction()) then
			-- we give 50% discount
			discount = 0.5
		elseif rel:HasAlliance() then
			-- we give 40% discount
			discount = 0.6
		else
			if actorCountry:IsAtWar() then
				for enemy in actorCountry:GetCurrentAtWarWith() do
					if recipientCountry:IsEnemy(enemy) then
						-- we give 30% discount
						discount = 0.7
						break
					elseif recipientCountry:IsFriend(enemy, true)
					and ai:GetRelation(enemy, recipient):GetValue():GetTruncated() > 0
					then
						-- actor is fighting a friend of us -> no deal.
						return 0
					end
				end
			end
		end

		if discount == 1.0 then
			-- if they are in the other corner for example base price will double
			local alignment = CalculateAlignmentFactor(ai, actorCountry, recipientCountry)
			if alignment < 0.5 then
				-- give at max discount of 25%
				discount = discount + (alignment - 0.5) * 0.5
			else
				-- increase price
				discount = discount + (alignment - 0.5) * 2
			end

			-- a high threat is also not good for the price
			local threat = rel:GetThreat():Get() * alignment / 50
			discount = discount + threat
		end

		-- good relations give further discount (at max 15%)
		local relations = rel:GetValue():Get() / 200
		discount = discount - relations * 0.15

		-- now calculate the price we want for this subunit
		local subunit = action:GetSubunit()

		local price = 0.15

		price = price * recipientCountry:GetBuildCostIC(subunit, 1, false):Get() * recipientCountry:GetBuildTime(subunit, 1)

		local quantityDiscount = 1.0
		quantityDiscount = quantityDiscount * action:GetSerial() * action:GetParalell()
		quantityDiscount = 1 / math.pow(quantityDiscount, 0.05)

		--dtools.debug("Base price: " .. tostring(price))
		--dtools.debug("Discount: " .. tostring(discount))
		--dtools.debug("Quantity discount: " .. tostring(quantityDiscount))

		price = price * discount * quantityDiscount
		--dtools.debug("Final price: " .. tostring(price))

		local offeredMoney = action:GetMoney():Get()
		local score = (offeredMoney / price) * 100

		--dtools.debug("Offered money: " .. tostring(offeredMoney))
		--dtools.debug("Final score: " .. tostring(score))

		return score
	end
end

function DiploScore_Debt(ai, actor, recipient, observer)
	-- dtools.debug("->DiploScore_Debt " .. tostring(actor) .. " <-> " .. tostring(recipient))
	local actorCountry = actor:GetCountry()
	local recipientCountry = recipient:GetCountry()
	local rel = actorCountry:GetRelation(recipient)

	local score = 0
	if observer == actor then
		if recipientCountry:IsAtWar()
		and (
			(recipientCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction())
			or
			rel:HasAlliance()
		)
		then
			if IsPoor(actorCountry) then
				-- dtools.debug(tostring(actor) .. " is poor.")
				score = 100
			else
				-- dtools.debug(tostring(actor) .. " is not poor.")
				score = 0
			end
		end
	else
		if actorCountry:IsAtWar()
		and (
			(actorCountry:HasFaction() and recipientCountry:GetFaction() == actorCountry:GetFaction())
			or
			rel:HasAlliance()
		)
		then
			if IsRich(recipientCountry) then
				-- dtools.debug(tostring(recipient) .. " is rich.")
				score = 100
			else
				-- dtools.debug(tostring(recipient) .. " is not rich.")
				score = 0
			end
		end
	end

	-- dtools.debug("<-DiploScore_Debt: " ..  tostring(score))
	return score
end

function CustomFactionJoinRules( score, ai, actor, recipient, observer)
	if tostring(actor) == 'GER' then
		--dtools.debug("Yep getting in the GER custom script")
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
			--dtools.debug("WE DO NOT SEE THOSE OPTIONS!")
			return score
		end
	end

	--dtools.debug("Gets after the if!")
	return score
end


function DiploScore_CallAlly(ai, actor, recipient, observer, action)
	--dtools.debug("->DiploScore_CallAlly " .. tostring(actor) .. " <-> " .. tostring(recipient))

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

	--dtools.debug("<-DiploScore_CallAlly")
	return score
end
