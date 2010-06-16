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
		
	for loGroup in CLawDataBase.GetGroups() do
		local loGroupName = tostring(loGroup:GetKey())
		local loNewLaw = nil
		local loCurrentLaw = ministerCountry:GetLaw(loGroup)
		local lsMethodCall = "CallLaw_" .. loGroupName
		
		if Utils.HasCountryAIFunction(ministerTag, lsMethodCall) then
			loNewLaw = Utils.CallCountryAI(ministerTag, lsMethodCall, minister, loCurrentLaw)
			
		elseif (loGroupName == "civil_law") then
			loNewLaw = CivilLaw(ministerTag, ministerCountry, loCurrentLaw)

		elseif (loGroupName == "conscription_law") then
			loNewLaw = ConscriptionLaw(ministerTag, ministerCountry, loCurrentLaw)
			
		elseif loGroupName == "economic_law" then
			loNewLaw = EconomicLaw(ministerTag, ministerCountry, loCurrentLaw)
			
		elseif loGroupName == "education_investment_law" then
			loNewLaw = EducationInvestment(ministerTag, ministerCountry, loCurrentLaw)
			
		elseif loGroupName == "industrial_policy_laws" then
			loNewLaw = IndustrialPolicies(ministerTag, ministerCountry, loCurrentLaw)
			
		elseif loGroupName == "press_laws" then
			loNewLaw = PressLaws(ministerTag, ministerCountry, loCurrentLaw)
			
		elseif loGroupName == "training_laws" then
			loNewLaw = TrainingLaws(ministerTag, ministerCountry, loCurrentLaw)
			
		-- Unknown Law so just increase it by 1
		else
			-- Try to increase by 1 if the group is different do not do anything!
			local liLawIndex = loCurrentLaw:GetIndex() + 1
			if liLawIndex < CLawDataBase.GetNumberOfLaws() then
				loNewLaw = CLawDataBase.GetLaw(liLawIndex)
				if not (loGroup:GetIndex() == loNewLaw:GetGroup():GetIndex()) then 
					loNewLaw = nil
				end
			end
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
	
	local laDummy = {}
	local laPositions = {laDummy, laDummy, laDummy, laDummy, laDummy, laDummy, laDummy, laDummy, laDummy, laDummy}
	
	local loChiefOfAir = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_CHIEF_OF_AIR_)
	local loChiefOfNavy = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_CHIEF_OF_NAVY_)
	local loChiefOfArmy = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_CHIEF_OF_ARMY_)
	local loChiefOfStaff = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_CHIEF_OF_STAFF_)
	local loMinisterOfIntelligence = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_MINISTER_OF_INTELLIGENCE_)
	local loMinisterOfSecurity = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_MINISTER_OF_SECURITY_)
	local loArmamentMinister = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_ARMAMENT_MINISTER_)
	local loForeignMinister = CGovernmentPositionDataBase.GetGovernmentPositionByIndex(_FOREIGN_MINISTER_)
	
	-- Organize the ministers by positions they can take
	for loMinister in ministerCountry:GetPossibleMinisters() do
		-- Make sure we are the same Ideology
		if loGroup == loMinister:GetIdeology():GetGroup() then
			if loMinister:CanTakePosition(loChiefOfAir) then
				table.insert(laPositions[_CHIEF_OF_AIR_], loMinister)
			end
			
			if loMinister:CanTakePosition(loChiefOfNavy) then
				table.insert(laPositions[_CHIEF_OF_NAVY_], loMinister)
			end
			
			if loMinister:CanTakePosition(loChiefOfArmy) then
				table.insert(laPositions[_CHIEF_OF_ARMY_], loMinister)
			end
			
			if loMinister:CanTakePosition(loChiefOfStaff) then
				table.insert(laPositions[_CHIEF_OF_STAFF_], loMinister)
			end
			
			if loMinister:CanTakePosition(loMinisterOfIntelligence) then
				table.insert(laPositions[_MINISTER_OF_INTELLIGENCE_], loMinister)
			end
			
			if loMinister:CanTakePosition(loMinisterOfSecurity) then
				table.insert(laPositions[_MINISTER_OF_SECURITY_], loMinister)
			end
			
			if loMinister:CanTakePosition(loArmamentMinister) then
				table.insert(laPositions[_ARMAMENT_MINISTER_], loMinister)
			end
			
			if loMinister:CanTakePosition(loForeignMinister) then
				table.insert(laPositions[_FOREIGN_MINISTER_], loMinister)
			end
		end
	end

	MinisterOfSecurity(ai, ministerTag, ministerCountry, laPositions[_MINISTER_OF_SECURITY_], loMinisterOfSecurity)
	ArmamentMinister(ai, ministerTag, ministerCountry, laPositions[_ARMAMENT_MINISTER_], loArmamentMinister)
	ForeignMinister(ai, ministerTag, ministerCountry, laPositions[_FOREIGN_MINISTER_], loForeignMinister)
	ChiefOfStaff(ai, ministerTag, ministerCountry, laPositions[_CHIEF_OF_STAFF_], loChiefOfStaff)
	MinisterOfIntelligence(ai, ministerTag, ministerCountry, laPositions[_MINISTER_OF_INTELLIGENCE_], loMinisterOfIntelligence)
	ChiefOfArmy(ai, ministerTag, ministerCountry, laPositions[_CHIEF_OF_ARMY_], loChiefOfArmy)
	ChiefOfNavy(ai, ministerTag, ministerCountry, laPositions[_CHIEF_OF_NAVY_], loChiefOfNavy)
	ChiefOfAir(ai, ministerTag, ministerCountry, laPositions[_CHIEF_OF_AIR_], loChiefOfAir)
end

--################
-- Office Management sub-methods
--################
function MinisterOfSecurity(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_MinisterOfSecurity") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_MinisterOfSecurity", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0


				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())

				if lsMinisterType == "man_of_the_people" then
					liScore = 70
				elseif lsMinisterType == "efficient_sociopath" then
					liScore = 60
				elseif lsMinisterType == "crime_fighter" then
					liScore = 50
				elseif lsMinisterType == "compassionate_gentleman" then
					liScore = 40
				elseif lsMinisterType == "silent_lawyer" then
					liScore = 30
				elseif lsMinisterType == "prince_of_terror" then
					liScore = 20
				elseif lsMinisterType == "back_stabber" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end

	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ArmamentMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ArmamentMinister") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ArmamentMinister", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				
				if lsMinisterType == "administrative_genius" then
					liScore = 150
				elseif lsMinisterType == "resource_industrialist" then
					liScore = 140
				elseif lsMinisterType == "laissez_faires_capitalist" then
					liScore = 130
				elseif lsMinisterType == "military_entrepreneu" then
					liScore = 120
				elseif lsMinisterType == "theoretical_scientist" then
					liScore = 110
				elseif lsMinisterType == "infantry_proponent" then
					liScore = 100
				elseif lsMinisterType == "air_to_ground_proponent" then
					liScore = 90
				elseif lsMinisterType == "air_superiority_proponent" then
					liScore = 80
				elseif lsMinisterType == "battle_fleet_proponent" then
					liScore = 70
				elseif lsMinisterType == "air_to_sea_proponent" then
					liScore = 60
				elseif lsMinisterType == "strategic_air_proponent" then
					liScore = 50
				elseif lsMinisterType == "submarine_proponent" then
					liScore = 40
				elseif lsMinisterType == "tank_proponent" then
					liScore = 30
				elseif lsMinisterType == "corrupt_kleptocrat" then
					liScore = 20
				elseif lsMinisterType == "crooked_kleptocrat" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ForeignMinister(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local lsFaction = tostring(ministerCountry:GetFaction():GetTag())
	local lbIsArwar = ministerCountry:IsAtWar()
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ForeignMinister") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ForeignMinister", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				
				if lsMinisterType == "biased_intellectual" and lsFaction == "comintern" then
					liScore = 50
				elseif lsMinisterType == "the_cloak_n_dagger_schemer" and lsFaction == "allies" then
					liScore = 50
				elseif lsMinisterType == "great_compromiser" and lsFaction == "axis" then
					liScore = 50
					
				elseif lsMinisterType == "apologetic_clerk" then
					liScore = 40
				elseif lsMinisterType == "ideological_crusader" then
					liScore = 30
				elseif lsMinisterType == "general_staffer" and not(lbIsArwar) then
					liScore = 20
				elseif lsMinisterType == "iron_fisted_brute" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ChiefOfStaff(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ChiefOfStaff") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ChiefOfStaff", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				if lsMinisterType == "school_of_mass_combat" then
					liScore = 60
				elseif lsMinisterType == "school_of_psychology" then
					liScore = 50
				elseif lsMinisterType == "logistics_specialist" then
					liScore = 40
				elseif lsMinisterType == "school_of_fire_support" then
					liScore = 30
				elseif lsMinisterType == "school_of_defence" then
					liScore = 20
				elseif lsMinisterType == "school_of_manoeuvre" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function MinisterOfIntelligence(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_MinisterOfIntelligence") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_MinisterOfIntelligence", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				
				if lsMinisterType == "dismal_enigma" then
					liScore = 60
				elseif lsMinisterType == "research_specialist" then
					liScore = 50
				elseif lsMinisterType == "naval_intelligence_specialist" then
					liScore = 40
				elseif lsMinisterType == "technical_specialist" then
					liScore = 30
				elseif lsMinisterType == "industrial_specialist" then
					liScore = 20
				elseif lsMinisterType == "political_specialist" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ChiefOfArmy(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ChiefOfArmy") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ChiefOfArmy", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				
				if lsMinisterType == "guns_and_butter_doctrine" then
					liScore = 50
				elseif lsMinisterType == "static_defence_doctrine" then
					liScore = 40
				elseif lsMinisterType == "decisive_battle_doctrine" then
					liScore = 30
				elseif lsMinisterType == "elastic_defence_doctrine" then
					liScore = 20
				elseif lsMinisterType == "armoured_spearhead_doctrine" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ChiefOfNavy(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ChiefOfNavy") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ChiefOfNavy", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())

				if lsMinisterType == "decisive_naval_battle_doctrine" then
					liScore = 50
				elseif lsMinisterType == "indirect_approach_doctrine" then
					liScore = 40
				elseif lsMinisterType == "open_seas_doctrine" then
					liScore = 30
				elseif lsMinisterType == "base_control_doctrine" then
					liScore = 20
				elseif lsMinisterType == "power_projection_doctrine" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
function ChiefOfAir(ai, ministerTag, ministerCountry, vaMinisters, voPosition)
	local loMinister = nil
	local loCurrentMinister = ministerCountry:GetMinister(voPosition)
	local liCurrentScore = 0
	
	if table.getn(vaMinisters) > 0 then
		if Utils.HasCountryAIFunction(ministerTag, "Call_ChiefOfAir") then
			loMinister = Utils.CallCountryAI(ministerTag, "Call_ChiefOfAir", ministerCountry, vaMinisters)
		else
			for i = 1, table.getn(vaMinisters) do
				local liScore = 0
				local lsMinisterType = tostring(vaMinisters[i]:GetPersonality(voPosition):GetKey())
				
				if lsMinisterType == "air_superiority_doctrine" then
					liScore = 50
				elseif lsMinisterType == "army_aviation_doctrine" then
					liScore = 40
				elseif lsMinisterType == "naval_aviation_doctrine" then
					liScore = 30
				elseif lsMinisterType == "carpet_bombing_doctrine" then
					liScore = 20
				elseif lsMinisterType == "vertical_envelopment_doctrine" then
					liScore = 10
				end

				if liScore > liCurrentScore then
					liCurrentScore = liScore
					loMinister = vaMinisters[i]
				end
			end
		end
	end
	
	if not(loMinister == nil) then
		if not(loCurrentMinister == loMinister) then
			ai:Post(CChangeMinisterCommand(ministerTag, loMinister, voPosition))
		end
	end
end
--################
-- End of Office Management sub-methods
--################


--################
-- Law sub-methods
--################
function ConscriptionLaw(ministerTag, ministerCountry, voCurrentLaw)
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
function CivilLaw(ministerTag, ministerCountry, voCurrentLaw)
	-- Performance Check do we really need to do anything?
	-- Switch Democracies back to Open Society if no longer atwar!
	if not(ministerCountry:IsAtWar()) and tostring(ministerCountry:GetRulingIdeology():GetGroup():GetKey()) == "democracy" then
		return CLawDataBase.GetLaw(_OPEN_SOCIETY_)
	end
	
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
function EconomicLaw(ministerTag, ministerCountry, voCurrentLaw)
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
