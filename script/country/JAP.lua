
local P = {}
AI_JAP = P

function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()
	local axisFaction = CCurrentGameState.GetFaction('axis')

	local gerTag = CCountryDataBase.GetTag('GER')
	local sovTag = CCountryDataBase.GetTag('SOV')
	local usaTag = CCountryDataBase.GetTag('USA')
	local engTag = CCountryDataBase.GetTag('ENG')
	local holTag = CCountryDataBase.GetTag('HOL')
	local fraTag = CCountryDataBase.GetTag('FRA')
	
	if gerTag:GetCountry():GetRelation(sovTag):HasWar() then
		-- check vladivostok area for sov troups
		local vladivostokArea = { [0] = 4195, 4263, 4262, 4390, 4328, 4391, 4457, 4458 }
		local troupCount = 0
		local intelCoverage = 0
		for tmpIndex, provID in pairs(vladivostokArea) do
			local province = CCurrentGameState.GetProvince( provID )
			
			if province:GetIntelLevel(ministerTag) >= 2 then -- >= INTEL_UNITS
				intelCoverage = intelCoverage + 1
			end
			
			for unit in province:GetUnits() do 
				troupCount = troupCount + 1
			end
		end
		
		if troupCount < 1 and intelCoverage > 7 then
			strategy:PrepareWar( sovTag, 100 )
		end
	end
	
	if year >= 1941 and month >= 10
	and (not usaTag:GetCountry():GetRelation(sovTag):HasWar())
	and ( not usaTag:GetCountry():GetFaction() == axisFaction )
	then
		strategy:PrepareWar( usaTag, 100 )
	end
	
	if year >= 1941 and month >= 11
	and (ministerCountry:GetRelation(usaTag):HasWar())
	then
		strategy:PrepareWar( engTag, 100 )
		strategy:PrepareWar( holTag, 100 )
		strategy:PrepareWar( fraTag, 100 )
	end
		
end


return AI_JAP
