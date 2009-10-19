-----------------------------------------------------------
-- espionage & intelligence
-----------------------------------------------------------

require('ai_diplomacy')
require('helper_functions')

function IntelligenceMinister_Tick(minister)
	if math.mod( CCurrentGameState.GetAIRand(), ai_configuration.INTELLIGENCE_DELAY) == 0 then
		local ministerTag = minister:GetCountryTag()
		local ministerCountry = minister:GetCountry()
		local ai = minister:GetOwnerAI()

		ManageSpiesAtHome(minister, ministerTag, ministerCountry, ai)
		ManageSpiesAbroad(minister, ministerTag, ministerCountry, ai)
	end
end

function ManageSpiesAtHome(minister, ministerTag, ministerCountry, ai)
	local domesticSpyPresence = ministerCountry:GetSpyPresence( ministerTag )
	local currentMission = domesticSpyPresence:GetMission()
	local newMission = currentMission

	if ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() or ministerCountry:IsGovernmentInExile() then
		-- Immediately switch to counterespionage
		newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
	else
		-- Only consider switching to a new mission if current one lasted at least a month
		local currentMonth = CCurrentGameState.GetCurrentDate():GetMonthOfYear()
		local missionMonth = domesticSpyPresence:GetLastMissionChangeDate()	:GetMonthOfYear()
		if currentMonth < missionMonth then
			currentMonth = currentMonth + 12
		end

		if currentMonth - 1 > missionMonth then
			-- Default mission type is counterespionage
			newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE

			-- Consider switching to a mission other than counterespionage with a chance of 70%
			if math.mod(CCurrentGameState.GetAIRand(), 100) < 70 then
				if ministerCountry:GetNationalUnity():Get() < 60 then
					newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY
				else
					local economicLawGroup = CLawDataBase.GetLawGroup(GetLawGroupIndexByName('economic_law'))
					local economicLawIndex = ministerCountry:GetLaw(economicLawGroup):GetIndex()
					local targetedEconomicLawIndex = GetLawIndexByName('war_economy')

					if economicLawIndex < targetedEconomicLawIndex then
						newMission = SpyMission.SPYMISSION_LOWER_NEUTRALITY
					end
				end
			end
		end
	end

	if newMission ~= currentMission then
		local command = CChangeSpyMission(ministerTag, ministerTag, newMission)
		ai:Post(command)
	end

	-- Always go for max priority
	if domesticSpyPresence:GetPriority() < CSpyPresence.MAX_SPY_PRIORITY then
		command = CChangeSpyPriority(ministerTag, ministerTag, CSpyPresence.MAX_SPY_PRIORITY)
		ai:Post(command)
	end

end

function PickBestMission(country, minister, ministerTag, ministerCountry, ai)
	local countryTag = country:GetCountryTag()
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." PickBestMission for "..tostring(countryTag) )
	local dislike = 0

	-- We are in the same faction. Nothing to be done.
	if country:HasFaction() and ministerCountry:HasFaction() and ministerCountry:GetFaction() == country:GetFaction()  then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." in same faction -> SPYMISSION_NONE" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_NONE, 100)
	end

	-- We are in exile and the country is a enemy controller? Lower their unity to hurt them and maybe force a revolt.
	if ministerCountry:IsGovernmentInExile() then
		local capitalController = ministerCountry:GetCapitalLocation():GetController()
		if not ministerCountry:IsFriend( capitalController, false ) and country==capitalController then
			--Utils.LUA_DEBUGOUT( tostring(ministerTag).." in exile and occupied by "..tostring(countryTag).." -> SPYMISSION_LOWER_NATIONAL_UNITY" )
			return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY, 100)
		end
	end

	-- We are at war with each other?
	if ministerCountry:GetStrategy():IsPreparingWarWith( countryTag ) or
	   ministerCountry:GetRelation(countryTag):HasWar()
	then
		-- If they are weak try and push them over the edge.
		if country:GetSurrenderLevel():Get() > 0.5 then
			--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." at war -> SPYMISSION_LOWER_NATIONAL_UNITY" )
			return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY, 100)
		end
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." at war -> SPYMISSION_MILITARY" )
		-- Support our military!
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_MILITARY, 100)
	end

	local rel = ministerCountry:GetRelation( countryTag )
	local strategy = ministerCountry:GetStrategy()

	if rel:GetValue():Get() < 0  then
		-- 0 to 50
		dislike = -1*rel:GetValue():Get()/4
	end

	dislike = dislike + rel:GetThreat():Get() * CalculateAlignmentFactor( ai, ministerCountry, country )
	dislike = dislike - strategy:GetFriendliness(countryTag) / 4
	dislike = dislike + strategy:GetAntagonism(countryTag) / 4
	-- We don't like them?
	if dislike > 50 then
		local bestMission = nil
		local bestScore = 40
		local score = 0

		score = country:GetGlobalModifier():GetValue(CModifier._MODIFIER_PARTISAN_EFFICENCY_):Get()+30
		if score > bestScore then
			bestMission = SpyMission.SPYMISSION_SUPPORT_RESISTANCE
			bestScore = score
		end

		-- are they about to have a coup we want part in?
		if country:GetDissent():Get() > 5 then
			local ideology = country:GetRulingIdeology()
			local ministerIdeology = ministerCountry:GetRulingIdeology()
			if not (ideology:GetGroup() == ministerIdeology:GetGroup()) then
				local popularity = country:AccessIdeologyPopularity():GetValue( ideology ):Get()
				local organization = country:AccessIdeologyOrganization():GetValue( ideology ):Get()
				if popularity < 75 and organization < 75 then
					local nationalUnity = country:GetNationalUnity():Get()
					if nationalUnity >= 80 and nationalUnity < 90 then
						local score = 50 + (10 - (nationalUnity - 80)) * 3
						if score > bestScore then
							bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
							bestScore = score
						end
					end
					if ministerCountry:AccessIdeologyPopularity():GetValue( ministerIdeology ):Get() > 35 then
						local score = 50 + (80 - popularity)
						if score > bestScore then
							bestMission = SpyMission.SPYMISSION_BOOST_OUR_PARTY
							bestScore = score
						end
					end
				end
			end
		end
		-- didn't find anything good
		if nil == bestMission then
			if math.mod( CCurrentGameState.GetAIRand(), 2) == 0 then
				bestMission = SpyMission.SPYMISSION_DISRUPT_PRODUCTION
			else
				bestMission = SpyMission.SPYMISSION_DISRUPT_RESEARCH
			end
		end
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, bestMission, bestScore )
	end

	-- we are in different factions...increase their threat to weaken their faction's attraction and make it easier for them to be attacked
	if country:HasFaction() and ministerCountry:HasFaction() and ministerCountry:GetFaction() ~= country:GetFaction() then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." and "..tostring(countryTag).." in different factions -> SPYMISSION_INCREASE_THREAT" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_INCREASE_THREAT, 50 )
	end
	-- We are in a faction but they are not. Boost our party to help them aligning with us.
	if not country:HasFaction() and ministerCountry:HasFaction() then
		--Utils.LUA_DEBUGOUT( tostring(ministerTag).." mission for "..tostring(countryTag).." is SPYMISSION_BOOST_OUR_PARTY" )
		return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_BOOST_OUR_PARTY, 50 )
	end
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." NO mission for "..tostring(countryTag).." -> SPYMISSION_NONE" )
	-- nothing to be done
	return PickBestMissionCallback( ministerTag, ai, minister, countryTag, SpyMission.SPYMISSION_NONE, 0 )
end

function PickBestMissionCallback( ministerTag, ai, minister, countryTag, SelectedSpyMission, score )
	if Utils.HasCountryAIFunction( ministerTag, 'PickBestMission' ) then
		--Utils.LUA_DEBUGOUT( "-------------- "..tostring(ministerTag).." modified mission "..tostring(countryTag).." ---- " )
		return Utils.CallCountryAI( ministerTag, 'PickBestMission', ai, minister, countryTag, SelectedSpyMission, score )
	else
		return SelectedSpyMission
	end
end

function ManageSpiesAbroad(minister, ministerTag, ministerCountry, ai)
	--Utils.LUA_DEBUGOUT( tostring(ministerTag).." ManageSpiesAbroad ")
	local strategy = ministerCountry:GetStrategy()

	for country in CCurrentGameState.GetCountries() do
		local tag = country:GetCountryTag()

		if tag ~= ministerTag then
			local SpyPresence = ministerCountry:GetSpyPresence(tag)
			local nPrio = 0
			local mission = SpyMission.SPYMISSION_NONE

			if IsValidCountry(country) and not (ministerCountry:GetFaction():IsValid() and ministerCountry:GetFaction() == country:GetFaction()) then
				if ministerCountry:IsMajor() and country:IsMajor() then
					nPrio = nPrio + 1
				end

				if ministerCountry:IsNeighbour(tag) then
					nPrio = nPrio + 1
					if country:IsMajor() then
						nPrio = nPrio + 1
					end
				end

				if ministerCountry:GetFaction():IsValid() and country:GetFaction():IsValid() and ministerCountry:GetFaction() ~= country:GetFaction() then
					nPrio = nPrio + 1
				end

				if ministerCountry:GetRelation(tag):HasWar() or strategy:IsPreparingWarWith(tag) then
					nPrio = nPrio + 2
				end

				nPrio = math.min( nPrio, CSpyPresence.MAX_SPY_PRIORITY )

				if nPrio > 0 then
					mission = PickBestMission(country, minister, ministerTag, ministerCountry, ai)
				end
			end

			if nPrio ~= SpyPresence:GetPriority() then
				local command = CChangeSpyPriority(ministerTag, tag, nPrio)
				ai:Post(command)
			end

			if mission ~= SpyPresence:GetMission() then
				local missionCommand = CChangeSpyMission( ministerTag, tag, mission )
				ai:Post(missionCommand)
			end
		end
	end
end
