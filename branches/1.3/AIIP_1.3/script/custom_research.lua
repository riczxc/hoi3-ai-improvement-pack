-- List of all techs
-------------------------------------------------------------------
----------------------------INFANTRY
local infantry = {
					'infantry_activation',
					'smallarms_technology',
					'infantry_support',
					'infantry_guns',
					'infantry_at',
					'night_goggles',
					'infantry_warfare'
				}
local militia = {
					'militia_smallarms',
					'militia_support',
					'militia_guns',
					'militia_at',
					'peoples_army'
				}
local cavalry = {
					'cavalry_smallarms',
					'cavalry_support',
					'cavalry_guns',
					'cavalry_at'
				}
local mountain = {
					'mountain_infantry',
					'mountain_warfare_equipment'
				}
local airborne = {
					'paratrooper_infantry',
					'airborne_warfare_equipment',
					'basic_four_engine_airframe',
					'cargo_hold',
					'airborne_assault_tactics'
				}
local marine = {
					'marine_infantry',
					'amphibious_warfare_equipment'
				}
local engineer = {
					'engineer_brigade_activation',
					'engineer_bridging_equipment',
					'engineer_assault_equipment'
				}
local arctic = {
					'artic_warfare_equipment'
				}
local jungle = {
					'jungle_warfare_equipment'
				}
local desert = {
					'desert_warfare_equipment'
				}
local security = {
					'imporved_police_brigade'
				}
-------------------------------------------------------------------				
----------------------------ARMOUR
local light_tank = {
					'lighttank_brigade',
					'lighttank_gun',
					'lighttank_engine',
					'lighttank_armour',
					'lighttank_reliability',
					'armored_car_armour',
					'armored_car_gun',
					'mortorised_infantry',
					'mechanised_infantry',
					'cavalry_smallarms',
					'cavalry_support',
					'cavalry_guns',
					'cavalry_at'
				}
local medium_tank = {
					'tank_brigade',
					'tank_gun',
					'tank_engine',
					'tank_armour',
					'tank_reliability',
					'SP_brigade'
				}
local heavy_tank = {
					'heavy_tank_brigade',
					'heavy_tank_gun',
					'heavy_tank_engine',
					'heavy_tank_armour',
					'heavy_tank_reliability'
				}
local sheavy_tank = {
					'super_heavy_tank_brigade',
					'super_heavy_tank_gun',
					'super_heavy_tank_engine',
					'super_heavy_tank_armour',
					'super_heavy_tank_reliability'
				}
local anti_tank = {
					'at_barrell_sights',
					'at_ammo_muzzel'
				}
local anti_aircraft = {
					'aa_barrell_ammo',
					'aa_carriage_sights',
					'heavy_aa_guns'
				}
local artillery = {
					'art_barrell_ammo',
					'art_carriage_sights'
				}
local rocket_artillery = {
					'rocket_art',
					'rocket_art_ammo',
					'rocket_carriage_sights'
				}
-------------------------------------------------------------------
----------------------------LAND DOCTRINE
local germany1 = {
					'mobile_warfare',
					'spearhead_doctrine',
					'blitzkrieg'
				}
local germany2 = {
					'schwerpunkt',
					'operational_level_command_structure',
					'mechanized_offensive'
				}
local germany3 = {
					'elastic_defence',
					'tactical_command_structure',
					'combined_arms_warfare',
					'special_forces',
					'assault_concentration'
				}
-------------------------------------------------------------------
local soviet1 = {
					'mass_assault',
					'large_front',
					'human_wave'
				}
local soviet2 = {
					'blitzkrieg',
					'integrated_support_doctrine',
					'assault_concentration'
				}
local soviet3 = {
					'mechanized_offensive',
					'operational_level_command_structure',
					'combined_arms_warfare'
				}
-------------------------------------------------------------------
local usa1 = {
					'superior_firepower',
					'mechanized_offensive',
					'combined_arms_warfare',
					'tactical_command_structure'
				}
local usa2 = {
					'blitzkrieg',
					'special_forces',
					'assault_concentration'
				}
local usa3 = {
					'operational_level_command_structure',
					'delay_doctrine',
					'integrated_support_doctrine'
				}
-------------------------------------------------------------------
local england1 = {
					'central_planning',
					'grand_battle_plan',
					'special_forces'
				}
local england2 = {
					'delay_doctrine',
					'elastic_defence',
					'mass_assault'
				}
local england3 = {
					'blitzkrieg',
					'mechanized_offensive'
				}
-------------------------------------------------------------------
local france1 = {
					'central_planning',
					'grand_battle_plan'
				}
local france2 = {
					'special_forces',
					'elastic_defence',
					'mass_assault'
				}
local france3 = {
					'blitzkrieg',
					'mechanized_offensive'
				}
-------------------------------------------------------------------
local italy1 = {
					'central_planning',
					'grand_battle_plan'
				}
local italy2 = {
					'delay_doctrine',
					'mass_assault'
				}
-------------------------------------------------------------------
local japan1 = {
					'central_planning',
					'grand_battle_plan'
				}
local japan2 = {
					'mass_assault',
					'special_forces',
					'large_front'					
				}
-------------------------------------------------------------------
local china1 = {
					'large_formations',
					'large_front',
					'human_wave'
				}
				
-------------------------------------------------------------------
----------------------------NAVAL
local destroyer = {
					'destroyer_technology',
					'destroyer_armament',
					'destroyer_antiaircraft',
					'destroyer_engine',
					'destroyer_armour',
					'smallwarship_asw',
					'sea_lane_defence',
					'destroyer_escort_role',
					'destroyer_crew_training',
					'commerce_defence',
					'fleet_auxiliary_submarine_doctrine',
					'spotting',
					'basing'
				}
local light_cruiser = {
					'lightcruiser_technology',
					'lightcruiser_armament',
					'lightcruiser_antiaircraft',
					'lightcruiser_engine',
					'lightcruiser_armour',
					'smallwarship_radar',
					'fleet_auxiliary_carrier_doctrine',
					'light_cruiser_escort_role',
					'light_cruiser_crew_training',
					'basing'
				}
local heavy_cruiser = {
					'heavycruiser_technology',
					'heavycruiser_armament',
					'heavycruiser_antiaircraft',
					'heavycruiser_engine',
					'heavycruiser_armour',
					'largewarship_radar',
					'fleet_auxiliary_submarine_doctrine',
					'cruiser_warfare',
					'cruiser_crew_training'
				}
local battlecruiser = {
					'battlecruiser_technology',
					'capitalship_armament',
					'battlecruiser_antiaircraft',
					'battlecruiser_engine',
					'battlecruiser_armour',
					'largewarship_radar',
					'fleet_auxiliary_submarine_doctrine',
					'cruiser_warfare',
					'cruiser_crew_training'
				}
local battleship = {
					'battleship_technology',
					'capitalship_armament',
					'battleship_antiaircraft',
					'battleship_engine',
					'battleship_armour',
					'super_heavy_battleship_technology',
					'largewarship_radar',
					'sea_lane_defence',
					'battlefleet_concentration_doctrine',
					'battleship_crew_training',
					'fire_control_system_training',
					'commander_decision_making'
				}	
local aircraft_carrier = {
					'cag_development',
					'escort_carrier_technology',
					'carrier_technology',
					'carrier_antiaircraft',
					'carrier_engine',
					'carrier_armour',
					'carrier_hanger',
					'largewarship_radar',
					'fleet_auxiliary_carrier_doctrine',
					'carrier_group_doctrine',
					'carrier_crew_training',
					'carrier_task_force',
					'naval_underway_repleshment',
					'radar_training'
				}
local submarine = {
					'submarine_technology',
					'submarine_antiaircraft',
					'submarine_engine',
					'submarine_hull',
					'submarine_torpedoes',
					'submarine_sonar',
					'submarine_airwarningequipment',
					'fleet_auxiliary_submarine_doctrine',
					'trade_interdiction_submarine_doctrine',
					'submarine_crew_training',
					'unrestricted_submarine_warfare_doctrine',
					'basing',
					'electric_powered_torpedo'
				}
-------------------------------------------------------------------
----------------------------AIR
local tactical_bombers = {
					'multi_role_fighter_development',					
					'twin_engine_aircraft_design',
					'basic_medium_fueltank',
					'basic_twin_engine_airframe',
					'basic_bomb',
					'medium_fueltank',
					'twin_engine_airframe',
					'twin_engine_aircraft_armament',
					'medium_bomb',
					'medium_airsearch_radar',
					'medium_navagation_radar',
					'ground_attack_tactics',
					'tac_pilot_training',
					'tac_groundcrew_training',
					'interdiction_tactics',
					'logistical_strike_tactics',
					'installation_strike_tactics',
					'tactical_air_command',
					'radar_guided_bomb',
					'radar_guided_missile'
				}
local cas_bombers = {
					'cas_development',
					'cas_pilot_training',
					'cas_groundcrew_training',
					'ground_attack_tactics'
				}
local naval_bombers = {
					'nav_development',
					'air_launched_torpedo',
					'nav_pilot_training',
					'nav_groundcrew_training',
					'navalstrike_tactics',
					'portstrike_tactics',
					'naval_tactics',
					'naval_air_targeting'
				}
local strategic_bombers = {
					'basic_strategic_bomber',
					'large_fueltank',
					'four_engine_airframe',
					'strategic_bomber_armament',
					'large_bomb',
					'large_airsearch_radar',
					'large_navagation_radar',
					'heavy_bomber_pilot_training',
					'heavy_bomber_groundcrew_training',
					'strategic_bombardment_tactics',
					'strategic_air_command'
				}
local interceptors = {
					'single_engine_aircraft_design',
					'basic_aeroengine',
					'basic_small_fueltank',
					'basic_single_engine_airframe',
					'basic_aircraft_machinegun',
					'aeroengine',
					'small_fueltank',
					'single_engine_airframe',
					'single_engine_aircraft_armament',
					'small_bomb',
					'advanced_aircraft_design',
					'small_airsearch_radar',
					'small_navagation_radar',
					'drop_tanks',
					'jet_engine',
					'fighter_pilot_training',
					'fighter_groundcrew_training',
					'interception_tactics',
					'fighter_ground_control'			
				}
-------------------------------------------------------------------
----------------------------SECRET DEVELOPMENT
local rocket_secret = {
					'rocket_tests',
					'theorical_jet_engine',
					'rocket_engine',
					'strategic_rocket_development',
					'flyingbomb_development',
					'flyingrocket_development',
					'strategicrocket_engine',
					'strategicrocket_warhead',
					'strategicrocket_structure'
				}
local atomic = {
					'da_bomb',
					'atomic_research',
					'nuclear_research',
					'isotope_seperation',
					'civil_nuclear_research'
				}
local secret = {
					'helecopters',
					'sam',
					'aam',
					'strategic_rocket_development',
					'flyingbomb_development',
					'flyingrocket_development',
					'strategicrocket_warhead',
					'strategicrocket_structure',
					'rocket_tests',
					'rocket_engine',
					'theorical_jet_engine'
				}
								
-------------------------------------------------------------------
----------------------------INDUSTRY
local radar = {
					'radio_technology',
					'radio_detection_equipment',
					'radio',
					'radar'
				}				
local medecine = {
					'medical_evacuation',
					'pilot_rescue',
					'combat_medicine',
					'first_aid'
				}					
local industry = {
					'agriculture',
					'industral_production',
					'industral_efficiency',
					'construction_engineering',
					'advanced_construction_engineering',
					'education',
					'civil_defence'
				}	
local ressources = {
					'oil_to_coal_conversion',
					'oil_refinning',
					'steel_production',
					'raremetal_refinning_techniques',
					'coal_processing_technologies'		
				}	
local supply = {
					'supply_production',
					'supply_transportation',
					'supply_organisation'
				}	
local encryption = {
					'electronic_mechanical_egineering',
					'decryption_machine',
					'encryption_machine'
				}	

					-- took these out because research efficiency is bugged in 1.3
					-- en/decrypt is still there for scenarios where the requirements are already researched
					--'census_tabulation_machine',
					--'mechnical_computing_machine',
					--'electronic_computing_machine',
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function ConstructPriorityList(minister)
	
	--Utils.LUA_DEBUGOUT( "START Function ConstructPriorityList" )
	local ministerTag = tostring(minister:GetCountryTag())
	local ministerCountry = minister:GetCountry()
	local ic_total = ministerCountry:GetTotalIC()
	local year = CCurrentGameState.GetCurrentDate():GetYear()
	
	local list1 = {}
	local list2 = {}
	local list3 = {}
	local priority1 = {}
	local priority2 = {}
	local priority3 = {}
	local templist = {}
	
	
	-- Define here the priorities of each country
	-----------------------------------------------------------------------------------------
	------------------------------------------------GERMANY
	if ministerTag == 'GER' then
		--Utils.LUA_DEBUGOUT( "GERMANY" )		
		-- Level 1 techs
		priority1 = {	
							germany1,
							infantry,
							light_tank,
							medium_tank,
							artillery,
							submarine,
							tactical_bombers,
							cas_bombers,
							interceptors,
							industry,
							encryption,
							supply
					}		
		-- Level 2 techs
		priority2 = {	
							germany2,
							mountain,
							airborne,
							engineer,
							arctic,
							heavy_tank,
							anti_tank,
							anti_aircraft,
							rocket_artillery,
							medecine,
							radar,
							rocket_secret
					}					
		-- Level 3 techs
		priority3 = {	
							germany3,
							marine,
							desert,
							sheavy_tank
					}
					
		-- Conditional Techs
		-- If Germany conquer Soviet Union
		if  tostring(CCurrentGameState.GetProvince( 2613 ):GetController()) == 'GER'	--Controls Paris
		and tostring(CCurrentGameState.GetProvince( 1861 ):GetController()) == 'GER'	--Controls Berlin
		and tostring(CCurrentGameState.GetProvince( 1409 ):GetController()) == 'GER'	--Controls Moskva
		and tostring(CCurrentGameState.GetProvince( 2857 ):GetController()) == 'GER'	--Controls Stalingrad
		and tostring(CCurrentGameState.GetProvince( 782 ):GetController()) ~= 'SOV'		--SOV not controls Leningrad
		then
			--Utils.LUA_DEBUGOUT( "GER VICTORY IN EUROPE" )
			-- Start to consider Naval and Atomic techs
			templist = { light_cruiser, heavy_cruiser,  battleship, aircraft_carrier, atomic, naval_bombers  }
			priority2 = InsertList(priority2, templist)
			templist = { destroyer, battlecruiser, strategic_bombers }
			priority3 = InsertList(priority3, templist)
			
		end
	-----------------------------------------------------------------------------------------
	------------------------------------------------SOVIET
	elseif ministerTag == 'SOV' then
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )
		-- Level 1 techs
		priority1 = {	
							soviet1,
							infantry,
							arctic,
							light_tank,
							medium_tank,
							anti_tank,
							artillery,
							interceptors,
							tactical_bombers,
							industry,
							supply
					}	
		-- Level 2 techs
		priority2 = {	
							soviet2,
							mountain,
							heavy_tank,
							anti_aircraft,
							encryption
					}			
		-- Level 3 techs
		priority3 = {	
							soviet3,
							marine,
							sheavy_tank,
							rocket_artillery,
							medecine,
							radar
					}	
		-- Conditional Techs
		-- If Germany is no more a problem		
		if  tostring(CCurrentGameState.GetProvince( 2613 ):GetController()) ~= 'GER'		--GER not controls Paris
		and tostring(CCurrentGameState.GetProvince( 1928 ):GetController()) ~= 'SOV'		--GER not controls Warsaw
		and tostring(CCurrentGameState.GetProvince( 1409 ):GetController()) == 'SOV'		--Controls Moskva
		and tostring(CCurrentGameState.GetProvince( 2857 ):GetController()) == 'SOV'		--Controls Stalingrad
		and tostring(CCurrentGameState.GetProvince( 782 ):GetController()) == 'SOV'			--Controls Leningrad
		and tostring(CCurrentGameState.GetProvince( 4390 ):GetController()) == 'SOV'		--Controls Vladivostok
		and year >= 1943																	-- After 1943
		then
			--Utils.LUA_DEBUGOUT( "SOV Start Naval and Atomic Projets" )
			-- Start to consider Naval and Atomic techs
			templist = { light_cruiser, heavy_cruiser, submarine, battleship, aircraft_carrier, atomic }
			priority2 = InsertList(priority2, templist)
			templist = { destroyer, naval_bombers, strategic_bombers }
			priority3 = InsertList(priority3, templist)
			
		end
				
	-----------------------------------------------------------------------------------------
	------------------------------------------------UNITED STATES
	elseif ministerTag == 'USA' or ic_total >= 275 then		--More than 275 total IC, use this template
		--Utils.LUA_DEBUGOUT( "UNITED STATES" )
		-- Level 1 techs
		priority1 = {	
							usa1,
							infantry,
							airborne,
							marine,
							engineer,
							jungle,
							light_tank,
							medium_tank,
							anti_tank,
							destroyer,
							light_cruiser,
							battleship,
							aircraft_carrier,
							tactical_bombers,
							interceptors,
							industry,
							encryption,
							supply
					}	
		-- Level 2 techs
		priority2 = {	
							usa2,
							mountain,
							arctic,
							desert,
							artillery,
							heavy_cruiser,
							naval_bombers,
							strategic_bombers,
							medecine,
							radar,
							atomic
					}	
		-- Level 3 techs
		priority3 = {	
							usa3,
							heavy_tank,
							sheavy_tank,
							anti_aircraft,
							submarine
					}	
	-----------------------------------------------------------------------------------------					
	------------------------------------------------UNITED KINGDOM
	elseif ministerTag == 'ENG' then
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )
		-- Level 1 techs
		priority1 = {	
							england1,
							infantry,
							desert,
							anti_tank,
							artillery,
							destroyer,
							light_cruiser,
							heavy_cruiser,
							battleship,
							interceptors,
							encryption,
							radar
					}	
		-- Level 2 techs
		priority2 = {	
							england2,
							airborne,
							marine,
							mountain,
							engineer,
							jungle,
							light_tank,
							medium_tank,
							anti_aircraft,
							naval_bombers,
							strategic_bombers,
							industry,
							supply,
							medecine
					}	
		-- Level 3 techs
		priority3 = {	
							england3,
							arctic,
							aircraft_carrier
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------FRANCE
	elseif ministerTag == 'FRA' then
		--Utils.LUA_DEBUGOUT( "FRANCE" )
		-- Level 1 techs
		priority1 = {	
							france1,
							infantry,
							desert,
							mountain,
							anti_tank,
							artillery,
							light_cruiser,
							heavy_cruiser,
							battleship,
							interceptors,
							medecine,
							encryption	
					}	
		-- Level 2 techs
		priority2 = {	
							france2,
							engineer,
							jungle,
							light_tank,
							medium_tank,
							tactical_bombers,
							supply,
							industry,
							radar
					}			
		-- Level 3 techs
		priority3 = {	
							france3,
							arctic,
							marine,
							anti_aircraft,
							naval_bombers,
							aircraft_carrier
					}			
	-----------------------------------------------------------------------------------------
	------------------------------------------------ITALY
	elseif ministerTag == 'ITA' then
		--Utils.LUA_DEBUGOUT( "ITALY" )
		-- Level 1 techs
		priority1 = {	
							italy1,
							infantry,
							desert,
							mountain,
							anti_tank,
							artillery,
							light_cruiser,
							heavy_cruiser
					}
		-- Level 2 techs
		priority2 = {	
							italy2,
							marine,
							engineer,
							battleship,
							tactical_bombers,
							interceptors,
							supply,
							industry
					}	
		-- Level 3 techs
		priority3 = {	
							arctic,
							light_tank,
							anti_tank,
							anti_aircraft,
							naval_bombers,
							aircraft_carrier,
							medecine,
							encryption,
							radar
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------JAPAN
	elseif ministerTag == 'JAP' then
		--Utils.LUA_DEBUGOUT( "JAPAN" )
		-- Level 1 techs
		priority1 = {	
							japan1,
							infantry,
							marine,
							jungle,
							artillery,
							light_cruiser,
							aircraft_carrier,
							interceptors,
							supply
					}
		-- Level 2 techs
		priority2 = {	
							japan2,
							engineer,
							tactical_bombers,							
							naval_bombers,
							battleship,
							heavy_cruiser,
							submarine,
							industry,
							encryption,
							radar
					}
		-- Level 3 techs
		priority3 = {	
							mountain,							
							desert,
							arctic,
							anti_aircraft,
							destroyer,
							medecine
					}
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINOR WITH 140+ IC
	elseif 	ic_total >= 140 then	
		--Utils.LUA_DEBUGOUT( "MINOR 140+ IC" )
		-- Level 1 techs
		priority1 = {	
							england1,
							infantry,
							artillery,							
							light_cruiser,
							heavy_cruiser,							
							interceptors,
							encryption,
							supply						
					}	
		-- Level 2 techs
		priority2 = {	
							england2,
							marine,
							mountain,
							engineer,						
							light_tank,
							medium_tank,
							anti_tank,
							tactical_bombers,
							destroyer,
							battleship,														
							industry,
							medecine,
							radar
					}	
		-- Level 3 techs
		priority3 = {	
							england3,
							arctic,
							desert,
							jungle,
							anti_aircraft,
							aircraft_carrier,
							naval_bombers
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------CHINE
	elseif ministerTag == 'CHI' then
		--Utils.LUA_DEBUGOUT( "CHINA" )
		-- Level 1 techs
		priority1 = {	
							china1,
							infantry
					}
		-- Level 2 techs				
		priority2 = {	
							militia,
							jungle,
							artillery,
							supply
					}	
		-- Level 3 techs				
		priority3 = {	
							tactical_bombers,
							desert
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------SPAIN
	elseif 	ministerTag == 'SPA' or
			ministerTag == 'SPR' then
		--Utils.LUA_DEBUGOUT( "SPAIN" )
		-- Level 1 techs
		priority1 = {	
							italy1,
							infantry,
							artillery
					}
		-- Level 2 techs				
		priority2 = {	
							italy1,
							mountain,
							light_cruiser,
							heavy_cruiser
					}	
		-- Level 3 techs				
		priority3 = {	
							battleship,
							industry,
							supply,
							tactical_bombers
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINOR WITH 70+ IC
	elseif 	ic_total >= 70 then	
		--Utils.LUA_DEBUGOUT( "MINOR 70+ IC" )
		-- Level 1 techs
		priority1 = {	
							italy1,
							infantry,
							artillery
					}	
		-- Level 2 techs
		priority2 = {	
							italy2,
							mountain,
							engineer,						
							light_tank,													
							destroyer,
							light_cruiser,
							supply	
					}	
		-- Level 3 techs
		priority3 = {	
							arctic,
							desert,
							jungle,
							anti_tank,
							anti_aircraft,
							interceptors,
							tactical_bombers
					}
	-----------------------------------------------------------------------------------------
	------------------------------------------------NORTHERN COUNTRIES
	elseif 	ministerTag == 'FIN' or		--FINLAND
			ministerTag == 'SWE' or		--SWEDEN
			ministerTag == 'NOR' or		--NORWAY
			ministerTag == 'DEN' or		--DENMARK
			ministerTag == 'CAN' then	--CANADA
		--Utils.LUA_DEBUGOUT( "NORTHERN COUNTRY" )
		-- Level 1 techs
		priority1 = {	
							arctic,
							infantry
					}		
		-- Level 2 techs
		priority2 = {	
							artillery,
							destroyer
					}
		-- Level 3 techs			
		priority3 = {	
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------NAVAL/JUNGLE/ISLAND COUNTRIES
	elseif 	ministerTag == 'AST' or		--AUSTRALIA
			ministerTag == 'NZL' or		--NEW ZEALAND
			ministerTag == 'HOL' or		--NETHERLANDS
			ministerTag == 'BEL' or		--BELGIUM
			ministerTag == 'BRA' or		--BRAZIL
			ministerTag == 'ARG' or		--ARGENTINA
			ministerTag == 'MEX' or		--MEXICO
			ministerTag == 'POR' then	--PORTUGAL
		--Utils.LUA_DEBUGOUT( "NAVAL/JUNGLE/ISLAND COUNTRY" )
		-- Level 1 techs
		priority1 = {	
							infantry
					}
		-- Level 2 techs
		priority2 = {	
							artillery,
							jungle,
							light_cruiser
					}	
		-- Level 3 techs
		priority3 = {	
					}													
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINORS IN THE MOUNTAINS
	elseif 	ministerTag == 'AUS' or		--AUSTRIA
			ministerTag == 'SCH' then	--SWITZERLAND
		--Utils.LUA_DEBUGOUT( "COUNTRY IN THE MOUNTAINS" )
		-- Level 1 techs
		priority1 = {	
							infantry
					}	
		-- Level 2 techs
		priority2 = {	
							mountain
					}							
		-- Level 3 techs
		priority3 = {	
							artillery,
							arctic
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINORS WITH NO MILITIA
	elseif 	ministerTag == 'HUN' or		--HUNGARY
			ministerTag == 'ROM' or		--ROMANIA
			ministerTag == 'CZE' or		--CZECH
			ministerTag == 'GRE' or		--GREECE
			ministerTag == 'BUL' or		--BULGARIA
			ministerTag == 'SAF' or		--SOUTH AFRICA
			ministerTag == 'TUR' or		--TURKEY
			ministerTag == 'POL' or		--POLAND
			ministerTag == 'YUG' then	--YUGOSLAVIA
		--Utils.LUA_DEBUGOUT( "MINOR WITH NO MILITIA" )
		-- Level 1 techs
		priority1 = {	
							infantry
					}	
		-- Level 2 techs
		priority2 = {	
							artillery
					}	
		-- Level 3 techs
		priority3 = {	
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------GENERIC MINORS
	else
		--Utils.LUA_DEBUGOUT( "MINOR COUNTRY" )
		-- Level 1 techs
		priority1 = {	
							infantry							
					}	
		-- Level 2 techs
		priority2 = {	
							artillery,
							militia
					}	
		-- Level 3 techs
		priority3 = {	
							arctic,
							desert,
							jungle
					}										
	end	
	-----------------------------------------------------------------------------------------
	--Common conditional techs
	
	-- Allow secret techs to major countries after 1942
	if ic_total >= 120 and year >= 1941 then
		--Utils.LUA_DEBUGOUT( "More than 120 IC and 1942: Secret tech projets" )
			templist = { secret }
			priority3 = InsertList(priority3, templist)	
	end
	
	-----------------------------------------------------------------------------------------
	--Utils.LUA_DEBUGOUT( "Start Construct" )
	
	-- Construct the final table
	
	for i,tech_list in ipairs(priority1) do
			list1 = InsertList(list1, tech_list)
	end
	for j,tech_list in ipairs(priority2) do
			list2 = InsertList(list2, tech_list)
	end
	for k,tech_list in ipairs(priority3) do
			list3 = InsertList(list3, tech_list)
	end	
	
	--Utils.LUA_DEBUGOUT( "EXIT function" )
	return list1, list2, list3
end

function InsertList(list, listB)
	local i = 1
	while listB[i] do
		table.insert(list, listB[i])
		--Utils.LUA_DEBUGOUT( listB[i] )
		i = i + 1
	end
	return list
end

-- Darkzodiak