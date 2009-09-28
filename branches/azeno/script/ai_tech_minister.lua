-----------------------------------------------------------
-- manage research
-----------------------------------------------------------

function BalanceLeadershipSliders(ai, ministerCountry)
	local PRIO_SETTINGS = {
		[0] = CDistributionSetting._LEADERSHIP_DIPLOMACY_,
			CDistributionSetting._LEADERSHIP_NCO_, 
			CDistributionSetting._LEADERSHIP_ESPIONAGE_, 
			CDistributionSetting._LEADERSHIP_RESEARCH_
	}
	
	local sum = 0
	local changes = CArrayFix(4)	


	-- Officer ratio.
	if ministerCountry:GetOfficerRatio():Get() < 0.75 then
		changes:SetAt( CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint( 10 ) )
	elseif ministerCountry:GetOfficerRatio():Get() < 0.9 then
		changes:SetAt( CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint( 30 ) )
	elseif ministerCountry:GetOfficerRatio():Get() < 1.2 then
		changes:SetAt( CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint( 20 ) )
	else
		changes:SetAt( CDistributionSetting._LEADERSHIP_NCO_, CFixedPoint( 0 ) )
	end
	
	-- if we need DI, we take it.
	if ministerCountry:GetDiplomaticInfluence():Get() < 10 then
		changes:SetAt( CDistributionSetting._LEADERSHIP_DIPLOMACY_, CFixedPoint( 20 ) )
	else
		changes:SetAt( CDistributionSetting._LEADERSHIP_DIPLOMACY_, CFixedPoint( 0 ) )
	end
	
	
	
	-- always go for 10%, more is useless, unless if GiE
	if ministerCountry:IsGovernmentInExile() then
		changes:SetAt( CDistributionSetting._LEADERSHIP_ESPIONAGE_, CFixedPoint( 100 ) )
	else
		changes:SetAt( CDistributionSetting._LEADERSHIP_ESPIONAGE_, CFixedPoint(10 ) )
	end
	
	
	
	if  ministerCountry:GetTotalIC() < 6 then
		changes:SetAt( CDistributionSetting._LEADERSHIP_RESEARCH_, CFixedPoint( 0 ) )
	else
		changes:SetAt( CDistributionSetting._LEADERSHIP_RESEARCH_, CFixedPoint( 100 ) )
	end


	local factor_left = 100
	for i = 0, table.getn(PRIO_SETTINGS) do -- normalize
		local index = PRIO_SETTINGS[i]
		local factor = changes:GetAt( index ):Get()
		factor = math.min(factor, factor_left)
		factor_left = math.max(factor_left - factor, 0.0)
						
		changes:SetAt( index, CFixedPoint(factor) )
	end
	
	local command = CChangeLeadershipCommand( ministerCountry:GetCountryTag(), changes )
	ai:Post( command )
end


function TechMinister_Tick(minister)
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
end

function EvaluateCurrentResearch(minister)
	-- sort list of research if priorities changed
	
end

function ProposeResearch(minister)
	local sortedTechs = {}
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()

	for tech in CTechnologyDataBase.GetTechnologies() do
		if  minister:CanResearch( tech ) and tech:IsValid() then
			local score = CalculateTechScore( minister, ministerCountry, tech )
			score = score + math.mod( CCurrentGameState.GetAIRand(), 2) -- lets add a small random factor for variety
			table.insert( sortedTechs, {score, tech} )
		end
	end
	table.sort( sortedTechs, function(x, y) return x[1] > y[1] end ) -- highest score first	
	
	--Utils.LUA_DEBUGOUT(tostring(ministerTag) .. ".sortedTechs = {")
	--for _, debugtech in ipairs(sortedTechs) do
	--	if debugtech == nil then
	---		Utils.LUA_DEBUGOUT("nil in list")
--		else
	--		Utils.LUA_DEBUGOUT( "(" .. tostring(debugtech[1]) .. ", (" .. tostring(debugtech[2]:GetKey()) .. ")" )
	--	end

	--end
	--Utils.LUA_DEBUGOUT("}\n")
	
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

