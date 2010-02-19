local P = {}
AI_USA = P

function P.DiploScore_Guarantee( score, ai, actor, recipient, observer)

	local recipientCountry = recipient:GetCountry()
	if not recipientCountry:HasFaction() then
		local continent = tostring( recipientCountry:GetCapitalLocation():GetContinent():GetTag() )
		if (continent == "north_america" or continent == "south_america")
		and not (tostring(recipient) == 'CAN') then
			return 100
		end
	end
	
	return score
end

function P.ManageSpyMissionAtHome(newMission, ai, minister, ministerCountry)
	-- As long as there's no war in europe stay neutral -> Avoids early faction joining of USA
	if newMission == SpyMission.SPYMISSION_LOWER_NEUTRALITY then
		local fraTag = CCountryDataBase.GetTag('FRA')
		local engTag = CCountryDataBase.GetTag('ENG')
		local gerTag = CCountryDataBase.GetTag('GER')
		
		if not (gerTag:GetCountry():IsAtWar() or engTag:GetCountry():IsAtWar() or fraTag:GetCountry:IsAtWar()) then
			local rand = math.mod(CCurrentGameState.GetAIRand(), 4)
			-- Lower only in 25% of all cases
			if rand < 1 then
				newMission = SpyMission.SPYMISSION_LOWER_NEUTRALITY
			elseif rand < 2
				newMission = SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY
			else
				newMission = SpyMission.SPYMISSION_COUNTER_ESPIONAGE
			end
		end
	end
	return newMission
end

return AI_USA

