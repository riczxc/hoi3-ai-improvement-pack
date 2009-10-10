
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
	
	-- FALL WESEBURUNG
	if ministerCountry:GetRelation(fraTag):HasWar() -- If we are at war with Allies
	and ministerCountry:GetRelation(engTag):HasWar() 
	and not ministerCountry:GetRelation(belTag):HasWar() -- In Peace with Belgium
	and not ministerCountry:GetRelation(holTag):HasWar() -- In Peace with Netherlands
	and ((not polTag:GetCountry():Exists()) or polTag:GetCountry():IsGovernmentInExile() ) -- If Poland is no more a problem
	-- Check if west front is calm
	and CCurrentGameState.GetProvince( 2948 ):GetController() == gerTag		--Baden
	and CCurrentGameState.GetProvince( 2553 ):GetController() == gerTag		--Saarbrucken
	and CCurrentGameState.GetProvince( 1570 ):GetController() == gerTag		--Wilhelmshaven
	then
		--Utils.LUA_DEBUGOUT("GO for Fall Weseburung")
		if not ministerCountry:GetRelation(denTag):HasWar() 					--Not already at war with DEN 
		and not denTag:GetCountry():IsSubject() 								--DEN isn't a subject nation
		and CCurrentGameState.GetProvince( 1482 ):GetController() == denTag 	--DEN controls Copenhagen
		then
			strategy:PrepareWar( denTag, 100 )
		end		
		if not ministerCountry:GetRelation(norTag):HasWar() 					--Not already at war with NOR  
		and not norTag:GetCountry():IsSubject() 								--NOR isn't a subject nation 
		and CCurrentGameState.GetProvince( 812 ):GetController() == norTag 		--NOR controls Oslo
		then
			strategy:PrepareWar( norTag, 100 )
		end
	end
		
	--TODO: Find a way to invade Norway without declaring war on Sweden. For now it's the best solution for a successful AI
	if ministerCountry:GetRelation(norTag):HasWar() 						--At war with Norway
	and not ministerCountry:GetRelation(sweTag):HasMilitaryAccess()			--We have no military access
	and CCurrentGameState.GetProvince( 862 ):GetController() == sweTag		--SWE controls Stockholm
	and CCurrentGameState.GetProvince( 812 ):GetController() == norTag		--NOR controls Oslo
	then
		strategy:PrepareWar( sweTag, 100 )
	end
	
	-- FALL GELB
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
		if not ministerCountry:GetRelation(holTag):HasWar()						--Not already at war with HOL 
		and not holTag:GetCountry():IsSubject() 								--HOL isn't a subject nation
		and CCurrentGameState.GetProvince( 1910 ):GetController() == holTag 	--HOL controls Amsterdam
		then
			strategy:PrepareWar( holTag, 100 )
		end
		if not ministerCountry:GetRelation(belTag):HasWar() 					--Not already at war with BEL 
		and not belTag:GetCountry():IsSubject() 								--BEL isn't a subject nation
		and CCurrentGameState.GetProvince( 2311 ):GetController() == belTag 	--BEL controls Bruxelles
		then
			strategy:PrepareWar( belTag, 100 )
		end
		if not ministerCountry:GetRelation(luxTag):HasWar() 					--Not already at war with LUX 
		and not luxTag:GetCountry():IsSubject() 								--LUX isn't a subject nation
		and CCurrentGameState.GetProvince( 2429 ):GetController() == luxTag 	--LUX controls Luxembourg
		then
			strategy:PrepareWar( luxTag, 100 )
		end
	end
	
	local vicTag = CCountryDataBase.GetTag('VIC')
	local vicTag = CCountryDataBase.GetTag('YUG')
	local vicTag = CCountryDataBase.GetTag('GRE')
	local vicTag = CCountryDataBase.GetTag('ITA')
	local sovTag = CCountryDataBase.GetTag('SOV')
	
	--YUGOSLAVIA CONQUEST
	if itaTag:GetCountry():GetFaction() == ministerCountry:GetFaction() --ITA is in axis
	and not ministerCountry:GetRelation(sovTag):HasWar()				--Not at war with SOV
	and not ministerCountry:GetRelation(yugTag):HasWar()				--Not already at war with YUG
	and not yugTag:GetCountry():IsSubject() 							--YUG isn't a subject nation		
	and CCurrentGameState.GetProvince( 3912 ):GetController() == yugTag	--YUG controls Belgrade
	and vicTag:GetCountry():Exists()									--VIC exists
	then
		strategy:PrepareWar( yugTag, 100 )
	end	
		
	-- BARBAROSSA
	if year >= 1941 and month > 2 
	and CCurrentGameState.GetProvince( 2613 ):GetController() == gerTag 	--Controls Paris
	and vicTag:GetCountry():Exists()										--Vichy exists
	and not ministerCountry:GetRelation(sovTag):HasWar() 					--Not already at war with SOV
	and not sovTag:GetCountry():IsSubject() 								--SOV isn't a subject nation
	and CCurrentGameState.GetProvince( 1409 ):GetController() == sovTag 	--SOV controls Moskva
	then 
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
