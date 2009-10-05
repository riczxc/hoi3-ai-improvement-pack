
local P = {}
AI_ITA = P

function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local gerTag = CCountryDataBase.GetTag('GER')
	local fraTag = CCountryDataBase.GetTag('FRA')
	local greTag = CCountryDataBase.GetTag('GRE')
	local vicTag = CCountryDataBase.GetTag('VIC')
	local yugTag = CCountryDataBase.GetTag('YUG')
	
	if ministerCountry:GetFaction() == gerTag:GetCountry():GetFaction()
	and ( not ministerCountry:GetRelation(greTag):HasWar() )
	and vicTag:GetCountry():Exists()
	then
		strategy:PrepareWar( greTag, 100 )
		strategy:PrepareWar( yugTag, 100 )
	end
end

function P.ForeignMinister_EvaluateDecision( score, agent, decision, scope )

	if decision:GetKey():GetString() == 'annexation_of_albania' then
		local ministerCountry = agent:GetCountry()
		local strategy = ministerCountry:GetStrategy()
		strategy:PrepareWarDecision( CCountryDataBase.GetTag('ALB'), 100, decision )
		score = 0 -- ai will select decision when we are ready for war
	end

	return score
end


return AI_ITA
