
local P = {}
AI_FIN = P

function P.HandleMobilization( minister )
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()
	local isMobilized = ministerCountry:IsMobilized()

	-- mobilize before winter war
	local sovTag = CCountryDataBase.GetTag('SOV')
	local gerTag = CCountryDataBase.GetTag('GER')
	local estTag = CCountryDataBase.GetTag('EST')
	
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()
	local warTime = ( year >= 1940 ) or ( year == 1939 and month >= 6 )
	
	if	not isMobilized and warTime and (
			not estTag:GetCountry():Exists() or 
			estTag:GetCountry():IsGovernmentInExile()
		)
	then
		local command = CToggleMobilizationCommand(ministerTag, true)
		ai:Post(command)
		return
	end

	if 	not isMobilized 
		and warTime
		and not ministerCountry:HasFaction()
		and not ministerCountry:IsFriend(sovTag, false)
		and not ministerCountry:IsFriend(gerTag, false)
	then
		local finnishBorder = { [0] = 377, 353, 329, 286, 268, 253, 237, 210, 183 }
		local troupCount = 0
		for _, provID in pairs(finnishBorder) do
			local province = CCurrentGameState.GetProvince( provID )
			troupCount = troupCount + province:GetNumberOfUnits()
		end
				
		if troupCount > 5 then
			local command = CToggleMobilizationCommand(ministerTag, true)
			ai:Post(command)
			return
		end
	end
end

function P.ManageSpyMissionAtHome(newMission, ai, minister, ministerCountry)
	-- We want to get into Axis to be safe from SOV
	if not (CCountryDataBase.GetTag('GER'):GetCountry():GetFaction() == ministerCountry:GetFaction()) then
		if math.mod(CCurrentGameState.GetAIRand(), 2) == 0 then
			newMission = SpyMission.SPYMISSION_LOWER_NEUTRALITY
		end
	end
	return newMission
end

return AI_FIN
