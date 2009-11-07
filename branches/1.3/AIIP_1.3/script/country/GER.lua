require('helper_functions')

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

function P.DiploScore_DemandMilitaryAccess( score, ai, actor, recipient, observer )
    if tostring(recipient) == 'SWE' then -- to match the war conditions in ProposeDeclareWar
        local norTag = CCountryDataBase.GetTag('NOR')
        local actorCountry = actor:GetCountry()

        if actorCountry:GetRelation(norTag):HasWar()
        or actorCountry:GetStrategy():IsPreparingWarWith( norTag )
        then
            return 70
        end
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
	and ((not polTag:GetCountry():Exists()) or polTag:GetCountry():IsGovernmentInExile()) -- If Poland is no more a problem
	-- Check if west front is calm
	and CCurrentGameState.GetProvince( 2948 ):GetController() == gerTag		--Baden
	and CCurrentGameState.GetProvince( 2553 ):GetController() == gerTag		--Saarbrucken
	and CCurrentGameState.GetProvince( 1570 ):GetController() == gerTag		--Wilhelmshaven
	then
		--Utils.LUA_DEBUGOUT("GO for Fall Weseruebung")
		if not ministerCountry:GetRelation(denTag):HasWar()						--Not already at war with DEN
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
	and not ministerCountry:GetRelation(sweTag):HasMilitaryAccess()		--We have no military access
	and CCurrentGameState.GetProvince( 862 ):GetController() == sweTag		--SWE controls Stockholm
	and CCurrentGameState.GetProvince( 812 ):GetController() == norTag		--NOR controls Oslo
	then
		strategy:PrepareWar( sweTag, 100 )
	end

	-- FALL GELB
	if 	ministerCountry:GetRelation(fraTag):HasWar() -- If we are at war with Allies
		and ministerCountry:GetRelation(engTag):HasWar()
		and (
				not polTag:GetCountry():Exists()
			or
				polTag:GetCountry():IsGovernmentInExile()
			) -- If Poland is no more a problem
		and (
				(year > 1939 and month > 5)
			or
				(
					(
						P.IsFullyOccupying( ministerCountry, denTag ) or
						denTag:GetCountry():IsGovernmentInExile() or
						not denTag:GetCountry():Exists()
					) -- If Denmark is no more a problem
				and
					(
						P.IsFullyOccupying( ministerCountry, norTag ) or
						norTag:GetCountry():IsGovernmentInExile() or
						not norTag:GetCountry():Exists()
					) -- If Norway is no more a problem
				)
			)
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

	if ministerCountry:GetRelation(fraTag):HasWar()
	and ( ministerCountry:GetRelation(holTag):HasWar() or ministerCountry:GetRelation(belTag):HasWar() )
	then
		strategy:PrepareWar( luxTag, 100 )
	end

	local vicTag = CCountryDataBase.GetTag('VIC')
	local yugTag = CCountryDataBase.GetTag('YUG')
	local greTag = CCountryDataBase.GetTag('GRE')
	local itaTag = CCountryDataBase.GetTag('ITA')
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
	and not sovTag:GetCountry():IsSubject()								--SOV isn't a subject nation
	and CCurrentGameState.GetProvince( 1409 ):GetController() == sovTag 	--SOV controls Moskva
	then
		local AtWarWithNeighbor = false
		for neighborTag in ministerCountry:GetNeighbours() do
			if IsNeighbourOnSameContinent(minister:GetCountryTag(), ministerCountry, neighborTag, neighborTag:GetCountry()) then
				if ministerCountry:GetRelation( neighborTag ):HasWar()
				and (not P.IsFullyOccupying( ministerCountry, neighborTag ))
				then
					AtWarWithNeighbor = true
				end
			end
		end

		if not AtWarWithNeighbor then
			if ministerCountry:GetRelation(sovTag):HasNap() then
				local action = CNapAction(ministerTag, countryTag)
				action:SetValue(false)
				if action:IsSelectable() then
					ai:PostAction( action )
				end
			end

			--Utils.LUA_DEBUGOUT("GO for Barbarossa")
			strategy:PrepareWar( sovTag, 100 )
		end
	end

end


function P.PickBestMission(ai, minister, countryTag, bestMission, bestScore )
	if tostring(countryTag) == 'AUS' then
	--and (not minister:GetCountry():IsFriend(countryTag, false)) then
		bestScore = 100
		bestMission = SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY
	end
	return bestMission
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

function P.HandleMobilization( minister )
	local ai = minister:GetOwnerAI()
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local currentDate = CCurrentGameState.GetCurrentDate()

	-- If later than Juny 39 and not at war prepare for war against Poland (will be triggered by event)
	if 	not ministerCountry:IsAtWar() and
		currentDate:GetYear() == 1939 and
		currentDate:GetMonthOfYear() > 5
	then
		local command = CToggleMobilizationCommand(ministerTag, true)
		ai:Post(command)
	end
end


return AI_GER
