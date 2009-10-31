-----------------------------------------------------------
-- manage research
-----------------------------------------------------------

require('custom_research')
require('helper_functions')

function BalanceLeadershipSliders(ai, ministerCountry)
	local PRIO_SETTINGS = {
		[0] = CDistributionSetting._LEADERSHIP_DIPLOMACY_,
			CDistributionSetting._LEADERSHIP_NCO_,
			CDistributionSetting._LEADERSHIP_ESPIONAGE_,
			CDistributionSetting._LEADERSHIP_RESEARCH_
	}

	local sum = 0
	local changes = CArrayFix(4)
	local AvailLS = 1

	-- Officer ratio. aims at 100% in peace time
	local OfficerGoal = 1
	-- Officer ratio. aims at 200% for maximum org. in war
	if ministerCountry:IsAtWar() then
		OfficerGoal = 2
	-- Officer ratio. aims at 150% in preparation of war
	elseif ministerCountry:GetStrategy():IsPreparingWar() then
		OfficerGoal = 1.5
	end
	local OfficerNeed = math.max((OfficerGoal-ministerCountry:GetOfficerRatio():Get())/OfficerGoal, 0)
	OfficerNeed = math.min(AvailLS, OfficerNeed)
	AvailLS = AvailLS - OfficerNeed
	changes:SetAt(CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint(OfficerNeed * 100))

	-- aim for 1/5 IC or at least 20 and use 1/2 of avail LS
	local DiploNeed = math.max(20, ministerCountry:GetTotalIC()/5)
	DiploNeed = 0.5 * AvailLS * math.max(0, (DiploNeed-ministerCountry:GetDiplomaticInfluence():Get())/DiploNeed)
	DiploNeed = math.min(AvailLS, DiploNeed)
	AvailLS = AvailLS - DiploNeed
	changes:SetAt(CDistributionSetting._LEADERSHIP_DIPLOMACY_, CFixedPoint(DiploNeed * 100))

	-- always go for 10%, more is useless, unless if GiE
	local EspionageNeed = math.min(0.1, AvailLS)
	if ministerCountry:IsGovernmentInExile() then
		EspionageNeed = AvailLS
	end
	EspionageNeed = math.min(AvailLS, EspionageNeed)
	AvailLS = AvailLS - EspionageNeed
	changes:SetAt(CDistributionSetting._LEADERSHIP_ESPIONAGE_, CFixedPoint(EspionageNeed * 100))

	-- remainder into research
	local totalLS = ministerCountry:GetTotalLeadership():Get()
	local researchLS = CFixedPoint(totalLS * AvailLS)
	-- LS actually spent to research
	researchLS = researchLS:GetRounded()
	local ResearchNeed = researchLS / totalLS
	ResearchNeed = math.min(AvailLS, ResearchNeed)
	AvailLS = AvailLS - ResearchNeed
	changes:SetAt(CDistributionSetting._LEADERSHIP_RESEARCH_, CFixedPoint(ResearchNeed * 100))

	-- Remainder into rest
	local totalNeed = OfficerNeed + DiploNeed + EspionageNeed
	if totalNeed > 0 then
		OfficerNeed = OfficerNeed + AvailLS * (OfficerNeed / totalNeed)
		changes:SetAt(CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint(OfficerNeed * 100))

		DiploNeed = DiploNeed + AvailLS * (DiploNeed / totalNeed)
		changes:SetAt(CDistributionSetting._LEADERSHIP_DIPLOMACY_, CFixedPoint(DiploNeed * 100))

		EspionageNeed = EspionageNeed + AvailLS * (EspionageNeed / totalNeed)
		changes:SetAt(CDistributionSetting._LEADERSHIP_ESPIONAGE_, CFixedPoint(EspionageNeed * 100))
	end

	local command = CChangeLeadershipCommand(ministerCountry:GetCountryTag(), changes)
	ai:Post(command)
end


function TechMinister_Tick(minister)
	--Utils.LUA_DEBUGOUT("TechMinister_Tick")
	local ministerCountry = minister:GetCountry()
	BalanceLeadershipSliders(minister:GetOwnerAI(), ministerCountry)

	local i = ministerCountry:GetAllowedResearchSlots() - ministerCountry:GetNumberOfCurrentResearch()

	if i > 0 then

		local techList = ProposeResearch(minister)
		i = math.min(i, table.getn(techList) )

		for j = 0, i do
			local command = CStartResearchCommand(minister:GetCountryTag(), techList[ j+1 ][2])
			minister:GetOwnerAI():Post(command)

		end
	end
	--Utils.LUA_DEBUGOUT("TechMinister_TickEnd")
end

function EvaluateCurrentResearch(minister)
	-- sort list of research if priorities changed

end

function ProposeResearch(minister)
	local sortedTechs = {}
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()

	local listmaj = {}
	local listimp = {}
	local listnorm = {}

	--Utils.LUA_DEBUGOUT( tostring(ministerTag) )
	-- Construct lists of favourite tech for the country
	listmaj, listimp, listnorm = ConstructPriorityList(minister)

	-------------------------------DEBUG------------------------------------
	--Utils.LUA_DEBUGOUT( "--------------LISTE TECH: 1--------------------" )
--	local j = 1
--	while listmaj[j] do
--		Utils.LUA_DEBUGOUT( listmaj[j] )
--		j = j + 1
--	end
--	Utils.LUA_DEBUGOUT( "--------------LISTE TECH: 2--------------------" )
--	j = 1
--	while listimp[j] do
--		Utils.LUA_DEBUGOUT( listimp[j] )
--		j = j + 1
--	end
--	Utils.LUA_DEBUGOUT( "--------------LISTE TECH: 3--------------------" )
--	j = 1
--	while listnorm[j] do
--		Utils.LUA_DEBUGOUT( listnorm[j] )
--		j = j + 1
--	end
--	Utils.LUA_DEBUGOUT( "---------------------------------------" )
	-------------------------------------------------------------------
	local score = 0

	for tech in CTechnologyDataBase.GetTechnologies() do
		if minister:CanResearch(tech) and tech:IsValid() then
			score = CalculateTechScore(minister, ministerCountry, tech, listmaj, listimp, listnorm)
			table.insert(sortedTechs, {score, tech})
		end
	end
	table.sort(sortedTechs, function(x, y) return x[1] > y[1] end) -- highest score first

--	Utils.LUA_DEBUGOUT(tostring(ministerTag) .. ".sortedTechs = {")
--	for _, debugtech in ipairs(sortedTechs) do
--		if debugtech == nil then
--			Utils.LUA_DEBUGOUT("nil in list")
--		else
--			Utils.LUA_DEBUGOUT( "(" .. tostring(debugtech[1]) .. ", (" .. tostring(debugtech[2]:GetKey()) .. ")" )
--		end

--	end
--	Utils.LUA_DEBUGOUT("}\n")

	return sortedTechs
end

function CalculateTechScore(minister, ministerCountry, tech, listmaj, listimp, listnorm)
	local nomTech = tostring(tech:GetKey())
	local techStatus = ministerCountry:GetTechnologyStatus()

	local score = 1
	local majorTechScore = 14
	local mediumTechScore = 12
	local minorTechScore = 9
	local find = 0

	--Utils.LUA_DEBUGOUT( nomTech )

	--------------------------------------------------------------
	-- lvl 1 tech check
	local i = 1
	while listmaj[i] and find == 0 do
		if listmaj[i] == nomTech then
			--Utils.LUA_DEBUGOUT( "I find it!")
			score = majorTechScore
			find = 1
		end
		i = i + 1
	end
	-- lvl 2 tech check
	i = 1
	while listimp[i] and find == 0 do
		if listimp[i] == nomTech then
			--Utils.LUA_DEBUGOUT( "I find it!")
			score = mediumTechScore
			find = 1
		end
		i = i + 1
	end
	-- lvl 3 tech check
	i = 1
	while listnorm[i] and find == 0 do
		if listnorm[i] == nomTech then
			--Utils.LUA_DEBUGOUT( "I find it!")
			score = minorTechScore
			find = 1
		end
		i = i + 1
	end
	--------------------------------------------------------------
	-- Cavalry not important lvl 3+
	if nomTech == 'cavalry_smallarms' or nomTech == 'cavalry_support'
		or nomTech == 'cavalry_guns' or nomTech == 'cavalry_at' then
		--Utils.LUA_DEBUGOUT( "Cavalry tech!!!" )
		if techStatus:GetLevel(tech) >= 3 then
			score = 0
			--Utils.LUA_DEBUGOUT( "Enough cavalry tech" )
		end
	-- All Countries need Operational Level Organisation doctrine
	elseif nomTech == 'operational_level_organisation' then
		score = majorTechScore
	-- Industrial boost when tech is low and average infrastructure is low
	-- (need lvl 3 to unlock advanced_construction_engineering to build infrastructure)
	elseif nomTech == 'industral_production' or nomTech == 'industral_efficiency' then
		if techStatus:GetLevel(tech) < 3 then
			score = score * (1 + (1 - GetAverageInfrastructure(ministerCountry)))
		end
	elseif nomTech == 'advanced_construction_engineering' then
		score = score * (1 + (1 - GetAverageInfrastructure(ministerCountry)))
	-- Air Doctrines are less important in peace time
	elseif tostring(tech:GetFolder():GetKey()) == "air_doctrine_folder" and minister:GetCountry():IsAtWar() == false then
		--Utils.LUA_DEBUGOUT( "air doctrine in peace time" )
		score = score*0.75
	elseif nomTech == 'agriculture' then
		-- Only research if low on manpower
		if ministerCountry:GetTotalIC() > 0 and (ministerCountry:GetManpower():Get() / ministerCountry:GetTotalIC()) > 2 then
			score = minorTechScore
		end
	end

	--Utils.LUA_DEBUGOUT( 'SCORE de base: ' .. score )
	--------------------------------------------------------------
	-- Give Penalty or Bonus for years concern
	local techLvl = techStatus:GetLevel(tech)
	local nYear = techStatus:GetYear(tech, techLvl + 1) - CCurrentGameState.GetCurrentDate():GetYear()
	if nYear > 2 then
		score = score / majorTechScore -- very expensive, only do it if really nothing else is there to do
	else
		score = score - nYear * score * 0.1 -- add 10% for every year the tech is in the past, sub 10% for every year in the future
	end
	--Utils.LUA_DEBUGOUT( 'SCORE après années: ' .. score )
	--------------------------------------------------------------
	-- If tech enable a new unit or if it's a one lvl tech, give a small bonus to score
	if tech:IsOneLevelOnly() or tech:GetEnableUnit() then
		score = score * 1.1
	end
	--------------------------------------------------------------
	-- Small random factor (+/-10)
	score = score * (0.9 + math.mod(CCurrentGameState.GetAIRand(), 21) /  10)
	--------------------------------------------------------------

	--Utils.LUA_DEBUGOUT( 'SCORE après hasard: ' .. score )
	return math.max(0, Utils.CallScoredCountryAI(ministerCountry:GetCountryTag(), "CalculateTechScore", score, ministerCountry, tech, listmaj, listimp, listnorm))
end
