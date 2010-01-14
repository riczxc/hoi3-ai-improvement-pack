
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
	
	if year >= 1942 and month >= 2
	and ( not polTag:GetCountry():Exists() or polTag:GetCountry():IsGovernmentInExile() ) --Poland are history
	and not ministerCountry:GetRelation(gerTag):HasWar()				--Not already at war with GER
	and not gerTag:GetCountry():IsSubject()								--GER isn't a subject nation							
	and CCurrentGameState.GetProvince( 1861 ):GetController() == gerTag	--GER controls Berlin
	then
		strategy:PrepareWar( gerTag, 100 )
	end
	
	if year >= 1940 and month >= 3
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


return AI_SOV