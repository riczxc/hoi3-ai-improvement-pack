
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
	
	--PEARL HARBOR
	if year >= 1941 and month >= 10
	and (not usaTag:GetCountry():GetRelation(sovTag):HasWar())	--USA not at war with SOV
	and (not usaTag:GetCountry():GetFaction() == axisFaction)	--USA not in axis
	and not ministerCountry:GetRelation(usaTag):HasWar() 		--Not already at war with USA 
	and not usaTag:GetCountry():IsSubject() 					--USA isn't a subject nation
	then
		strategy:PrepareWar( usaTag, 100 )
		strategy:PrepareWar( phiTag, 100 )
	end
	
	--ASIA CONQUEST
	if ministerCountry:GetRelation(usaTag):HasWar()	then		--At war with USA
		--United Kingdom
		if not ministerCountry:GetRelation(engTag):HasWar() 		--Not already at war with ENG 
		and not engTag:GetCountry():IsSubject() 					--ENG isn't a subject nation
		then
			strategy:PrepareWar( engTag, 100 )
		end
		--Netherlands
		if not ministerCountry:GetRelation(holTag):HasWar() 		--Not already at war with HOL 
		and not holTag:GetCountry():IsSubject() 					--HOL isn't a subject nation
		then
			strategy:PrepareWar( holTag, 100 )
		end
		--France
		if not ministerCountry:GetRelation(fraTag):HasWar() 		--Not already at war with FRA 
		and not fraTag:GetCountry():IsSubject() 					--FRA isn't a subject nation
		then
			strategy:PrepareWar( fraTag, 100 )
		end		
	end	
		
end


return AI_JAP
