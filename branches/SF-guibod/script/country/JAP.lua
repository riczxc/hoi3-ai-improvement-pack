-----------------------------------------------------------
-- LUA Hearts of Iron 3 Japan File
-- Created By: Lothos
-- Modified By: Lothos
-- Date Last Modified: 6/11/2010
-----------------------------------------------------------
local FLAG_LIMITED_CONTINENTAL_WAR = "JAP_LIMITED_CONTINENTAL_WAR"
local FLAG_TOTAL_CONTINENTAL_WAR = "JAP_TOTAL_CONTINENTAL_WAR"
local FLAG_LOST_CONTINENTAL_WAR = "JAP_TOTAL_CONTINENTAL_WAR"
local FLAG_PACIFIC_WAR = "JAP_PACIFIC_WAR"
local FLAG_GOTTERDAMMERUNG = "JAP_GOTTERDAMMERUNG"

local P = {}
AI_JAP = P

-- Tech weights
--   1.0 = 100% the total needs to equal 1.0
function P.TechWeights(minister)
	local laTechWeights = {
		0.18, -- landBasedWeight
		0.09, -- landDoctrinesWeight
		0.12, -- airBasedWeight
		0.15, -- airDoctrinesWeight
		0.18, -- navalBasedWeight
		0.10, -- navalDoctrinesWeight
		0.10, -- industrialWeight
		0.04, -- secretWeaponsWeight
		0.04, -- otherWeight
		false}; -- lbLandBased
	
	return laTechWeights
end

-- Techs that are used in the main file to be ignored
--   techname|level (level must be 1-9 a 0 means ignore all levels
--   use as the first tech name the word "all" and it will cause the AI to ignore all the techs
function P.LandTechs(minister)
	local ignoreTech = {"cavalry_smallarms|3", 
		"cavalry_support|3",
		"cavalry_guns|3", 
		"cavalry_at|3",
		"paratrooper_infantry|0",
		"desert_warfare_equipment|0",
		"artic_warfare_equipment|0",
		"airborne_warfare_equipment|0",
		"armored_car_armour|0",
		"armored_car_gun|0",
		"tank_brigade|0",
		"tank_gun|0",
		"tank_engine|0",
		"tank_armour|0",
		"tank_reliability|0",
		"heavy_tank_brigade|0",
		"heavy_tank_gun|0",
		"heavy_tank_engine|0",
		"heavy_tank_armour|0",
		"heavy_tank_reliability|0",
		"super_heavy_tank_brigade|0",
		"super_heavy_tank_gun|0",
		"super_heavy_tank_engine|0",
		"super_heavy_tank_armour|0",
		"super_heavy_tank_reliability|0",
		"rocket_art|0",
		"rocket_art_ammo|0",
		"rocket_carriage_sights|0"};
		
	return ignoreTech
end

function P.LandDoctrinesTechs(minister)
	local ignoreTech = {"mobile_warfare|0",
		"elastic_defence|0",
		"spearhead_doctrine|0",
		"schwerpunkt|0",
		"blitzkrieg|0",
		"elastic_defence|0",
		"operational_level_command_structure|0",
		"tactical_command_structure|0",
		"integrated_support_doctrine|0",
		"superior_firepower|0",
		"mechanized_offensive|0",
		"combined_arms_warfare|0",
		"peoples_army|0",
		"large_formations|0"};
		
	return ignoreTech
end

function P.AirTechs(minister)
	local ignoreTech = {"basic_four_engine_airframe|0",
		"basic_strategic_bomber|0",
		"large_fueltank|0",
		"four_engine_airframe|0",
		"strategic_bomber_armament|0",
		"cargo_hold|0",
		"large_bomb|0",
		"large_airsearch_radar|0",
		"large_navagation_radar|0",
		"drop_tanks|0"};

	return ignoreTech
end

function P.AirDoctrineTechs(minister)
	local ignoreTech = {"forward_air_control|0",
		"battlefield_interdiction|0",
		"bomber_targerting_focus|0",
		"fighter_targerting_focus|0", 
		"heavy_bomber_pilot_training|0",
		"heavy_bomber_groundcrew_training|0",
		"strategic_bombardment_tactics|0",
		"airborne_assault_tactics|0",
		"strategic_air_command|0"};

	return ignoreTech
end
		
function P.NavalTechs(minister)
	local ignoreTech = {"battlecruiser_technology|0",
		"battlecruiser_antiaircraft|0",
		"battlecruiser_engine|0",
		"battlecruiser_armour|0"};

	return ignoreTech
end
		
function P.NavalDoctrineTechs(minister)
	local ignoreTech = {};

	return ignoreTech
end

function P.IndustrialTechs(minister)
	local ignoreTech = {"heavy_aa_guns|0",
		"rocket_tests|0",
		"rocket_engine|0",
		"atomic_research|0",
		"nuclear_research|0",
		"isotope_seperation|0",
		"civil_nuclear_research|0"};

	return ignoreTech
end
		
function P.SecretWeaponTechs(minister)
	local ignoreTech = {"all"}
	
	return ignoreTech
end

function P.OtherTechs(minister)
	local ignoreTech = {"naval_engineering_research|0",
		"submarine_engineering_research|0",
		"aeronautic_engineering_research|0",
		"rocket_science_research|0",
		"chemical_engineering_research|0",
		"nuclear_physics_research|0",
		"jetengine_research|0",
		"mechanicalengineering_research|0",
		"automotive_research|0",
		"electornicegineering_research|0",
		"artillery_research|0",
		"mobile_research|0",
		"militia_research|0",
		"infantry_research|0"};

	return ignoreTech
end

-- END OF TECH RESEARCH OVERIDES
-- #######################################


-- #######################################
-- Production Overides the main LUA with country specific ones

-- Production Weights
--   1.0 = 100% the total needs to equal 1.0
function P.ProductionWeights(minister)
	local rValue
	local loFlags = minister:GetCountry():GetFlags()
	
	-- Strong navy/air emphasis if no more troops on continent 
	-- or ongoing pacific war with no major engagement on continent
	if loFlags:IsFlagSet(FLAG_LOST_CONTINENTAL_WAR) or 
		loFlags:IsFlagSet(FLAG_PACIFIC_WAR) and not(loFlags:IsFlagSet(FLAG_TOTAL_CONTINENTAL_WAR)) then
		
		local laArray = {
			0.30, -- Land
			0.25, -- Air
			0.40, -- Sea
			0.05}; -- Other
		
		rValue = laArray	
	else
		local laArray = {
			0.55, -- Land
			0.15, -- Air
			0.25, -- Sea
			0.05}; -- Other
		
		rValue = laArray
	end
	
	return rValue
end
-- Land ratio distribution
function P.LandRatio(minister)
	local laArray = {
		10, -- Garrison
		24, -- Infantry
		0, -- Motorized
		0, -- Mechanized
		1, -- Armor
		0, -- Militia
		0}; -- Cavalry
	
	return laArray
end
-- Special Forces ratio distribution
function P.SpecialForcesRatio(minister)
	local laArray = {
		8, -- Land
		1}; -- Special Forces Unit
	
	return laArray
end
-- Air ratio distribution
function P.AirRatio(minister)
	local loFlags = minister:GetCountry():GetFlags()
	
	-- No needs for NAV if no pacific war
	if loFlags:IsFlagSet(FLAG_PACIFIC_WAR) then 
		local laArray = {
			5, -- Fighter
			1, -- CAS
			2, -- Tactical
			2, -- Naval Bomber
			0}; -- Strategic
	else
		local laArray = {
			5, -- Fighter
			1, -- CAS
			4, -- Tactical
			0, -- Naval Bomber
			0}; -- Strategic
	end
	
	return laArray
end
-- Naval ratio distribution
function P.NavalRatio(minister)
	local laArray = {
		6, -- Destroyers
		2, -- Submarines
		6, -- Cruisers
		1, -- Capital
		1, -- Escort Carrier
		1}; -- Carrier
	
	return laArray
end
-- Transport to Land unit distribution
function P.TransportLandRatio(minister)
	local laArray = {
		40, -- Land
		1}; -- Transport
	
	return laArray
end

-- Do not build battle cruisers
function P.Build_Battlecruiser(ic, minister, battlecruiser, vbGoOver)
	-- Replace Battlecruiser request with a Battleship
	if minister:GetCountry():GetTechnologyStatus():IsUnitAvailable(CSubUnitDataBase.GetSubUnit("battleship")) then
		return Utils.CreateDivision_nominor(minister, "battleship", 1, ic, battlecruiser, 1, vbGoOver)
	else
		return ic, 0
	end
end

-- Do not build Rocket Sites
function P.Build_RocketTest(ic, minister, vbGoOver)
	return ic
end

		
-- END OF PRODUTION OVERIDES
-- #######################################

-- #######################################
-- Intelligence Hooks

-- Home_Spies(minister)
-- #######################################

function P.Home_Spies(minister)
	return Support.Home_Spies_Interventionist(minister)
end

-- End of Intelligence Hooks
-- #######################################
function P.ForeignMinister_EvaluateDecision(score, agent, decision, scope)
	local lsDecision = decision:GetKey():GetString()
	
	if lsDecision == "marco_polo_bridge_incident" then
		score = 0
		local manTag = CCountryDataBase.GetTag("MAN") -- Manchuria
		local csxTag = CCountryDataBase.GetTag("CSX") -- Shanxi
		local chiTag = CCountryDataBase.GetTag("CHI") -- China
		local chcTag = CCountryDataBase.GetTag("CHC") -- Communist China
		local ministerCountry = agent:GetCountry()
		local lomanCountry = manTag:GetCountry()
		
		if ministerCountry:IsNeighbour(chiTag)
		or lomanCountry:IsNeighbour(chiTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(chiTag, 100, decision, false)
		elseif ministerCountry:IsNeighbour(csxTag)
		or lomanCountry:IsNeighbour(csxTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(csxTag, 100, decision, false)
		elseif ministerCountry:IsNeighbour(chcTag)
		or lomanCountry:IsNeighbour(chcTag) then
			ministerCountry:GetStrategy():PrepareWarDecision(chcTag, 100, decision, false)
		end
	end
	
	return score
end
function P.ProposeDeclareWar(minister)
	local ministerCountry = minister:GetCountry()
	local loStrategy = ministerCountry:GetStrategy()
	
	if not(loStrategy:IsPreparingWar()) then
		if ministerCountry:GetFaction() == CCurrentGameState.GetFaction('axis') then
			local ministerTag = minister:GetCountryTag()
			local ai = minister:GetOwnerAI()			
			local year = ai:GetCurrentDate():GetYear()
			local month = ai:GetCurrentDate():GetMonthOfYear()
		
			local gerTag = CCountryDataBase.GetTag('GER')
			local sovTag = CCountryDataBase.GetTag('SOV')
			local engTag = CCountryDataBase.GetTag('ENG')
			local holTag = CCountryDataBase.GetTag('HOL')
			local fraTag = CCountryDataBase.GetTag('FRA')
			local usaTag = CCountryDataBase.GetTag('USA')
			local phiTag = CCountryDataBase.GetTag('PHI')
			
		
			-- Soviet War Check
			--    make sure no war with USA first
			if not(ministerCountry:GetRelation(usaTag):HasWar()) then
				if gerTag:GetCountry():GetRelation(sovTag):HasWar() then
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
						-- Limited War
						loStrategy:PrepareLimitedWar(sovTag, 100)
					end
				end
			end

			-- USA War Check
			--    make sure no war with the Soviets first
			if not(ministerCountry:GetRelation(sovTag):HasWar()) then
				-- First try and go to war with the USA
				if ((year >= 1941 and month >= 10)
				or year >= 1942) then
					if not(ministerCountry:GetRelation(usaTag):HasWar())
					and not(usaTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(usaTag, 100)

						-- Prepare for war with Philippines
						if not(ministerCountry:GetRelation(phiTag):HasAlliance())
						and not(ministerCountry:GetRelation(phiTag):HasWar())
						and not(phiTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
							-- Limited War
							loStrategy:PrepareLimitedWar(phiTag, 100)
						end
					end
					
					-- Prepare for war with France
					if not(ministerCountry:GetRelation(engTag):HasAlliance())
					and not(ministerCountry:GetRelation(engTag):HasWar())
					and not(engTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(engTag, 100)
					end
					
					-- Prepare for war with France
					if not(ministerCountry:GetRelation(fraTag):HasAlliance())
					and not(ministerCountry:GetRelation(fraTag):HasWar())
					and not(fraTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(fraTag, 100)
					end

					-- Prepare for war with Holland
					if not(ministerCountry:GetRelation(holTag):HasAlliance())
					and not(ministerCountry:GetRelation(holTag):HasWar())
					and not(holTag:GetCountry():GetFaction() == ministerCountry:GetFaction()) then
						-- Limited War
						loStrategy:PrepareLimitedWar(holTag, 100)
					end
				end
			end
		end
	end
end

function P.DiploScore_OfferTrade(score, ai, actor, recipient, observer, voTradedFrom, voTradedTo)
	local lsActorTag = tostring(actor)
	
	if lsActorTag == "SIA" or lsActorTag == "USA" then
		score = score + 20
	end
	
	return score
end

-- Influence Ignore list
function P.InfluenceIgnore(minister)
	-- Ignore Denmark if they join allies don't waste the diplomacy
	-- Ignore Poland as we will DOW them with Danzig or War event
	-- Ignore Baltic states as Russia will annex them
	-- Ignore Austria, Czechoslovakia as we will get them
	-- Ignore Switzerland as there is no chance of them joining
	-- Ignore Vichy, they wont join anyone unles DOWed
	local laIgnoreList = {
		"AUS",
		"CZE",
		"SCH",
		"LAT",
		"LIT",
		"EST",
		"VIC",
		"DEN",
		"POL"};
	
	return laIgnoreList
end

function P.DiploScore_InfluenceNation( score, ai, actor, recipient, observer )
	local lsRepTag = tostring(recipient)
	
	if lsRepTag == "SIA" then
		score = score + 70
	elseif lsRepTag == "CHI" then
		score = score - 20
	end

	return score
end

function P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)
	local loRecipientGroup = recipient:GetCountry():GetRulingIdeology():GetGroup()
	local loActorGroup = actor:GetCountry():GetRulingIdeology():GetGroup()

	-- If they are not of the same Ideology group then dont join them no matter what!
	if loActorGroup ~= loRecipientGroup then
		score = 0
	end
	
	return score
end

function P.DiploScore_Alliance(score, ai, actor, recipient, observer, action)
	-- Just process the invite to faction code
	return P.DiploScore_InviteToFaction( score, ai, actor, recipient, observer)	
end

function P.EvaluateFlags(minister)
	-- Continental VP, list of all asian inland objectives for JAP (not too far inland as historically)
	-- (Korea, Mandchouria, Eastern China, Eastern SOV, Siam, Indochina)
	local laProvContinentalVP = {
		4390 --[[Vladivostok]], 8230 --[[Magadan]], 8744 --[[Ulanude]], 8743 --[[Irkutsk]] --SOVIET UNION
		8892 --[[Ulaanbaatar]], --MONGOLIA
		5341 --[[Pusan]], -- KOREA
		4979 --[[Beiping]], 5494 --[[Nanjing]], 5542 --[[Shanghai]], 5246 --[[Qingdao]], 5834 --[[Guangzhou]], 5868 --[[Hongkong]], --CHINA
		7139 --[[Harbin]], -- MANCHURIA
		6148 --[[Bangkok]], -- SIAM
		5916 --[[Hanoi]], 6236 --[[Saigon]] -- INDOCHINA
		
		-- Not needed, it would prevent focus on pacific war. Since UK is a major but unable to provide heavy asian engagement
		-- 6394 --[[Singapore]],
		-- 6070 --[[Rangoon]], -- BURMA
		-- 5875 --[[Calcutta]], 9406 --[[Delhi]], 6005 --[[Bombay]] --INDIA
	} 

	-- Homefront provinces, list of all provinces on Honshu, Hokkaido, Kyushu  and Shikoku
	local laProvHomefront = {
		-- PORTS
		5315 --[[Tokyo]], 5345 --[[Kyoto]], 4986 --[[Akita]], 5218 --[[Kanazawa]]
		5370 --[[Osaka]], 5425 --[[Hiroshima]], 5478 --[[Susaki]], 5543 --[[Nagasaki]],
		7238 --[[Sapporo]], 
		
		-- MANPOWER
		5120 --[[Sendai]], 5150	--[[Niigata]], 5187 --[[Fukushima]], 5249 --[[Taegu]], 5641 --[[Kagoshima]]
	}
	
	-- Pacific VP, list of all pacific war realistic
	local laProvPacificVP = {
		-- JAPAN
		10642 --[[Iwo Jima]], 5759 --[[Naha]],  5809 --[[Kaohsiung]], -- Near islands
		10643 --[[Marcus Island]], 10651 --[[Truk]], 10653 --[[Ponape]], 10658	--[[Kwajalein]], 10663 --[[Eniwetok]], 5966	 --[[Saipan]], 6291 --[[Palau]], --Polynesia
		
		-- USA
		1066 --[[Wake Island]], 10669 --[[Midway Island]], 5825 --[[Honolulu]], 6119 --[[Guam]],
		3658 --[[Sanfransisco]], 7350 --[[Sandiego]], 8078 --[[Anchorage]],
		7717 --[[Panama]],
		
		-- NETHERLAND
		6507 --[[Batavia]], 7764 --[[Hollandia]], 
		
		-- PHILIPINE
		6142 --[[Manila]], 6246 --[[Puertoprincesa]]
		
		-- AUSTRALIA
		6467 --[[Rabaul]], 6566 --[[Portmoresby]]
	}
	
	local status
	
	-- JAP_LIMITED_CONTINENTAL_WAR
	-- e.g. 2nd Sino-Japanese war
	-- Japan is involved in a continental war involving regional powers
	status  = Strategic_TerritoryStatus(minister, laProvContinentalVP, 2)
	Strategic_SetFlag(minister, FLAG_LIMITED_CONTINENTAL_WAR, status.hasOutOfControl )
	
	-- JAP_TOTAL_CONTINENTAL_WAR
	-- e.g. war against Soviets
	-- Japan is involved in a continental war involving major powers
	Strategic_SetFlag(minister, FLAG_TOTAL_CONTINENTAL_WAR, status.hasOutOfControl and status.isMajorInvolved )
	
	-- JAP_LOST_CONTINENTAL_WAR
	-- Japan is involved in a continental war and losing
	-- (mandchouria is no more a puppet, no more control on Seoul, PyongYang, Dagu, Qingdao, Shangai or Ghangzu)
	Strategic_SetFlag(minister, FLAG_LOST_CONTINENTAL_WAR, status.isOutOfControl)
	
	-- JAP_PACIFIC_WAR
	-- e.g. war against USA 
	-- Japan is involved in a war accross the pacific involving enemy major powers
	status  = Strategic_TerritoryStatus(minister, laProvPacificVP, 2) 
	Strategic_SetFlag(minister, FLAG_PACIFIC_WAR, not(status.isUnderControl) and status.isMajorInvolved)
		
	-- JAP_GOTTERDAMMERUNG
	-- Japan home islands are partially occupied by enemy troops
	status  = Strategic_TerritoryStatus(minister, laProvHomefront, 1) --infolevel = 1 don't care about allies or neutral, NOBODY should control our mainland
	Strategic_SetFlag(minister, FLAG_GOTTERDAMMERUNG, status.hasOutOfControl)
end

function P.CallLaw_training_laws(minister, voCurrentLaw)
	local _MINIMAL_TRAINING_ = 27
	local _BASIC_TRAINING_ = 28
	local loFlags = minister:GetCountry():GetFlags()
	
	-- Rush troop production
	if loFlags:IsFlagSet(FLAG_GOTTERDAMMERUNG)  then
		return CLawDataBase.GetLaw(_MINIMAL_TRAINING_)
	else
		return CLawDataBase.GetLaw(_SPECIALIST_TRAINING_)
	end if
end

return AI_JAP
