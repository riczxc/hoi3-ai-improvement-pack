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

	local threat = ministerCountry:GetRelation(ministerCountry:GetHighestThreat()):GetThreat():Get()
	-- Officer ratio. aims at 100% - 125% in peace time
	local OfficerGoal = 1 + math.min(threat / 100, 0.25)

	local lawGroup = CLawDataBase.GetLawGroup(GetLawGroupIndexByName('conscription_law'))
	local lawIndex = ministerCountry:GetLaw(lawGroup):GetIndex()
	local targetedLawIndex = GetLawIndexByName('two_year_draft')
	-- As long as we don't have appropriate conscription laws don't aim too high.
	if lawIndex < targetedLawIndex then
		OfficerGoal = math.max(1.0, -0.15 * (targetedLawIndex - lawIndex) + OfficerGoal)
	end
	-- Officer ratio. aims at 200% for maximum org. in war
	if ministerCountry:IsAtWar() then
		OfficerGoal = 2
	-- Officer ratio. aims at 150% in preparation of war
	elseif ministerCountry:GetStrategy():IsPreparingWar() or ministerCountry:IsMobilized() then
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
	--Utils.LUA_DEBUGOUT("->TechMinister_Tick " .. tostring(minister:GetCountryTag()))
	local ministerCountry = minister:GetCountry()
	BalanceLeadershipSliders(minister:GetOwnerAI(), ministerCountry)

	local i = ministerCountry:GetAllowedResearchSlots() - ministerCountry:GetNumberOfCurrentResearch()

	if i > 0 then
		local techList = ProposeResearch(minister)
		local ai = minister:GetOwnerAI()

		i = math.min(i, table.getn(techList))
		for j = 1, i do
			local command = CStartResearchCommand(minister:GetCountryTag(), techList[j][2])
			ai:Post(command)
		end
	end
	--Utils.LUA_DEBUGOUT("<-TechMinister_Tick")
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

	-------------------------------DEBUG------------------------------------
	-- if ministerCountry:GetMaxIC() > 60 then
		-- local techFolder = {}
		
		-- local techModifiers = minister:GetTechModifers()
		-- local folderModifiers = minister:GetFolderModifers()
		
		-- Utils.LUA_DEBUGOUT(tostring(ministerTag) .. " tech folder modifiers:")
		-- for tech in CTechnologyDataBase.GetTechnologies() do
			-- if minister:CanResearch(tech) and tech:IsValid() then
				-- local folder = tech:GetFolder()
				-- local folderIndex = folder:GetIndex()
				-- if not techFolder[folderIndex] then
					-- techFolder[folderIndex] = { 
						-- name = tostring(folder:GetKey()),
						-- modifier = folderModifiers:GetAt(folderIndex),
						-- folder = tech:GetFolder(),
						-- techs = {} 
					-- }
				-- end

				-- table.insert(techFolder[folderIndex].techs, tech)
			-- end
		-- end
		
		-- local folderSum = 0
		-- for _,folderEntry in pairs(techFolder) do
			-- local s = ""
			-- for i = 0, math.ceil(folderEntry.modifier * 100) do
				-- s = s .. "#"
			-- end
			
			-- Utils.LUA_DEBUGOUT(s .. " (" .. folderEntry.name .. ")")
			
			-- local sum = 0
			-- for _,tech in pairs(folderEntry.techs) do
				-- sum = sum + techModifiers:GetAt(tech:GetIndex())
			-- end
			
			-- folderSum = folderSum + folderEntry.modifier
		-- end
		-- Utils.LUA_DEBUGOUT("Sum folder modifiers: " .. folderSum)
		-- Utils.LUA_DEBUGOUT("\n")

		-- Utils.LUA_DEBUGOUT(tostring(ministerTag) .. ".sortedTechs = {")
		-- local i = 0
		-- for _, debugtech in ipairs(sortedTechs) do
			-- Utils.LUA_DEBUGOUT( "(" .. tostring(debugtech[1]) .. ", (" .. tostring(debugtech[2]:GetKey()) .. ")" )
			-- i = i + 1
			-- if i > 10 then
				-- break
			-- end
		-- end
		-- Utils.LUA_DEBUGOUT("}\n")
	-- end
	-------------------------------------------------------------------

	return sortedTechs
end

function CalculateTechScore(minister, ministerCountry, tech, listmaj, listimp, listnorm)
	local ministerTag = ministerCountry:GetCountryTag()
	local nomTech = tostring(tech:GetKey())
	local techStatus = ministerCountry:GetTechnologyStatus()

	local score = 1
	local majorTechScore = 4
	local mediumTechScore = 3
	local minorTechScore = 2
	local find = 0

	--Utils.LUA_DEBUGOUT(nomTech)

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
	elseif tostring(tech:GetFolder():GetKey()) == "air_doctrine_folder" and ministerCountry:IsAtWar() == false then
		--Utils.LUA_DEBUGOUT( "air doctrine in peace time" )
		score = score*0.75
	elseif nomTech == 'agriculture' then
		-- Only research if low on manpower
		if ministerCountry:GetTotalIC() > 0 and (ministerCountry:GetManpower():Get() / ministerCountry:GetTotalIC()) > 2 then
			score = minorTechScore
		end
	elseif nomTech == 'coal_processing_technologies' then
		if ExistsImport(ministerTag, CGoodsPool._ENERGY_) or GetAverageBalance(ministerCountry, CGoodsPool._ENERGY_) < 0 then
			score = majorTechScore
		else
			-- Does our faction need this resource?
			if ministerCountry:HasFaction() then
				if GetFactionBalance(ministerCountry:GetFaction(), CGoodsPool._ENERGY_) < 0 then
					score = majorTechScore
				end
			end
		end
	elseif nomTech == 'steel_production' then
		if ExistsImport(ministerTag, CGoodsPool._METAL_) or GetAverageBalance(ministerCountry, CGoodsPool._METAL_) < 0 then
			score = majorTechScore
		else
			-- Does our faction need this resource?
			if ministerCountry:HasFaction() then
				if GetFactionBalance(ministerCountry:GetFaction(), CGoodsPool._METAL_) < 0 then
					score = majorTechScore
				end
			end
		end
	elseif nomTech == 'raremetal_refinning_techniques' then
		if ExistsImport(ministerTag, CGoodsPool._RARE_MATERIALS_) or GetAverageBalance(ministerCountry, CGoodsPool._RARE_MATERIALS_) < 0 then
			score = majorTechScore
		else
			-- Does our faction need this resource?
			if ministerCountry:HasFaction() then
				if GetFactionBalance(ministerCountry:GetFaction(), CGoodsPool._RARE_MATERIALS_) < 0 then
					score = majorTechScore
				end
			end
		end
	elseif nomTech == 'oil_to_coal_conversion' then
		-- Amount of oil a country converts is fixed, but the amount of energy used for the
		-- conversion can be adjusted with this tech. So we have to look at our energy
		-- household in order to decide if we want to research this tech.
		if ExistsImport(ministerTag, CGoodsPool._ENERGY_) or GetAverageBalance(ministerCountry, CGoodsPool._ENERGY_) < 0 then
			score = majorTechScore
		else
			-- Does our faction need this resource?
			if ministerCountry:HasFaction() then
				if GetFactionBalance(ministerCountry:GetFaction(), CGoodsPool._ENERGY_) < 0 then
					score = majorTechScore
				end
			end
		end
	elseif nomTech == 'oil_refinning' then
		if ExistsImport(ministerTag, CGoodsPool._FUEL_) or GetAverageBalance(ministerCountry, CGoodsPool._FUEL_) < 0 then
			score = majorTechScore
		else
			-- Does our faction need this resource?
			if ministerCountry:HasFaction() then
				if GetFactionBalance(ministerCountry:GetFaction(), CGoodsPool._FUEL_) < 0 then
					score = majorTechScore
				end
			end
		end
	end

	--Utils.LUA_DEBUGOUT( 'SCORE de base: ' .. score )
	--------------------------------------------------------------
	-- Give Penalty or Bonus for years concern
	local techLvl = techStatus:GetLevel(tech)
	local nYear = techStatus:GetYear(tech, techLvl + 1) - CCurrentGameState.GetCurrentDate():GetYear()
	score = score - math.max(nYear * 1.5, -1) -- a major tech 2 years in the future will get worser than a minor tech.
	--Utils.LUA_DEBUGOUT( 'SCORE après années: ' .. score )
	--------------------------------------------------------------
	-- Give bonus based on our ability (-50% - +40%)
	local researchBonus = 0
	for bonus in tech:GetResearchBonus() do
		local ability = ministerCountry:GetAbility(bonus._pCategory)
		if ability < 5 then
			researchBonus = researchBonus - (5 - ability) * 0.1 * bonus._vWeight:Get()
		elseif ability < 20 then
			researchBonus = researchBonus + math.sqrt(ability - 5) * 0.1 * bonus._vWeight:Get()
		else
			researchBonus = researchBonus + 0.4 * bonus._vWeight:Get()
		end
	end
	--------------------------------------------------------------
	-- If tech enable a new unit or if it's a one lvl tech, give a small bonus to score
	local oneLvlBonus = 0
	if tech:IsOneLevelOnly() or tech:GetEnableUnit() then
		oneLvlBonus = 0.1
	end
	--------------------------------------------------------------
	-- Small random factor (+/-5)
	local randomBonus = (math.mod(CCurrentGameState.GetAIRand(), 11) - 5) /  100
	--------------------------------------------------------------
	score = score * (1 + researchBonus + oneLvlBonus + randomBonus)
	--------------------------------------------------------------
	--Utils.LUA_DEBUGOUT( 'SCORE après hasard: ' .. score )
	return math.max(0, Utils.CallScoredCountryAI(ministerTag, "CalculateTechScore", score, ministerCountry, tech, listmaj, listimp, listnorm))
end
