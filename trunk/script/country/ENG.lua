local P = {}
AI_ENG = P


function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local axisFaction = CCurrentGameState.GetFaction('axis')
	local axisLeaderTag = axisFaction:GetFactionLeader()

	local gerTag = CCountryDataBase.GetTag('GER')
	local itaTag = CCountryDataBase.GetTag('ITA')


	for country in CCurrentGameState.GetCountries() do
		local countryTag = country:GetCountryTag()
		if not country:GetFaction() == ministerCountry:GetFaction() then
			if country:Exists() and country:GetCapitalLocation():GetContinent() == ministerCountry:GetCapitalLocation():GetContinent() then
				if ministerCountry:GetRelation(countryTag):GetThreat():Get() > ministerCountry:GetMaxNeutralityForWarWith(countryTag):Get()  then
					ministerCountry:GetStrategy():PrepareWar( countryTag, 100 )
				end
			end
		end
	end



	if year > 1939
	and  ( not ministerCountry:GetRelation(axisLeaderTag):HasWar() )
	then
		ministerCountry:GetStrategy():PrepareWar( axisLeaderTag, 100 )
		return
	end


	if ( not ministerCountry:GetRelation(gerTag):HasWar() )
		and gerTag:GetCountry():GetFaction() == axisFaction
		and gerTag:GetCountry():IsAtWar()
	then
		ministerCountry:GetStrategy():PrepareWar( gerTag, 100 )
	end

	if ( not ministerCountry:GetRelation(itaTag):HasWar() )
		and itaTag:GetCountry():GetFaction() == axisFaction
		and itaTag:GetCountry():IsAtWar()
	then
		ministerCountry:GetStrategy():PrepareWar( itaTag, 100 )
	end

end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
--[[
	local ministerCountry = ai:GetCountry()
	local modifier = 50
	if score > 0 then
		modifier = 75
	end

	if CCountryDataBase.GetTag('CAN') == recipient then
		--Utils.LUA_DEBUGOUT("CAN influence from ENG - " .. tostring(score + modifier) )
		return score + modifier
	elseif CCountryDataBase.GetTag('AST') == recipient then
		--Utils.LUA_DEBUGOUT("AST influence from ENG - " .. tostring(score + modifier) )
		return score + modifier
	elseif CCountryDataBase.GetTag('NZL') == recipient then
		--Utils.LUA_DEBUGOUT("NZL influence from ENG - " .. tostring(score + modifier) )
		return score + modifier
	elseif CCountryDataBase.GetTag('SAF') == recipient then
		--Utils.LUA_DEBUGOUT("SAF influence from ENG - " .. tostring(score + modifier) )
		return score + modifier
	elseif CCountryDataBase.GetTag('USA') == recipient then
		--Utils.LUA_DEBUGOUT("USA influence from ENG - " .. tostring(score + modifier) )
		return score + modifier
	else
		return score
	end
]]
	return score
end


return AI_ENG
