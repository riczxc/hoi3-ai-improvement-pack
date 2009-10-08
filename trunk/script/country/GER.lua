
local P = {}
AI_GER = P

function P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)
	if tostring(recipient) == 'AUS' then -- we got better plans for you...
		return 0
	end
	
	return score
end

function P.DiploScore_Alliance( score, ai, actor, recipient, observer)
	if tostring(recipient) == 'AUS' then -- we got better plans for you...
		return 0
	end
	
	return score
end

function P.IsFullyOccupying( ministerCountry, targetTag )
    local NoControlled = targetTag:GetCountry():GetNumberOfControlledProvinces() == 0 
	if NoControlled then
		local capProvId = targetTag:GetCountry():GetCapital()
		local province = CCurrentGameState.GetProvince( capProvId )
		local WeHoldCapital = province:GetController() == ministerCountry:GetCountryTag()
		return WeHoldCapital
	end
	return false
end

function P.ProposeDeclareWar( minister )
	--Utils.LUA_DEBUGOUT("ENTER PROPOSE DECLARE WAR GERMANY")
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()
	
	local norTag = CCountryDataBase.GetTag('NOR')
	local denTag = CCountryDataBase.GetTag('DEN')
	local polTag = CCountryDataBase.GetTag('POL')
	local belTag = CCountryDataBase.GetTag('BEL')
	local holTag = CCountryDataBase.GetTag('HOL')
	local fraTag = CCountryDataBase.GetTag('FRA')
	local engTag = CCountryDataBase.GetTag('ENG')
	local sweTag = CCountryDataBase.GetTag('SWE')
	local luxTag = CCountryDataBase.GetTag('LUX')
	local gerTag = CCountryDataBase.GetTag('GER')
	
	if ministerCountry:GetRelation(fraTag):HasWar() -- If we are at war with Allies
	and ministerCountry:GetRelation(engTag):HasWar() 
	and not ministerCountry:GetRelation(belTag):HasWar() -- In Peace with Belgium
	and not ministerCountry:GetRelation(holTag):HasWar() -- In Peace with Netherlands
	and ((not polTag:GetCountry():Exists()) or polTag:GetCountry():IsGovernmentInExile() ) -- If Poland is no more a problem
	-- If west front is calm
	and CCurrentGameState.GetProvince( 2948 ):GetController() == gerTag		--Baden
	and CCurrentGameState.GetProvince( 2553 ):GetController() == gerTag		--Saarbrucken
	and CCurrentGameState.GetProvince( 1570 ):GetController() == gerTag		--Wilhelmshaven
	then
		--Utils.LUA_DEBUGOUT("GO for Fall Weseburung")
		if not ministerCountry:GetRelation(denTag):HasWar() and not denTag:GetCountry():IsSubject() then
			strategy:PrepareWar( denTag, 100 )
		end		
		if not ministerCountry:GetRelation(norTag):HasWar() and not norTag:GetCountry():IsSubject() then
			strategy:PrepareWar( norTag, 100 )
		end
	end
		
	--TODO: Find a way to invade Norway without declaring war on Sweden. For now it's the best solution for a successful AI
	if ministerCountry:GetRelation(norTag):HasWar() 
	and not P.IsFullyOccupying( ministerCountry, sweTag )
	and not P.IsFullyOccupying( ministerCountry, norTag )
	and not ministerCountry:GetRelation(sweTag):HasMilitaryAccess()
	then
		strategy:PrepareWar( sweTag, 100 )
	end
	
	if ministerCountry:GetRelation(fraTag):HasWar() -- If we are at war with Allies 
	and ministerCountry:GetRelation(engTag):HasWar()
	and (not polTag:GetCountry():Exists() or polTag:GetCountry():IsGovernmentInExile() ) -- If Poland is no more a problem 
	and (P.IsFullyOccupying( ministerCountry, denTag ) or denTag:GetCountry():IsGovernmentInExile() ) -- If Denmark is no more a problem
	and (not ministerCountry:GetRelation(norTag):HasWar() or P.IsFullyOccupying( ministerCountry, norTag ) 
		or norTag:GetCountry():IsGovernmentInExile() ) -- If Norway is no more a problem 
	and (not ministerCountry:GetRelation(sweTag):HasWar() or P.IsFullyOccupying( ministerCountry, sweTag ) 
		or sweTag:GetCountry():IsGovernmentInExile() ) -- If Sweden is no more a problem 
	then
		--Utils.LUA_DEBUGOUT("GO for Fall Gelb")
		if not ministerCountry:GetRelation(holTag):HasWar() and not holTag:GetCountry():IsSubject() then
			strategy:PrepareWar( holTag, 100 )
		end
		if not ministerCountry:GetRelation(belTag):HasWar() and not belTag:GetCountry():IsSubject() then
			strategy:PrepareWar( belTag, 100 )
		end
		if not ministerCountry:GetRelation(luxTag):HasWar() and not luxTag:GetCountry():IsSubject() then
			strategy:PrepareWar( luxTag, 100 )
		end
	end
	
	local sovTag = CCountryDataBase.GetTag('SOV')
	local vicTag = CCountryDataBase.GetTag('VIC')
	
	if year >= 1941 and month > 2 and CCurrentGameState.GetProvince( 2613 ):GetController() == gerTag and vicTag:GetCountry():Exists()
		and not ministerCountry:GetRelation(sovTag):HasWar() and not sovTag:GetCountry():IsSubject() then 
		--Utils.LUA_DEBUGOUT("GO for Barbarossa")
		strategy:PrepareWar( sovTag, 100 )
	end
	
end


function P.PickBestMission(ai, minister, countryTag, bestMission, bestScore )

	if tostring(countryTag) == 'AUS' then
	--and (not minister:GetCountry():IsFriend(countryTag, false)) then 
		bestScore = 100
		bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
	end

	if bestScore > 50 then
		return bestMission
	else
		return nil
	end	
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
-- If Germany didn't take Paris, it must avoid Italy to be influenced by allies faction

	-- when to work on italy.
--	if tostring(recipient) == 'ITA' 
--	then
--		if CCurrentGameState.GetProvince( 2613 ):GetController() == actor then -- paris must be ours
--			return	150
--		end
--		return 0
--	end


	return score
end


return AI_GER
