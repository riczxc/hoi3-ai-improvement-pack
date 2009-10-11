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
	AvailLS = AvailLS - EspionageNeed
	changes:SetAt(CDistributionSetting._LEADERSHIP_ESPIONAGE_, CFixedPoint(EspionageNeed * 100))

	-- remainder into research
	changes:SetAt(CDistributionSetting._LEADERSHIP_RESEARCH_, CFixedPoint(AvailLS * 100))

	local command = CChangeLeadershipCommand(ministerCountry:GetCountryTag(), changes)
	ai:Post(command)
end


function TechMinister_Tick(minister)
	--Utils.LUA_DEBUGOUT("TechMinister_Tick")
	local ministerCountry = minister:GetCountry()
	BalanceLeadershipSliders( minister:GetOwnerAI(), ministerCountry )
	local i = ministerCountry:GetAllowedResearchSlots() - ministerCountry:GetNumberOfCurrentResearch()
	if i > 0 then

		local techList = ProposeResearch(minister)
		i = math.min(i, table.getn(techList) )

		for j = 0, i do
			local command = CStartResearchCommand( minister:GetCountryTag(), techList[ j+1 ][2] )
			minister:GetOwnerAI():Post( command )

		end
	end
	--Utils.LUA_DEBUGOUT("TechMinister_TickEnd")
end

function EvaluateCurrentResearch(minister)
	-- sort list of research if priorities changed

end

function ProposeResearch(minister)
	local useCustomResearch = 1

	local sortedTechs = {}
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()

	local listmaj = {}
	local listimp = {}
	local listnorm = {}

	--Utils.LUA_DEBUGOUT( tostring(ministerTag) )
	-- Construct lists of favourite tech for the country
	if useCustomResearch > 0 then
		listmaj, listimp, listnorm = ConstructPriorityList(minister)
	end
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
		if  minister:CanResearch( tech ) and tech:IsValid() then
			if useCustomResearch > 0 then
				--Utils.LUA_DEBUGOUT( "Using AIRI" )
				score = CalculScore( minister, ministerCountry, tech, listmaj, listimp, listnorm )
			else
				--Utils.LUA_DEBUGOUT( "Not using AIRI" )
				score = CalculateTechScore( minister, ministerCountry, tech )
				score = score + math.mod( CCurrentGameState.GetAIRand(), 2) -- lets add a small random factor for variety
			end
			table.insert( sortedTechs, {score, tech} )
		end
	end
	table.sort( sortedTechs, function(x, y) return x[1] > y[1] end ) -- highest score first

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

function CalculateTechScore( minister, ministerCountry, tech )
	local techStatus = ministerCountry:GetTechnologyStatus()
	local score = 0

	--Utils.LUA_DEBUGOUT( "CalculateTechScore for " .. tostring(tech:GetKey()) .. "xxxx" )

	-- factor in how good we are at research
	local researchCount = 0
	local researchFactor = 0
	for bonus in tech:GetResearchBonus() do
		local ability = ministerCountry:GetAbility( bonus._pCategory )
		researchFactor = researchFactor + ability * bonus._vWeight:Get()
		researchCount = researchCount + 1
	end
	if researchCount > 0 then
		score = researchFactor / researchCount
	else
		score = researchFactor / 10.0
	end

	if score <= 0.001 then
		score = 1.0
	end

	local techLvl = techStatus:GetLevel(tech)
	local techCost = techStatus:GetCost( tech, techLvl + 1 ):Get() --  / 4.0

	-- extra year penalty
	local nYear = techStatus:GetYear(tech, techLvl + 1 );
	nYear = nYear - CCurrentGameState.GetCurrentDate():GetYear();
	if nYear > 2 then
		return -1000 -- never research so far ahead
	elseif nYear > 0 then
		techCost = techCost * (1 + 0.1 * nYear)
	end

	local score = -techCost	/ score

	-- note, score is negative here
	if tech:IsOneLevelOnly() then
		score = score * 0.75
	elseif tech:GetEnableUnit() then
		score = score * 0.75
	end

	local techFolder = tech:GetFolder()
	local techFolderName = tech:GetFolder():GetKey()
	local folderModifiers = minister:GetFolderModifers()

	if techFolder == "land_doctrine_folder" then
		local landModifier = folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("infantry_folder") )
		landModifier = math.max(landModifier, folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("armour_folder") ))
		score = score * 0.75 * (1.0 - landModifier)
	elseif techFolder == "naval_doctrine_folder" then
		local navalModifier = folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("capitalship_folder") )
		navalModifier = math.max(navalModifier, folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("smallship_folder") ))
		score = score * 0.75 * (1.0 - navalModifier)
		if ministerCountry:GetNumOfPorts() > 2 then
			score = score * 0.75
		end
	elseif techFolder == "air_doctrine_folder" then
		local airModifier = folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("fighter_folder") )
		airModifier = math.max(airModifier, folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("bomber_folder") ))
		score = score * 0.75 * (1.0 - airModifier)
		if ministerCountry:GetNumOfAirfields() > 2 then
			score = score * 0.75
		end
	end

	--if tostring(tech:GetKey()) == "militia_guns" then
	--	Utils.LUA_DEBUGOUT( "militia_guns " .. tostring(tech:GetKey()) .. " - " .. folderModifiers:GetAt( techFolder:GetIndex() ))
	--end

	score = score * (1.0 - folderModifiers:GetAt( techFolder:GetIndex() ))
	return Utils.CallScoredCountryAI(ministerCountry:GetCountryTag(), 'CalculateTechScore', score, ministerCountry, tech )
end


function CalculScore( minister, ministerCountry, tech, listmaj, listimp, listnorm )
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
		score = score - 2
	end

	--Utils.LUA_DEBUGOUT( 'SCORE de base: ' .. score )
	--------------------------------------------------------------
	-- Give Penalty or Bonus for years concern
	local techLvl = techStatus:GetLevel(tech)
	local nYear = techStatus:GetYear(tech, techLvl + 1 ) - CCurrentGameState.GetCurrentDate():GetYear()
	if nYear > 2 then
		score = 0.01*score -- very expensive, only do it if really nothing else is there to do
	else
		score = score - nYear*score*0.1
	end
	--Utils.LUA_DEBUGOUT( 'SCORE après années: ' .. score )
	--------------------------------------------------------------
	-- If tech enable a new unit or if it's a one lvl tech, give a small bonus to score
	if tech:IsOneLevelOnly() then
		score = score + 1
	elseif tech:GetEnableUnit() then
		score = score + 1
	end
	--------------------------------------------------------------
	-- Small random factor (+/-10)
	score = score*(0.9 + math.mod( CCurrentGameState.GetAIRand(), 21)/10)
	--------------------------------------------------------------

	--Utils.LUA_DEBUGOUT( 'SCORE après hasard: ' .. score )
	return math.max(0, Utils.CallScoredCountryAI(ministerCountry:GetCountryTag(), "CalculScore", score, ministerCountry, tech, listmaj, listimp, listnorm))
end
