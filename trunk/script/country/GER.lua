
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
	
	if ministerCountry:GetRelation(fraTag):HasWar() 
	and ministerCountry:GetRelation(engTag):HasWar() 
	and ((not polTag:GetCountry():Exists()) or polTag:GetCountry():IsGovernmentInExile() ) 
	and (not ministerCountry:GetRelation(holTag):HasWar())
	and (not ministerCountry:GetRelation(belTag):HasWar())
	then
		if not ministerCountry:GetRelation(denTag):HasWar() and not P.IsFullyOccupying( ministerCountry, denTag ) then
			strategy:PrepareWar( denTag, 100 )
		end
		
		if not ministerCountry:GetRelation(norTag):HasWar() and not P.IsFullyOccupying( ministerCountry, norTag ) then
			strategy:PrepareWar( norTag, 100 )
		end
	end
	

	if ministerCountry:GetRelation(norTag):HasWar() 
	and not P.IsFullyOccupying( ministerCountry, sweTag )
	and not P.IsFullyOccupying( ministerCountry, norTag )
	and ( (not ministerCountry:GetRelation(sweTag):HasMilitaryAccess()) or
	      ai:GetAmountTradedFrom( CGoodsPool._METAL_, sweTag, ministerCountry:GetCountryTag() ):Get() > 0.0 )
	then
		strategy:PrepareWar( sweTag, 100 )
	end
	
	if ministerCountry:GetRelation(fraTag):HasWar() 
	and ministerCountry:GetRelation(engTag):HasWar() 
	and (not polTag:GetCountry():Exists() or polTag:GetCountry():IsGovernmentInExile() ) 
	and (not ministerCountry:GetRelation(denTag):HasWar() or P.IsFullyOccupying( ministerCountry, denTag ) or denTag:GetCountry():IsGovernmentInExile() )
	then
		strategy:PrepareWar( holTag, 100 )
		strategy:PrepareWar( belTag, 100 )
		strategy:PrepareWar( luxTag, 100 )
	end
	
	local yugTag = CCountryDataBase.GetTag('YUG')
	local itaTag = CCountryDataBase.GetTag('ITA')
	local greTag = CCountryDataBase.GetTag('GRE')
	local sovTag = CCountryDataBase.GetTag('SOV')
	local gerTag = CCountryDataBase.GetTag('GER')
	local vicTag = CCountryDataBase.GetTag('VIC')
	if itaTag:GetCountry():GetFaction() == ministerCountry:GetFaction() 
	and itaTag:GetCountry():GetRelation( greTag ):HasWar()
	then
		strategy:PrepareWar( yugTag, 100 )
	end
	
	if year >= 1941 and month > 2 and CCurrentGameState.GetProvince( 2613 ):GetController() == gerTag and vicTag:GetCountry():Exists() then 
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

	-- when to work on italy.
	if tostring(recipient) == 'ITA' 
	then
		if CCurrentGameState.GetProvince( 2613 ):GetController() == actor then -- paris must be ours
			return	150
		end
		return 0
	end


	return score
end


return AI_GER
