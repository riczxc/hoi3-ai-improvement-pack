-----------------------------------------------------------
-- LUA Hearts of Iron 3 Political File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 6/11/2010
-----------------------------------------------------------

--Reference for the index numbers of laws
--
local _OPEN_SOCIETY_ = 1
local _LIMITED_RESTRICTIONS_ = 2
local _REPRESSION_ = 3
local _TOTALITARIAN_SYSTEM_ = 4

local _VOLUNTEER_ARMY_ = 6
local _ONE_YEAR_DRAFT_ = 7
local _TWO_YEAR_DRAFT_ = 8
local _THREE_YEAR_DRAFT_ = 9
local _SERVICE_BY_REQUIREMENT_ = 10

local _FULL_CIVILIAN_ECONOMY_ = 11
local _BASIC_MOBILISATION_ = 12
local _FULL_MOBILISATION_ = 13
local _WAR_ECONOMY_ = 14
local _TOTAL_ECONOMIC_MOBILISATION_ = 15

local _MINIMAL_EDUCATION_INVESTMENT_ = 16
local _AVERAGE_EDUCATION_INVESTMENT_ = 17
local _MEDIUM_LARGE_EDUCATION_INVESTMENT_ = 18
local _BIG_EDUCATION_INVESTMENT_ = 19
--
local _CONSUMER_PRODUCT_ORIENTATION_ = 20
local _MIXED_INDUSTRY_ = 21
local _HEAVY_INDUSTRY_EMPHASIS_ = 22

local _FREE_PRESS_ = 23
local _CENSORED_PRESS_ = 24
local _STATE_PRESS_ = 25
local _PROPAGANDA_PRESS_ = 26

local _MINIMAL_TRAINING_ = 27
local _BASIC_TRAINING_ = 28
local _ADVANCED_TRAINING_ = 29
local _SPECIALIST_TRAINING_ = 30


local _HEAD_OF_STATE_ = 1
local _HEAD_OF_GOVERNMENT_ = 2
local _FOREIGN_MINISTER_ = 3
local _ARMAMENT_MINISTER_ = 4
local _MINISTER_OF_SECURITY_ = 5
local _MINISTER_OF_INTELLIGENCE_ = 6
local _CHIEF_OF_STAFF_ = 7
local _CHIEF_OF_ARMY_ = 8
local _CHIEF_OF_NAVY_ = 9
local _CHIEF_OF_AIR_ = 10

-- ###################################
-- # Main Method called by the EXE
-- #####################################
function PoliticsMinister_Tick(minister)
    if math.mod( CCurrentGameState.GetAIRand(), 7) == 0 then
		Mobilization(minister)
		
	elseif math.mod( CCurrentGameState.GetAIRand(), 10) == 0 then
		Laws(minister)
		
	elseif math.mod( CCurrentGameState.GetAIRand(), 11) == 0 then
		OfficeManagement(minister)
		
	elseif math.mod( CCurrentGameState.GetAIRand(), 12) == 0 then
		local ministerTag = minister:GetCountryTag()
		local ministerCountry = minister:GetCountry()
	
		Puppets(minister, ministerTag, ministerCountry)
		Liberation(minister:GetOwnerAI(), minister, ministerTag, ministerCountry)
    end
end

function Liberation(ai, minister, ministerTag, ministerCountry)
    -- liberate countries if we can
    if ministerCountry:MayLiberateCountries() then
        for loMember in ministerCountry:GetPossibleLiberations() do
            if minister:IsCapitalSafeToLiberate(loMember) then
                ai:Post(CLiberateCountryCommand(loMember, ministerTag))
            end
        end
    end	
end

function Mobilization(minister)
	local ai = minister:GetOwnerAI()
	local ministerTag =  minister:GetCountryTag()
	local ministerCountry = minister:GetCountry()

    -- Note: we are automatically mobilized when war breaks out, so this is for kicking off mobilization early.
    if not(ministerCountry:IsMobilized()) and ministerCountry:GetStrategy():IsPreparingWar() then
        local liNeutrality = ministerCountry:GetNeutrality():Get() * 0.9
		
        for loCountry in CCurrentGameState.GetCountries() do
            local loCountryTag = loCountry:GetCountryTag()
			
			if not(loCountryTag == ministerTag) then
				if loCountryTag:IsValid() and loCountry:Exists() and loCountryTag:IsReal() then
					if ministerCountry:GetStrategy():IsPreparingWarWith(loCountryTag) and liNeutrality < ministerCountry:GetMaxNeutralityForWarWith(loCountryTag):Get() then
						ai:Post(CToggleMobilizationCommand( ministerTag, true ))
						break
					end
				end
			end
        end
    elseif not(ministerCountry:IsMobilized()) then
		if Utils.HasCountryAIFunction( ministerTag, "HandleMobilization") then
			Utils.CallCountryAI(ministerTag, "HandleMobilization", minister)							
		else
			-- check if a neighbor is starting to look threatening
			local liTotalIC = ministerCountry:GetTotalIC()
			local liNeutrality = ministerCountry:GetNeutrality():Get() * 0.9
			
			for loCountryTag in ministerCountry:GetNeighbours() do
				local loCountry = loCountryTag:GetCountry()
				local liThreat = ministerCountry:GetRelation(loCountryTag):GetThreat():Get()
				
				if (liNeutrality - liThreat) < 10 then
					liThreat = liThreat * CalculateAlignmentFactor(ai, ministerCountry, loCountry)
					
					if liTotalIC > 50 and loCountry:GetTotalIC() < liTotalIC then
						liThreat = liThreat / 2 -- we can handle them if they descide to attack anyway
					end
					
					if liThreat > 30 then
						if CalculateWarDesirability(ai, loCountry, ministerTag) > 70 then
							ai:Post(CToggleMobilizationCommand( ministerTag, true ))
						end
					end
				end
			end
		end
    end
end

function Puppets(minister, ministerTag, ministerCountry)
	-- Puppets are country specific AI countries will not release them automatically and must be scripted
    if ministerCountry:CanCreatePuppet() then
        Utils.CallCountryAI( ministerTag, "HandlePuppets", minister )
    end
end

function Laws(minister)
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local ai = minister:GetOwnerAI()
	
	-- Law group definitions
	-- unlike 1.4 code we now assert values from configuration in order to save resources
	-- Each law group has an key and a callback function
	local laLawGroups = {}
	laLawGroups["civil_law"] = {Callback=CivilLaw}
	laPositions["conscription_law"] = {Callback=ConscriptionLaw}
	laPositions["economic_law"] = {Callback=EconomicLaw}
	laPositions["education_investment_law"] = {Callback=EducationInvestment}
	laPositions["industrial_policy_laws"] = {Callback=IndustrialPolicies}
	laPositions["press_laws"] = {Callback=PressLaws}
	laPositions["training_laws"] = {Callback=TrainingLaws}	
	
	for loGroup in CLawDataBase.GetGroups() do
		local loGroupName = tostring(loGroup:GetKey())
		local loNewLaw = nil
		local loCurrentLaw = ministerCountry:GetLaw(loGroup)
		local lsMethodCall = "CallLaw_" .. loGroupName
		
		if Utils.HasCountryAIFunction(ministerTag, lsMethodCall) then
			loNewLaw = Utils.CallCountryAI(ministerTag, lsMethodCall, minister, loCurrentLaw)
			
		elseif laPositions[loGroupName] ~= nil then
			loNewLaw = laPositions[loGroupName].Callback(ministerTag, ministerCountry, loCurrentLaw)

		-- Unknown Law so just increase it by 1
		else
			-- Try to increase by 1 if the group is different do not do anything!
			loNewLaw = Laws_pickNextValidSiblingLaw(ministerTag, loCurrentLaw)
		end        

		-- Execute the new law
		if not(loNewLaw == nil) then
			if not(loNewLaw:GetIndex() == loCurrentLaw:GetIndex()) then
				if loNewLaw:ValidFor(ministerTag) then
					ai:Post(CChangeLawCommand(ministerTag, loNewLaw, loGroup))
				end
			end
		end
	end
end


function OfficeManagement(minister)
	local ai = minister:GetOwnerAI()
	local ministerCountry = minister:GetCountry()
	local ministerTag = minister:GetCountryTag()
	local loGroup = ministerCountry:GetRulingIdeology():GetGroup()
	
	-- Positions definitions
	-- unlike 1.4 code we now assert values from configuration in order to save resources
	-- Each position has an index, a callback function, a government position index, and a list of available CMinister objects
	-- We assert the existance of 8 changeable positions, and bind them to a lua callback function
	local laPositions = {}
	laPositions[_CHIEF_OF_AIR_] = {Callback=ChiefOfAir, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_CHIEF_OF_NAVY_] = {Callback=ChiefOfNavy, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_CHIEF_OF_ARMY_] = {Callback=ChiefOfArmy, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_CHIEF_OF_STAFF_] = {Callback=ChiefOfStaff, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_MINISTER_OF_INTELLIGENCE_] = {Callback=MinisterOfIntelligence, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_MINISTER_OF_SECURITY_] = {Callback=MinisterOfSecurity, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_ARMAMENT_MINISTER_] = {Callback=ArmamentMinister, GovPosition = nil, AvailableMinisters = {}}
	laPositions[_FOREIGN_MINISTER_] = {Callback=ForeignMinister, GovPosition = nil, AvailableMinisters = {}}
	
	-- Recover CGovernmentPosition for each index (k is a number)
	for k, v in pairs(laPositions) do
		laPositions[k].GovPosition = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(k)
	end
		
	-- Organize the ministers by positions they can take
	for loMinister in ministerCountry:GetPossibleMinisters() do
		-- Make sure we are the same Ideology
		if loGroup == loMinister:GetIdeology():GetGroup() then
			-- Cycle through positions
			for k, v in pairs(laPositions) do
				-- If current minister can take current position, append it to current position AvailableMinisters
				if loMinister:CanTakePosition(v.GovPosition) then
					table.insert(laPositions[k].AvailableMinisters, loMinister)
				end
			end
		end
	end
	
	-- Now that we have all available ministers for each positions, cycle through position and use callback function
	for k, v in pairs(laPositions) do
		v.Callback(ai, ministerTag, ministerCountry, v.AvailableMinisters, v.GovPosition)
	end
end

--################
-- Office Management sub-methods
--################
function OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, vaPersonalityScore, vsAiFunction)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0

	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, vsAiFunction) then
			loMinister = Utils.CallCountryAI(ministerTag,  vsAiFunction, ministerCountry, vaMinisters)
		else
			for k, v in pairs(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(v:GetPersonality(voPosition):GetKey())
				
				if vaPersonalityScore[lsMinisterType] ~= nil then
					liScore = vaPersonalityScore[lsMinisterType]
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = v
				end
			end
		end
	end

	if loMinister ~= nil then
		if loCurrentMinister ~= loMinister then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end

function MinisterOfSecurity(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["man_of_the_people"] = 70
	laPersonalityScore["efficient_sociopath"] = 60
	laPersonalityScore["crime_fighter"] = 50
	laPersonalityScore["compassionate_gentleman"] = 40
	laPersonalityScore["silent_lawyer"} = 30
	laPersonalityScore["prince_of_terror"] = 20
	laPersonalityScore["back_stabber"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_MinisterOfSecurity")
end

function ArmamentMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["administrative_genius"] = 150
	laPersonalityScore["resource_industrialist"] = 140
	laPersonalityScore["laissez_faires_capitalist"] = 130
	laPersonalityScore["military_entrepreneur"] = 120
	laPersonalityScore["theoretical_scientist"} = 110
	laPersonalityScore["infantry_proponent"] = 100
	laPersonalityScore["air_to_ground_proponent"] = 90
	laPersonalityScore["air_superiority_proponent"] = 80
	laPersonalityScore["battle_fleet_proponent"] = 70
	laPersonalityScore["air_to_sea_proponent"] = 60
	laPersonalityScore["strategic_air_proponent"] = 50
	laPersonalityScore["submarine_proponent"] = 40
	laPersonalityScore["tank_proponent"] = 30
	laPersonalityScore["corrupt_kleptocrat"] = 20
	laPersonalityScore["crooked_kleptocrat"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ArmamentMinister")
end

function ForeignMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local lsFaction = tostring(ministerCountry:GetFaction():GetTag())
	local lbIsArwar = ministerCountry:IsAtWar()
	
	local laPersonalityScore = {}
	-- Foreign minister pick depends mainly on current faction
	if lsFaction == "comintern" then
		laPersonalityScore["biased_intellectual"] = 50
	elseif lsFaction == "allies" then
		laPersonalityScore["the_cloak_n_dagger_schemer"] = 50
	elseif lsFaction == "axis" then
		laPersonalityScore["great_compromiser"] = 50
	end
	
	-- Some foreign minister are irrelevant while at peace
	if lbIsArwar then
		laPersonalityScore["general_staffer"] = 20
	end
	
	laPersonalityScore["apologetic_clerk"] = 40
	laPersonalityScore["ideological_crusader"] = 30
	laPersonalityScore["iron_fisted_brute"] = 20
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ForeignMinister")
end

function ChiefOfStaff(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["school_of_mass_combat"] = 60
	laPersonalityScore["school_of_psychology"] = 50
	laPersonalityScore["logistics_specialist"] = 40
	laPersonalityScore["school_of_fire_support"] = 30
	laPersonalityScore["school_of_defence"] = 20
	laPersonalityScore["school_of_manoeuvre"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ChiefOfStaff")
end

function MinisterOfIntelligence(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["dismal_enigma"] = 60
	laPersonalityScore["research_specialist"] = 50
	laPersonalityScore["naval_intelligence_specialist"] = 40
	laPersonalityScore["technical_specialist"] = 30
	laPersonalityScore["industrial_specialist"] = 20
	laPersonalityScore["political_specialist"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_MinisterOfIntelligence")
end

function ChiefOfArmy(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["guns_and_butter_doctrine"] = 50
	laPersonalityScore["static_defence_doctrine"] = 40
	laPersonalityScore["decisive_battle_doctrine"] = 30
	laPersonalityScore["elastic_defence_doctrine"] = 20
	laPersonalityScore["armoured_spearhead_doctrine"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ChiefOfArmy")
end

function ChiefOfNavy(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["decisive_naval_battle_doctrine"] = 50
	laPersonalityScore["indirect_approach_doctrine"] = 40
	laPersonalityScore["open_seas_doctrine"] = 30
	laPersonalityScore["base_control_doctrine"] = 20
	laPersonalityScore["power_projection_doctrine"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ChiefOfNavy")
end

function ChiefOfAir(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local laPersonalityScore = {}
	laPersonalityScore["air_superiority_doctrine"] = 50
	laPersonalityScore["army_aviation_doctrine"] = 40
	laPersonalityScore["naval_aviation_doctrine"] = 30
	laPersonalityScore["carpet_bombing_doctrine"] = 20
	laPersonalityScore["vertical_envelopment_doctrine"] = 10
	
	OfficeManagement_PickMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition, laPersonalityScore, "Call_ChiefOfAir")
end
--################
-- End of Office Management sub-methods
--################


--################
-- Law sub-methods
--################
function Laws_pickNextValidSiblingLaw(ministerTag, voCurrentLaw)
	local liIndex = voCurrentLaw:GetIndex() + 1
	local loNewLaw = nil
	
	if liIndex < CLawDataBase.GetNumberOfLaws() then
		loNewLaw = CLawDataBase.GetLaw(liIndex)
		if not(voCurrentLaw:GetGroup():GetIndex() == loNewLaw:GetGroup():GetIndex()) then 
			return nil
		end
	end

	if loNewLaw:ValidFor(ministerTag) then
		return loNewLaw
	else
		return nil
	end
end

function ConscriptionLaw(ministerTag, ministerCountry, voCurrentLaw)
	return Laws_pickNextValidSiblingLaw(ministerTag, voCurrentLaw)
end

function CivilLaw(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	-- Switch Democracies back to Open Society if no longer atwar!
	if not(ministerCountry:IsAtWar()) and tostring(ministerCountry:GetRulingIdeology():GetGroup():GetKey()) == "democracy" then
		return CLawDataBase.GetLaw(_OPEN_SOCIETY_)
	end
	
	return Laws_pickNextValidSiblingLaw(ministerTag, voCurrentLaw)
end

function EconomicLaw(ministerTag, ministerCountry, voCurrentLaw)
	return Laws_pickNextValidSiblingLaw(ministerTag, voCurrentLaw)
end

function EducationInvestment(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	if voCurrentLaw:GetIndex() == _BIG_EDUCATION_INVESTMENT_ then
		return nil
	else
		local loNewLaw = CLawDataBase.GetLaw(_BIG_EDUCATION_INVESTMENT_)
		
		if loNewLaw:ValidFor(ministerTag) then
			return loNewLaw
		end		
	end
	
	return nil
end
function IndustrialPolicies(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	if voCurrentLaw:GetIndex() == _HEAVY_INDUSTRY_EMPHASIS_ and ministerCountry:IsAtWar() then
		return nil
	end

	-- Peace get the break from the CG hit
	if not(ministerCountry:IsAtWar()) then
		return CLawDataBase.GetLaw(_CONSUMER_PRODUCT_ORIENTATION_)
	else
		-- Try Heavy first if not then try Mixed
		local loNewLaw = CLawDataBase.GetLaw(_HEAVY_INDUSTRY_EMPHASIS_)
		
		if loNewLaw:ValidFor(ministerTag) then
			return loNewLaw
		else
			loNewLaw = CLawDataBase.GetLaw(_MIXED_INDUSTRY_)
			
			if loNewLaw:ValidFor(ministerTag) then
				return loNewLaw
			end
		end
	end
	
	return nil
end

function PressLaws(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	-- Switch Democracies back to Free Press if no longer atwar!
	if not(ministerCountry:IsAtWar()) and tostring(ministerCountry:GetRulingIdeology():GetGroup():GetKey()) == "democracy" then
		return CLawDataBase.GetLaw(_FREE_PRESS_)
	end
	
	return Laws_pickNextValidSiblingLaw(ministerTag, voCurrentLaw)
end

function TrainingLaws(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	if voCurrentLaw:GetIndex() == _BASIC_TRAINING_ then
		return nil
	else
		local loNewLaw = CLawDataBase.GetLaw(_BASIC_TRAINING_)
		
		if loNewLaw:ValidFor(ministerTag) then
			return loNewLaw
		end		
	end
	
	return nil
end
--################
-- End of Law sub-methods
--################
