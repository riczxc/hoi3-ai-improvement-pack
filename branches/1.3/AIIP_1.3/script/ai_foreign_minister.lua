-----------------------------------------------------------
-- foreign minister
-----------------------------------------------------------

require('ai_diplomacy')
require('ai_trade')
require('helper_functions')

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
	--Utils.LUA_DEBUGOUT("->ForeignMinister_Tick " .. tostring(minister:GetCountryTag()))

	-- run any decisions available
	minister:ExecuteDiploDecisions()

	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.DIP_PEACE_DELAY) == 0 then
		--Utils.LUA_DEBUGOUT("ForeignMinister_HandlePeace")
		ForeignMinister_HandlePeace(minister)
	end

	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.DIP_WAR_DELAY) == 0 then
		if minister:GetCountry():IsAtWar() then
			--Utils.LUA_DEBUGOUT("ForeignMinister_HandleWar")
			ForeignMinister_HandleWar(minister)
		end
	end

	--Utils.LUA_DEBUGOUT("<-ForeignMinister_Tick")
end

function ForeignMinister_HandleWar( minister )
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()

	for neighborTag in ministerCountry:GetNeighbours() do

		local neigborCountry = neighborTag:GetCountry()
		for countryTag in ministerCountry:GetCurrentAtWarWith() do

			-- mutual neighbors would be nice to move through
			if neigborCountry:IsNeighbour(countryTag) then
				local relation = ai:GetRelation(ministerTag, neighborTag)

				if not relation:HasMilitaryAccess() then
					local action = CMilitaryAccessAction(ministerTag, neighborTag)

					if action:IsSelectable() then

						local acceptanceChance = action:GetAIAcceptance()
						local score = DiploScore_DemandMilitaryAccess( ai, ministerTag, neighborTag, ministerTag )

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
				--local intel = CAIIntel(ministerTag, target)
				--local theirStrength = intel:CalculateTheirPercievedMilitaryStrengh()
				-- factor in their allies that are part of war
				--for hostileAllyTag in target:GetCountry():GetAllies() do
					--if war:IsPartOfWar(hostileAllyTag) then
						--local allyIntel = CAIIntel(ministerTag, hostileAllyTag)
						--local allyStrength = allyIntel:CalculateTheirPercievedMilitaryStrengh()
						--theirStrength = theirStrength + allyStrength
					--end
				--end

				-- do we want to call in help?
				if war:GetCurrentRunningTimeInMonths() > 5 then
					--local ourStrength = intel:CalculateOurMilitaryStrength()
					--local strengthFactor = ourStrength / theirStrength
					if ministerCountry:CalcDesperation():Get() > 0.4 then
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
	local numberOfInfluences = nil

	-- scripted wars
	Utils.CallCountryAI( ministerTag, 'ProposeDeclareWar', minister )

	-- are we interested in joining a faction?
	local bestFaction = nil
	if	not ministerCountry:HasFaction() and
		not ministerCountry:isPuppet() and
		ministerCountry:GetNeutrality():Get() < 65 and
		(
			ministerCountry:GetMaxIC() > ai_configuration.MINIMUM_IC_TO_INFLUENCE or
			ministerCountry:IsAtWar()
		)
	then
		local bestScore = -1
		for faction in CCurrentGameState.GetFactions() do

			if faction:IsValid() then
				-- evaluate faction
				--local score = CalculateFactionSympathy(ai, ministerCountry, faction) * 100
				local score = DiploScore_InviteToFaction(ai, faction:GetFactionLeader(), ministerTag, ministerTag)
				score = Utils.CallScoredCountryAI(ministerTag, 'DiploScore_JoinFaction', score, minister, faction)

				if score > 50 and score > bestScore then
					bestScore = score
					bestFaction = faction
				end
			end
		end

		if bestScore > 50 then
			local action = CInfluenceAllianceLeader( ministerTag, bestFaction:GetFactionLeader() )
			if action:IsSelectable() then
				minister:Propose( action, bestScore )
			end
		end
	end

	-- break any deals?
	for alliedCountry in ministerCountry:GetAllies() do
		local score = CalculateSympathy(ministerTag, alliedCountry)

		if score < 0 or ministerCountry:HasFaction() or bestFaction ~= nil then
			local action = CAllianceAction(ministerTag, alliedCountry)
			action:SetValue(false) -- cancel
			if action:IsSelectable() then
				minister:Propose( action, score )
			end
		end
	end

	for country in CCurrentGameState.GetCountries() do
		local countryTag = country:GetCountryTag()

		if IsValidCountry(country) and
		   not (ministerCountry:HasDiplomatEnroute(countryTag)) and
		   not (countryTag == ministerTag) then

			local relation = ministerCountry:GetRelation( countryTag )

			-- war
			-- non-scripted war declaration:
			--ProposeDeclareWar( minister, ai, ministerCountry, countryTag )

			-- alliance only if we're not interested in joining a faction
			if not bestFaction and not ministerCountry:HasFaction() and ministerCountry:GetNeutrality():Get() < 70 then
				if not relation:HasAlliance() and relation:GetValue():GetTruncated() > 0 then
					local action = CAllianceAction(ministerTag, countryTag)
					if action:IsSelectable() then

						local score = DiploScore_Alliance(ai, ministerTag, countryTag, ministerTag)
						if score > 50 then
							local acceptanceChance = action:GetAIAcceptance()
							if acceptanceChance > 50 then
								minister:Propose(action, score)
							end
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
			if	ministerCountry:HasFaction() and
				ministerCountry:GetMaxIC() > ai_configuration.MINIMUM_IC_TO_INFLUENCE and
				not ministerCountry:isPuppet() -- Workaround because trading with puppets is disabled causing wrong economic score
			then

				local theirRelationToUs = country:GetRelation(ministerTag)
				if	not country:HasFaction() and
					(
						ministerCountry:IsFactionLeader() or
						IsNeighbourOnSameContinent(ministerTag, ministerCountry, countryTag, country)
					)
				then
					local action = CFactionAction(ministerTag, countryTag)
					action:SetValue(false)

					if action:IsSelectable() then
						local acceptanceChance = action:GetAIAcceptance()

						if acceptanceChance > 50 then
							local score = DiploScore_InviteToFaction( ai, ministerTag, countryTag, ministerTag )

							if score > 50 then
								minister:Propose( action, score )
							end
						end
					end

					local influenceAction = CInfluenceNation(ministerTag, countryTag)

					if theirRelationToUs:IsBeingInfluenced() then -- we're influencing them
						-- stop influencing
						influenceAction:SetValue(false)

						local score = DiploScore_InfluenceNation( ai, ministerTag, countryTag, ministerTag )

						if score < 40 then
							minister:Propose(influenceAction, 100)
						end
					else
						if not country:isPuppet() then
							if influenceAction:IsSelectable() then
								if numberOfInfluences == nil then
									numberOfInfluences = ministerCountry:CalculateNumberOfActiveInfluences()
								end

								if influence > 0 and ministerCountry:GetDiplomaticInfluence():Get() > 10 and numberOfInfluences < 3 then
									local score = DiploScore_InfluenceNation( ai, ministerTag, countryTag, ministerTag )
									if score > 50 then
										--minister:Propose( influenceAction, score )
										ai:PostAction( influenceAction )
										numberOfInfluences = numberOfInfluences + 1
									end
								end
							end
						end
					end
				else
					-- Stop influencing for save game compability
					if theirRelationToUs:IsBeingInfluenced() then
						local influenceAction = CInfluenceNation(ministerTag, countryTag)
						influenceAction:SetValue(false)
						minister:Propose(influenceAction, 100)
					end
				end
			end

			-- see if we can help out
			if not country:GetRelation(ministerTag):AllowDebts() then
				if ministerCountry:GetTotalIC() < country:GetTotalIC() then
					local action = CDebtAction(ministerTag, countryTag)
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
