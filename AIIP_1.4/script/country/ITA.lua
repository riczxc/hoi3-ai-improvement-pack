
local P = {}
AI_ITA = P

function P.ProposeDeclareWar( minister )
	-- Utils.LUA_DEBUGOUT("ENTER PROPOSE DECLARE WAR ITALY")
	
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()

	local gerTag = CCountryDataBase.GetTag('GER')
	local greTag = CCountryDataBase.GetTag('GRE')
	local vicTag = CCountryDataBase.GetTag('VIC')
	local yugTag = CCountryDataBase.GetTag('YUG')

	-- ATTACK ON GREECE
	if ministerCountry:GetFaction() == gerTag:GetCountry():GetFaction()	--Italy is in Axis
	and vicTag:IsValid() and vicTag:IsReal() and vicTag:GetCountry():Exists() --VIC exists
	then
		if not ministerCountry:GetRelation(greTag):HasWar() 				--Not already at war with GRE
		and not greTag:GetCountry():IsSubject()								--GRE isn't a subject nation
		and CCurrentGameState.GetProvince( 7414 ):GetController() == greTag	--GRE controls Athens
		then
			-- Utils.LUA_DEBUGOUT("Go for Greece")
			strategy:PrepareWar( greTag, 100 )
		end
		if not ministerCountry:GetRelation(yugTag):HasWar() 				--Not already at war with YUG
		and not yugTag:GetCountry():IsSubject()								--YUG isn't a subject nation
		and CCurrentGameState.GetProvince( 3912 ):GetController() == yugTag	--YUG controls Athens
		then
			-- Utils.LUA_DEBUGOUT("Go for Yugoslavia")
			strategy:PrepareWar( yugTag, 100 )
		end
	end
	
	-- Utils.LUA_DEBUGOUT("EXIT PROPOSE DECLARE WAR ITALY")
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
