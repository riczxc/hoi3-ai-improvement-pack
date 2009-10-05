
local P = {}
AI_FIN = P



function P.HandleMobilization( minister )
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local ai = minister:GetOwnerAI()

	-- mobilize before winter war
	local sovTag = CCountryDataBase.GetTag('SOV')
	local estTag = CCountryDataBase.GetTag('EST')
	
	if (not sovTag:GetCountry():IsAtWar())
	and ((not estTag:GetCountry():Exists()) or estTag:GetCountry():IsGovernmentInExile())	     
	then
		local command = CToggleMobilizationCommand( ministerTag, true )
		ai:Post( command )
		return
	end
	
	-- general check of neighbors
	for neighborCountry in ministerCountry:GetNeighbours() do
		local threat = ministerCountry:GetRelation(neighborCountry):GetThreat():Get()
		if  threat > 30 then 
			--Utils.LUA_DEBUGOUT( "MOBILIZE " .. tostring(ministerTag) .. " " .. tostring(threat) .. "towards" .. tostring(neighborCountry) )
			local warDesirability = CalculateWarDesirability( ai, neighborCountry:GetCountry(), ministerTag )
			if warDesirability > 70 then
				local command = CToggleMobilizationCommand( ministerTag, true )
				ai:Post( command )
				return
			end
		end
	end
	
end

return AI_FIN
