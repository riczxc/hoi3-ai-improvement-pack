
local P = {}
AI_SOV = P

function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()
	
	local gerTag = CCountryDataBase.GetTag('GER')
	local polTag = CCountryDataBase.GetTag('POL')
	local fraTag = CCountryDataBase.GetTag('FRA')
	local sovTag = CCountryDataBase.GetTag('SOV')
	
	if year >= 1942 and month >= 2
	and CCurrentGameState.GetProvince(1409):GetController() == sovTag	--Bitter Peace didn't happen
	and ( not polTag:GetCountry():Exists() or polTag:GetCountry():IsGovernmentInExile() ) --Poland are history
	and not ministerCountry:GetRelation(gerTag):HasWar()				--Not already at war with GER
	and not gerTag:GetCountry():IsSubject()								--GER isn't a subject nation							
	and CCurrentGameState.GetProvince( 1861 ):GetController() == gerTag	--GER controls Berlin
	then
		strategy:PrepareWar( gerTag, 100 )
	end
	
	if year >= 1941 and month >= 2
	and CCurrentGameState.GetProvince(1409):GetController() == sovTag	--Bitter Peace didn't happen
	and fraTag:GetCountry():Exists()									--FRA is still here
	and CCurrentGameState.GetProvince( 2613 ):GetController() == fraTag --FRA controls Paris
	and gerTag:GetCountry():GetRelation(fraTag):HasWar()				--GER is fighting FRA
	and not ministerCountry:GetRelation(gerTag):HasWar()				--Not already at war with GER
	and not gerTag:GetCountry():IsSubject()								--GER isn't a subject nation
	and CCurrentGameState.GetProvince( 1861 ):GetController() == gerTag	--GER controls Berlin
	then
		-- Doesn't seem to run so well for GER. Attack GER.
		strategy:PrepareWar( gerTag, 100 )
	end
	
	if year >= 1940 and month >= 3
	and CCurrentGameState.GetProvince(1409):GetController() == sovTag	--Bitter Peace didn't happen
	and polTag:GetCountry():GetFaction() == gerTag:GetCountry():GetFaction()	-- Poland is in axis
	and not ministerCountry:GetRelation(polTag):HasWar()				--Not already at war with POL
	and not polTag:GetCountry():IsSubject()								--POL isn't a subject nation							
	and CCurrentGameState.GetProvince( 1928 ):GetController() == polTag	--POL controls Warsaw
	then
		strategy:PrepareWar( polTag, 100 )
	end
	
end

function P.ForeignMinister_EvaluateDecision( score, agent, decision, scope )
	
	if decision:GetKey():GetString() == 'finnish_winter_war' then
		--local ministerCountry = agent:GetCountry()
		--local strategy = ministerCountry:GetStrategy()
		--strategy:PrepareWarDecision( CCountryDataBase.GetTag('FIN'), 100, decision )
		
		-- lets not prepare too much, we can take the fins easily
		score = 100 
	end

	return score
end

function P.ManageSpyMissionAtHome(newMission, ai, minister, ministerCountry)
	if not ministerCountry:IsAtWar() then
		local year = ai:GetCurrentDate():GetYear()
		local conscriptionLawGroup = CLawDataBase.GetLawGroup(GetLawGroupIndexByName('conscription_law'))
		local conscriptionLawIndex = ministerCountry:GetLaw(conscriptionLawGroup):GetIndex()
		local targetedConscriptionLawIndex = GetLawIndexByName('three_year_draft')
		
		if conscriptionLawIndex < targetedConscriptionLawIndex then
			if year <= 1937 or newMission ~= SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY then
				newMission = SpyMission.SPYMISSION_LOWER_NEUTRALITY
			end
		end
	end
	
	return newMission
end

function P.PickBestMission(ai, minister, countryTag, selectedSpyMission, score)
	-- As long as GER is at peace, don't increase threat of Allies.
	-- This would hurt ourselfs, because the increased threat of UK and France would
	-- push countries more to the Axis side than to our side.

	local gerTag = CCountryDataBase.GetTag('GER')

	if 	selectedSpyMission == SpyMission.SPYMISSION_INCREASE_THREAT and
		not gerTag:GetCountry():IsAtWar()
	then
		local country = countryTag:GetCountry()
		local faction = country:GetFaction()
		local alliesFaction = CCurrentGameState.GetFaction('allies')

		if faction == alliesFaction then
			local diceRoll = math.mod(CCurrentGameState.GetAIRand(), 6)
			if diceRoll == 0 then
				selectedSpyMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
			elseif diceRoll == 1 then
				selectedSpyMission = SpyMission.SPYMISSION_DISRUPT_RESEARCH
			elseif diceRoll == 2 then
				selectedSpyMission = SpyMission.SPYMISSION_DISRUPT_PRODUCTION
			elseif diceRoll == 3 then
				selectedSpyMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
			elseif diceRoll == 4 then
				selectedSpyMission = SpyMission.SPYMISSION_MILITARY
			elseif diceRoll == 5 then
				selectedSpyMission = SpyMission.SPYMISSION_TECH
			end
		end
	end

	return selectedSpyMission
end
return AI_SOV
