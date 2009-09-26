-----------------------------------------------------------
-- espionage & intelligence
-----------------------------------------------------------

require('ai_diplomacy')

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
	
	local nPrio = 1
	if ministerCountry:IsAtWar() or ministerCountry:GetStrategy():IsPreparingWar() then
		if not (currentMission == SpyMission.SPYMISSION_COUNTER_ESPIONAGE) then
			local command = CChangeSpyMission( ministerTag, ministerTag, SpyMission.SPYMISSION_COUNTER_ESPIONAGE )
			ai:Post( command )
		end
		nPrio = nPrio + 2
	end

	nPrio = math.min( nPrio, CSpyPresence.MAX_SPY_PRIORITY )
	local oldPrio = domesticSpyPresence:GetPriority()
	if not ( oldPrio == nPrio ) then
		local command = CChangeSpyPriority( ministerTag, ministerTag, nPrio )
		ai:Post( command )
	end

end

function PickBestMission(country, minister, ministerTag, ministerCountry, ai)

	local countryTag = country:GetCountryTag()
	local bestMission = nil
	local bestScore = 0

	if ministerCountry:IsGovernmentInExile() then
		local capitalController = ministerCountry:GetCapitalLocation():GetController()
		if not ministerCountry:IsFriend( capitalController, false ) then
			-- set best straight away
			bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
		end
	else
		local dislike = 0	
		-- at war?
		if ministerCountry:GetStrategy():IsPreparingWarWith( countryTag ) or 
		   ministerCountry:GetRelation(countryTag):HasWar() then
			score = 51
			if score > bestScore then
				bestMission = SpyMission.SPYMISSION_MILITARY
				bestScore = score
			end
			
			dislike = 100
		end
		
		local rel = ministerCountry:GetRelation( countryTag )
		if rel:GetValue():Get() < -75  then
			dislike = dislike + 50
		end
		
		dislike = dislike + rel:GetThreat():Get() * CalculateAlignmentFactor( ai, ministerCountry, country )
	
		local strategy = ministerCountry:GetStrategy()
		dislike = dislike - strategy:GetFriendliness(countryTag) / 4
		dislike = dislike + strategy:GetAntagonism(countryTag) / 4

		if ministerCountry:HasFaction() and 
		   ministerCountry:GetFaction() == countryTag:GetFaction() then
			dislike = 0
		end

		if dislike > 50 then
			local score = 0.0	
			if country:IsAtWar() then	
				local surrenderScore = country:GetSurrenderLevel():Get(); 
				score = surrenderScore * 100
				
				if score > bestScore then
					bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
					bestScore = score
				end
			end
			
			score = country:GetGlobalModifier():GetValue(CModifier._MODIFIER_PARTISAN_EFFICENCY_):Get() + 30
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
			
			if bestScore < 50 then
				if math.mod( CCurrentGameState.GetAIRand(), 2) == 0 then
					bestMission = SpyMission.SPYMISSION_DISRUPT_PRODUCTION
					bestScore = 80
				else
					bestMission = SpyMission.SPYMISSION_DISRUPT_RESEARCH
					bestScore = 80
				end
			end
		elseif dislike < 40 then
			bestMission = SpyMission.SPYMISSION_NONE
			bestScore = 80
		end	
		
	end 
	
	
	if Utils.HasCountryAIFunction( ministerTag, 'PickBestMission' ) then
		return Utils.CallCountryAI( ministerTag, 'PickBestMission', ai, minister, countryTag, bestMission, bestScore )
	end
	
	if bestScore > 50 then
		return bestMission
	else
		return nil
	end
end

function ManageSpiesAbroad(minister, ministerTag, ministerCountry, ai)
	
	for country in CCurrentGameState.GetCountries() do
		local tag = country:GetCountryTag()
		if (not (tag == ministerTag)) and country:Exists() then
			
			local SpyPresence = ministerCountry:GetSpyPresence( tag )
			local nPrio = 0
			if ministerCountry:IsMajor() and country:IsMajor() then
				nPrio = nPrio + 1
			end
			
			if ministerCountry:GetActingCapitalLocation():GetContinent() == country:GetActingCapitalLocation():GetContinent() then
				nPrio = nPrio + 1
			end

			if ministerCountry:GetFaction():IsValid() and not (ministerCountry:GetFaction() == country:GetFaction()) and country:GetFaction():IsValid() then
				nPrio = nPrio + 1
			end
			
			if ministerCountry:GetRelation(tag):HasWar() then
				nPrio = nPrio + 2
			end

			nPrio = math.min( nPrio, CSpyPresence.MAX_SPY_PRIORITY )
			
			local oldPrio = SpyPresence:GetPriority()
			if not ( oldPrio == nPrio ) then
				local command = CChangeSpyPriority( ministerTag, tag, nPrio )
				ai:Post( command )
			end
			
			local mission = PickBestMission(country, minister, ministerTag, ministerCountry, ai)
			if mission and not( mission == SpyPresence:GetMission() ) then
				local missionCommand = CChangeSpyMission( ministerTag, tag, mission )
				ai:Post( missionCommand )
			end
		end
	end
	
end
