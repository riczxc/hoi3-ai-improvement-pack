-----------------------------------------------------------
-- foreign minister
-----------------------------------------------------------

require('ai_diplomacy')
require('ai_trade')

function ForeignMinister_EvaluateDecision(agent, decision, scope)
	-- default we approve any decision we can take, override in country specific ai if wanted
	-- also some random to spread out the decisions
	local score = math.mod( CCurrentGameState.GetAIRand(), 100)

	score = Utils.CallScoredCountryAI(agent:GetCountryTag(), 'ForeignMinister_EvaluateDecision', score, agent, decision, scope)

	if score < 25 then
		score = 0
	end
	return score
end

function ForeignMinister_Tick(minister)
	--local t = os.clock()

	-- run any decisions available
	minister:ExecuteDiploDecisions()

	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.DIP_PEACE_DELAY) == 0 then
		ForeignMinister_HandlePeace(minister)
	end

	if minister:GetCountry():IsAtWar() then
		ForeignMinister_HandleWar(minister)
	end

	--Utils.LUA_DEBUGOUT("ForeignMinister_Tick - " .. tostring(minister:GetCountryTag()) .. " - " .. os.clock() - t)
end

function ForeignMinister_HandleWar( minister )

	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.DIP_WAR_DELAY) == 0 then
		return
	end

	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()

	for neighborTag in ministerCountry:GetNeighbours() do

		local neigborCountry = neighborTag:GetCountry()
		for countryTag in ministerCountry:GetCurrentAtWarWith() do

			-- mutual neighbors would be nice to move through
			if neigborCountry:IsNeighbour( countryTag ) then
				local relation = ai:GetRelation(ministerTag, neighborTag)

				if not relation:HasMilitaryAccess() then
					local action = CMilitaryAccessAction(ministerTag, countryTag)

					if action:IsSelectable() then

						local acceptanceChance = action:GetAIAcceptance()
						local score = DiploScore_DemandMilitaryAccess( ai, ministerTag, countryTag, ministerTag )

						if score > 50 and acceptanceChance > 40 then
							minister:Propose( action, score )
						end
					end
				end
			end
		end -- war targets
	end -- neighbors


	-- check wars
	for diploStatus in ministerCountry:GetDiplomacy() do
		local target = diploStatus:GetTarget()
		if target:IsValid() and diploStatus:HasWar() then
			local war = diploStatus:GetWar()
			if war:IsLimited() then
				-- always call in puppets
				for vassalTag in ministerCountry:GetVassals() do
					if not war:IsPartOfWar(vassalTag) then
						local action = CCallAllyAction( ministerTag, vassalTag, target )
						action:SetValue( true ) -- limited
						if action:IsSelectable() then
							ai:PostAction( action )
						end
					end
				end


				-- compare military power
				local intel = CAIIntel(ministerTag, target)
				local theirStrength = intel:CalculateTheirPercievedMilitaryStrengh()
				-- factor in their allies that are part of war
				for hostileAllyTag in target:GetCountry():GetAllies() do
					if war:IsPartOfWar(hostileAllyTag) then
						local allyIntel = CAIIntel(ministerTag, hostileAllyTag)
						local allyStrength = allyIntel:CalculateTheirPercievedMilitaryStrengh()
						theirStrength = theirStrength + allyStrength
					end
				end

				-- do we want to call in help?
				if war:GetCurrentRunningTimeInMonths() > 5 then
					local ourStrength = intel:CalculateOurMilitaryStrength()
					local strengthFactor = ourStrength / theirStrength
					if strengthFactor < 1.4 then
						for allyTag in ministerCountry:GetAllies() do
							if not war:IsPartOfWar(allyTag) then
								local action = CCallAllyAction( ministerTag, allyTag, target )
								action:SetValue( true ) -- limited
								if action:IsSelectable() then
									ai:PostAction( action )
								end
							end
						end
					end
				end
			else -- not-limited, call in any faction members not there:
				for allyTag in ministerCountry:GetAllies() do
					if not war:IsPartOfWar(allyTag) then
						local action = CCallAllyAction( ministerTag, allyTag, target )
						action:SetValue( true ) -- limited
						if action:IsSelectable() then
							ai:PostAction( action )
						end
					end
				end
			end
		end
	end
end

function ForeignMinister_HandlePeace( minister )

	local ministerCountry = minister:GetCountry()
	local ministerTag = ministerCountry:GetCountryTag()
	local ai = minister:GetOwnerAI()
	local strategy = ministerCountry:GetStrategy()

	local slider = ministerCountry:GetLeadershipDistributionAt( CDistributionSetting._LEADERSHIP_DIPLOMACY_ )
	local amount = slider:GetNeeded():Get()
	local influence = ministerCountry:GetTotalLeadership():Get() * ai_configuration.LEADERSHIP_TO_INFLUENCE	-- 18% of leadership should be influence..
	influence = influence * defines.economy.LEADERSHIP_TO_DIPLOMACY
	influence = influence - amount

	for country in CCurrentGameState.GetCountries() do
		local countryTag = country:GetCountryTag()

		if countryTag:IsValid() and country:Exists() and countryTag:IsReal() and
		   not (ministerCountry:HasDiplomatEnroute(countryTag)) and
		   not (countryTag == ministerTag) then

			local relation = ministerCountry:GetRelation( countryTag )

			-- strategy
			local strategy = ministerCountry:GetStrategy()
			local threat = relation:GetThreat():Get()
			local antagonism = strategy:GetAntagonism(countryTag)
			local friendliness = strategy:GetFriendliness(countryTag)
			local protectionism = strategy:GetProtectionism(countryTag)

			-- war
			-- non-scripted war declaration:
			--ProposeDeclareWar( minister, ai, ministerCountry, countryTag )

			-- alliance
			if not relation:HasAlliance() and relation:GetValue():GetTruncated() > 0 then
				local action = CAllianceAction(ministerTag, countryTag)
				if action:IsSelectable() then

					local score = DiploScore_Alliance( ai, ministerTag, countryTag, ministerTag )
					if score > 50 then
						local acceptanceChance = action:GetAIAcceptance()
						if acceptanceChance > 40 then
							minister:Propose( action, score )
						end
					end
				end
			end

			-- offer military access
			if not country:GetRelation(ministerTag):HasMilitaryAccess() then
				local action = COfferMilitaryAccessAction(ministerTag, countryTag)

				if action:IsSelectable() then
					local score = DiploScore_OfferMilitaryAccess( ai, ministerTag, countryTag, ministerTag )
					if score > 50 then
						local acceptanceChance = action:GetAIAcceptance()
						if acceptanceChance > 50 then
							minister:Propose( action, score )
						end
					end
				end
			end

			-- NAP-ing
			if not country:GetRelation(ministerTag):HasNap() then
				local action = CNapAction(ministerTag, countryTag)
				if action:IsSelectable() then
					--Utils.LUA_DEBUGOUT("NAP")
					local acceptanceChance = action:GetAIAcceptance()
					if acceptanceChance > 50 then
						local score = DiploScore_NonAgression( ai, ministerTag, countryTag, ministerTag )
						if score > 50 then
							minister:Propose( action, score )
						end
					end
				end
			end

			if not relation:IsGuaranting() then
				local action = CGuaranteeAction(ministerTag, countryTag)
				if action:IsSelectable() then
					local score = DiploScore_Guarantee( ai, ministerTag, countryTag, ministerTag )
					if score > 50 then
						minister:Propose( action, score )
					end
				end
			end

			-- invite/influence to faction
			if ministerCountry:HasFaction() then

				if not country:HasFaction() then

					local action = CFactionAction(ministerTag, countryTag)
					action:SetValue(false)

					if action:IsSelectable() then
						local acceptanceChance = action:GetAIAcceptance()
						if acceptanceChance > 40 then
							local score = DiploScore_InviteToFaction( ai, ministerTag, countryTag, ministerTag )
							if score > 50 then
								minister:Propose( action, score )
							end
						end
					end

					local influenceAction = CInfluenceNation(ministerTag, countryTag)
					if influenceAction:IsSelectable() then
						if influence >  0 and ministerCountry:GetDiplomaticInfluence():Get()>10 then
							local score = DiploScore_InfluenceNation( ai, ministerTag, countryTag, ministerTag )
							if score > 50 then
								minister:Propose( influenceAction, score )
							end
						end
					end

				end
			end

			-- see if we can help out
			if not country:GetRelation(ministerTag):AllowDebts() then

				local action = CDebtAction(ministerTag, countryTag)
				if ministerCountry:GetTotalIC() < country:GetTotalIC() then
					if action:IsSelectable() then
						local score = DiploScore_Debt( ai, ministerTag, countryTag, ministerTag )
						if score > 50 then
							local acceptanceChance = action:GetAIAcceptance()
							if acceptanceChance > 50 then
								minister:Propose( action, score )
							end
						end
					end
				end
			end

			-- embargos
			if relation:HasEmbargo() then
				-- do we want to stop embargoing?
				local action = CEmbargoAction(ministerTag, countryTag)
				action:SetValue(false)

				if action:IsSelectable() then
					local embargoScore = DiploScore_Embargo( ai, ministerTag, countryTag, ministerTag )

					if embargoScore < 40 then
						minister:Propose( action, 100 )
					end
				end

			else
				local action = CEmbargoAction(ministerTag, countryTag)

				if action:IsSelectable() then
					local score = DiploScore_Embargo( ai, ministerTag, countryTag, ministerTag )

					if score > 50 then
						minister:Propose( action, score )
					end
				end

			end

			--if warDesirability < 0 and ai:IsPreparingWarWith( countryTag ) then
			--	-- no longer a good idea
			--	ai:CancelPrepareWar( countryTag )
			--	if minister:GetProposedWarTarget() == countryTag then
			--		ClearWarProposal()
			--	end
			--end

		end -- country:Exists()
	end -- countries

	-- scripted wars
	Utils.CallCountryAI( ministerTag, 'ProposeDeclareWar', minister )

	-- are we interested in joining a faction?
	if not ministerCountry:HasFaction() then
		local bestFaction = nil
		local bestScore = -1
		for faction in CCurrentGameState.GetFactions() do

			if faction:IsValid() then

				-- evaluate faction
				local progress = faction:GetNormalizedProgress()
				local score = progress:Get()
				local dist = minister:GetOwnerAI():GetNormalizedAlignmentDistance(ministerCountry, faction):Get()
				if dist < 1 then
					score = score + 100 * (1.0 - dist/2.0) -- closeness
				end


				score = Utils.CallScoredCountryAI(ministerTag, 'DiploScore_JoinFaction', score, minister, faction)

				if bestScore < score then
					bestScore = score
					bestFaction = faction
				end
			end
		end

		if bestFaction and bestScore > 50 then
			local action = CInfluenceAllianceLeader( ministerTag, bestFaction:GetFactionLeader() )
			if action:IsSelectable() then
				minister:Propose( action, bestScore )
			end
		end
	end

	-- break any deals?
	for alliedCountry in ministerCountry:GetAllies() do
		local rel = ministerCountry:GetRelation( alliedCountry )
		local relValue = rel:GetValue():GetTruncated()

		local threat = rel:GetThreat():Get()
		threat = threat * CalculateAlignmentFactor(ai, ministerCountry, alliedCountry:GetCountry())
		local antagonism = strategy:GetAntagonism( alliedCountry ) / 4
		local friendliness = strategy:GetFriendliness( alliedCountry ) / 4

		local score = ((antagonism + threat) / 2.0) - friendliness
		score = score - relValue / 2.0

		if score >= 100 then
			local action = CAllianceAction(ministerTag, alliedCountry)
			action:SetValue(false) -- cancel
			if action:IsSelectable() then
				minister:Propose( action, score )
			end
		end
	end

	--EvalutateExistingTrades(minister)

end

function ProposeDeclareWar( minister, ai, ministerCountry, countryTag )

	local warDesirability = CalculateWarDesirability( ai, ministerCountry, countryTag )

	if warDesirability > 40 then
		minister:ProposeWar( countryTag, warDesirability )
	end


	-- check if we would like to do a limited war instead (axis only)
	if ministerCountry:GetRules():GetValue( CRule._RULE_LIMITED_WAR_ ) then
		local limitedWarScore = EvaluateLimitedWar( minister, countryTag, warDesirability )
		if limitedWarScore > 50 then
			local action = CDeclareWarAction(ministerTag, countryTag)
			action:SetValue(false)
			minister:Propose( action, limitedWarScore )
		end
	end
end


-- Check if we want to do a limited war
function EvaluateLimitedWar(minister, target, warDesirability )
    local score = 0
    if warDesirability > 80 then
		score = 100
    end
    return Utils.CallScoredCountryAI(minister:GetCountryTag(), 'EvaluateLimitedWar',
									 score, minister, target, warDesirability)
end

function ForeignMinister_OnWar( agent, countryTag1, countryTag2, war )
	if war:IsLimited() then
		-- dont pull anything else right now, lets wait until we need it
	end
end
