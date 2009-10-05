local P = {}
AI_SWE = P

function P.ForeignMinister_EvaluateDecision( score, agent, decision, scope )
	
	if decision:GetKey():GetString() == 'finnish_winter_war_swedish_intervention' then
		score = 100 	-- lets help
	elseif decision:GetKey():GetString() == 'finnish_winter_war_swedish_direct_intervention' then
		score = 0 -- but not too much
	end

	return score
end

return AI_SWE

