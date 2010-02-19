
local P = {}
AI_JAP = P

function P.IsControlling(countryTagA, countryTagB)
	local countryB = countryTagB:GetCountry()
	if 	not (countryTagB:IsValid() and countryTagB:IsReal() and countryB:Exists())
		or 	countryB:IsGovernmentInExile()
		or	(
			countryB:IsSubject() and countryB:GetOverlord() == countryTagA
		)
		or 	(
			countryB:GetRelation(countryTagA):HasWar() and
			countryB:GetSurrenderLevel():Get() > 0.5
		)
	then
		return true
	end
	return false
end

function P.ProposeDeclareWar( minister )
	local ai = minister:GetOwnerAI()
	local ministerTag = minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()
	local strategy = ministerCountry:GetStrategy()
	local year = ai:GetCurrentDate():GetYear()
	local month = ai:GetCurrentDate():GetMonthOfYear()
	local axisFaction = CCurrentGameState.GetFaction('axis')
	
	local chiTag = CCountryDataBase.GetTag('CHI') -- Nationalist China
	local cgxTag = CCountryDataBase.GetTag('CGX') -- Guangxi Clique
	local chcTag = CCountryDataBase.GetTag('CHC') -- Communist China
	local csxTag = CCountryDataBase.GetTag('CSX') -- Shanxi
	local cxbTag = CCountryDataBase.GetTag('CXB') -- Xibei San Ma
	local cynTag = CCountryDataBase.GetTag('CYN') -- Yunnan
	
	-- CHINA CONQUEST
	-- Go for Shanxi first
	if 	ministerTag:GetCountry():GetRelation(chiTag):HasWar() or (					-- At war with China
			not ministerTag:GetCountry():GetRelation(csxTag):HasWar() and not (		-- or not at war with Shanxi
				csxTag:GetCountry():IsSubject() and									-- and Shanxi not a puppet of us
				csxTag:GetCountry():GetOverlord() == ministerTag
			)
		)
	then
		strategy:PrepareWar(csxTag, 100)
		dtools.debug("Preparing war against CSX.")
	end
	
	-- After Shanxi go for Communist China
	if P.IsControlling(ministerTag, csxTag) then
		strategy:PrepareWar(chcTag, 100)
		dtools.debug("Preparing war against CHC.")
	end
	
	-- After Communist China go for Nationalist China
	if P.IsControlling(ministerTag, chcTag) then
		strategy:PrepareWar(chiTag, 100)
		dtools.debug("Preparing war against CHI.")
	end
	
	-- After Nationalist China go for the rest
	if P.IsControlling(ministerTag, chiTag) then
		strategy:PrepareWar(cgxTag, 100)
		strategy:PrepareWar(cxbTag, 100)
		strategy:PrepareWar(cynTag, 100)
		dtools.debug("Preparing war against CGX, CXB and CYN.")
	end

	local gerTag = CCountryDataBase.GetTag('GER')
	local sovTag = CCountryDataBase.GetTag('SOV')
	local usaTag = CCountryDataBase.GetTag('USA')
	local engTag = CCountryDataBase.GetTag('ENG')
	local holTag = CCountryDataBase.GetTag('HOL')
	local fraTag = CCountryDataBase.GetTag('FRA')
	local phiTag = CCountryDataBase.GetTag('PHI')

	if gerTag:GetCountry():GetRelation(sovTag):HasWar()
	and not ministerCountry:GetRelation(sovTag):HasWar()
	and P.IsControlling(ministerTag, chiTag) -- China no problem anymore
	then
		local chiTag = CCountryDataBase.GetTag('CHI')
		
		-- Wait till they've sorted out our problem with China...
		if 	not (chiTag:IsValid() and chiTag:IsReal() and chiTag:GetCountry():Exists())
		or 	chiTag:GetCountry():IsGovernmentInExile()
		or	(
			chiTag:GetCountry():IsSubject() and chiTag:GetCountry():GetOverlord() == ministerTag
		)
		or 	(
			chiTag:GetCountry():GetRelation(ministerTag):HasWar() and
			chiTag:GetCountry():GetSurrenderLevel():Get() > 0.5
		)
		then
			-- check vladivostok area for sov troups
			local vladivostokArea = { [0] = 4195, 4263, 4262, 4390, 4328, 4391, 4457, 4458 }
			local troupCount = 0
			local intelCoverage = 0
			for tmpIndex, provID in pairs(vladivostokArea) do
				local province = CCurrentGameState.GetProvince( provID )

				if province:GetIntelLevel(ministerTag) >= 2 then -- >= INTEL_UNITS
					intelCoverage = intelCoverage + 1
				end

				troupCount = troupCount + province:GetNumberOfUnits()
			end

			if troupCount < 1 and intelCoverage > 7 then
				strategy:PrepareWar(sovTag, 100)
				dtools.debug("Preparing war against SOV.")
			end
		end
	end

	--PEARL HARBOR
	if (year >= 1941 and month >= 10) or year >= 1942
	and not usaTag:GetCountry():GetRelation(sovTag):HasWar()	--USA not at war with SOV
	and not (usaTag:GetCountry():GetFaction() == axisFaction)	--USA not in axis
	and not ministerCountry:GetRelation(usaTag):HasWar() 		--Not already at war with USA
	and not usaTag:GetCountry():IsSubject() 					--USA isn't a subject nation
	then
		strategy:PrepareWar( usaTag, 100 )
		dtools.debug("Preparing war against USA.")
		strategy:PrepareWar( phiTag, 100 )
		dtools.debug("Preparing war against PHI.")
	end

	--ASIA CONQUEST
	if ministerCountry:GetRelation(usaTag):HasWar()				--At war with USA
	and ( ministerCountry:HasFaction() and (ministerCountry:GetFaction() == axisFaction) )
	then
		--United Kingdom
		if not ministerCountry:GetRelation(engTag):HasWar() 		--Not already at war with ENG
		and not engTag:GetCountry():IsSubject() 					--ENG isn't a subject nation
		then
			strategy:PrepareWar( engTag, 100 )
			dtools.debug("Preparing war against ENG.")
		end
		--Netherlands
		if not ministerCountry:GetRelation(holTag):HasWar() 		--Not already at war with HOL
		and not holTag:GetCountry():IsSubject() 					--HOL isn't a subject nation
		then
			strategy:PrepareWar( holTag, 100 )
			dtools.debug("Preparing war against HOL.")
		end
		--France
		if not ministerCountry:GetRelation(fraTag):HasWar() 		--Not already at war with FRA
		and not fraTag:GetCountry():IsSubject() 					--FRA isn't a subject nation
		then
			strategy:PrepareWar( fraTag, 100 )
			dtools.debug("Preparing war against FRA.")
		end
	end

end

return AI_JAP
