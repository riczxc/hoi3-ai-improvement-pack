
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
	
	if year >= 1942 and month >= 3
	and ( not polTag:GetCountry():Exists() or polTag:GetCountry():IsGovernmentInExile() ) 
	and not ministerCountry:GetRelation(gerTag):HasWar()
	then
		strategy:PrepareWar( gerTag, 100 )
	end
	
	if year >= 1940 and month >= 3
	and polTag:GetCountry():GetFaction() == gerTag:GetCountry():GetFaction()
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
