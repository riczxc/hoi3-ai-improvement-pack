require('helper_functions')

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
					'infantry_warfare',
					'operational_level_organisation'
				}
local militia = {
					'militia_smallarms',
					'militia_support',
					'militia_guns',
					'militia_at',
					'peoples_army',
					'operational_level_organisation'
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
					'mechanised_infantry'
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
					'infantry_activation',
					'at_barrell_sights',
					'at_ammo_muzzel'
				}
local anti_aircraft = {
					'infantry_activation',
					'aa_barrell_ammo',
					'aa_carriage_sights',
					'heavy_aa_guns'
				}
local artillery = {
					'infantry_activation',
					'art_barrell_ammo',
					'art_carriage_sights'
				}
local rocket_artillery = {
					'infantry_activation',
					'rocket_art',
					'rocket_art_ammo',
					'rocket_carriage_sights'
				}
-------------------------------------------------------------------
----------------------------LAND DOCTRINE
local germany1 = {
					'mobile_warfare',
					'spearhead_doctrine',
					'blitzkrieg',
					'schwerpunkt',
					'operational_level_command_structure',
					'elastic_defence'
				}
local germany2 = {
					'tactical_command_structure',
					'combined_arms_warfare',
					'mechanized_offensive',
					'superior_firepower',
					'integrated_support_doctrine',
					'delay_doctrine',
					'large_front'
				}
local germany3 = {
					'special_forces',
					'assault_concentration',
					'central_planning',
					'mass_assault',
					'grand_battle_plan',
					'human_wave'
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
					'industral_production',
					'industral_efficiency',
					'construction_engineering',
					'advanced_construction_engineering'
				}	
local manpower = {
					'agriculture'
}
local leadership = {
					'education'
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
					'supply_organisation',
					'civil_defence'
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

-- Define technologies here which depend on another tech group.
-- So if AI wants to research a tech in group A which depends
-- on group B it knows it has to to research group B to specified
-- level before it can research group A.
local dependencies = {
	-- Infantry
	infantry_activation = {
		militia_smallarms = 1,
		militia_support = 1,
		militia_guns = 1,
		militia_at = 1
	},
	mountain_infantry = {
		smallarms_technology = 1,
		infantry_support = 1,
		infantry_guns = 1,
		infantry_at = 1
	},
	paratrooper_infantry = {
		smallarms_technology = 3,
		infantry_support = 3,
		infantry_guns = 3,
		infantry_at = 3
	},
	night_goggles = {
		radio_technology = 1
	},
	engineer_brigade_activation = {
		industral_production = 1
	},
	mortorised_infantry = {
		cavalry_smallarms = 3,
		cavalry_support = 3,
		cavalry_guns = 3,
		cavalry_at = 3
	},
	desert_warfare_equipment = {
		smallarms_technology = 2,
		infantry_support = 2,
		infantry_guns = 2,
		infantry_at = 2
	},
	jungle_warfare_equipment = {
		smallarms_technology = 2,
		infantry_support = 2,
		infantry_guns = 2,
		infantry_at = 2
	},
	mountain_warfare_equipment = {
		smallarms_technology = 2,
		infantry_support = 2,
		infantry_guns = 2,
		infantry_at = 2
	},
	artic_warfare_equipment = {
		smallarms_technology = 2,
		infantry_support = 2,
		infantry_guns = 2,
		infantry_at = 2
	},
	amphibious_warfare_equipment = {
		marine_infantry = 1
	},
	
	-- Armour
	tank_brigade = {
		lighttank_gun = 2,
		lighttank_engine = 2,
		lighttank_armour = 2,
		lighttank_reliability = 2
	},
	heavy_tank_brigade = {
		tank_gun = 2,
		tank_engine = 2,
		tank_armour = 2,
		tank_reliability = 2
	},
	armored_car_armour = {
		lighttank_brigade = 1
	},
	armored_car_gun = {
		lighttank_brigade = 1
	},
	SP_brigade = {
		lighttank_gun = 3,
		lighttank_engine = 3,
		lighttank_armour = 3,
		lighttank_reliability = 3
	},
	mechanised_infantry = {
		mortorised_infantry = 1,
		tank_brigade = 1,
		smallarms_technology = 3,
		infantry_support = 3,
		infantry_guns = 3,
		infantry_at = 3
	},
	super_heavy_tank_brigade = {
		heavy_tank_gun = 2,
		heavy_tank_engine = 2,
		heavy_tank_armour = 2,
		heavy_tank_reliability = 2
	},
	
	-- Artillery
	rocket_art = {
		art_carriage_sights = 2
	},
	
	-- Naval
	smallwarship_radar = {
		radar = 3
	},
	smallwarship_asw = {
		radar = 3
	},
	super_heavy_battleship_technology = {
		battleship_technology  = 1,
		capitalship_armament = 2,
		battleship_antiaircraft = 2,
		battleship_engine = 2,
		battleship_armour = 2
	},
	cag_development = {
		single_engine_aircraft_design = 1
	},
	largewarship_radar = {
		radar = 3
	},
	
	-- Air
	advanced_aircraft_design = {
		radar = 1
	},
	small_airsearch_radar = {
		radar = 2
	},
	medium_airsearch_radar = {
		radar = 2
	},
	large_airsearch_radar = {
		radar = 2
	},
	jet_engine = {
		aeroengine = 1,
		theorical_jet_engine = 1
	},
	
	-- Industry
	radio_technology = {
		electronic_mechanical_egineering = 1
	},
	census_tabulation_machine = {
		electronic_mechanical_egineering = 1
	},
	mechnical_computing_machine = {
		census_tabulation_machine = 1
	},
	electronic_computing_machine = {
		mechnical_computing_machine = 2
	},
	encryption_machine = {
		mechnical_computing_machine = 1,
		electronic_computing_machine = 1
	},
	decryption_machine = {
		mechnical_computing_machine = 1,
		electronic_computing_machine = 1
	},
	advanced_construction_engineering = {
		industral_production = 3,
		industral_efficiency = 3
	},
	radio_technology = {
		electronic_mechanical_egineering = 1
	},
	
	-- Secret
	strategic_rocket_development = {
		rocket_engine = 1
	},
	flyingbomb_development = {
		strategic_rocket_development = 1
	},
	flyingrocket_development = {
		flyingbomb_development = 1
	},
	strategicrocket_engine = {
		flyingrocket_development = 1
	},
	strategicrocket_warhead = {
		flyingrocket_development = 1
	},
	strategicrocket_structure = {
		flyingrocket_development = 1
	},
	da_bomb = {
		civil_nuclear_research = 4
	},
	radar_guided_missile = {
		rocket_engine = 1,
		cas_development = 1,
		radar = 3,
		aeroengine = 2,
		single_engine_airframe = 2
	},
	radar_guided_bomb = {
		medium_bomb = 3,
		radar = 3,
		aeroengine = 2,
		twin_engine_airframe = 2
	},
	electric_powered_torpedo = {
		submarine_torpedoes = 4,
		submarine_engine = 4
	},
	helecopters = {
		single_engine_airframe = 4,
		aeroengine = 4
	},
	medical_evacuation = {
		helecopters = 1
	},
	pilot_rescue = {
		helecopters = 1
	},
	sam = {
		strategicrocket_engine = 1,
		radar = 3,
		strategicrocket_structure = 1
	},
	aam = {
		strategicrocket_engine = 1,
		radar = 3,
		strategicrocket_structure = 1
	}
}

local theoryTable = {
	naval_engineering_research = {
		'air_launched_torpedo',
		'destroyer_technology',
		'destroyer_armament',
		'destroyer_antiaircraft',
		'destroyer_engine',
		'destroyer_armour',					
		'lightcruiser_technology',
		'lightcruiser_armament',
		'lightcruiser_antiaircraft',
		'lightcruiser_engine',
		'lightcruiser_armour',
		'heavycruiser_technology',
		'heavycruiser_armament',
		'heavycruiser_antiaircraft',
		'heavycruiser_engine',
		'heavycruiser_armour',
		'battlecruiser_technology',
		'battleship_technology',
		'capitalship_armament',
		'battlecruiser_antiaircraft',
		'battlecruiser_engine',
		'battlecruiser_armour',
		'battleship_antiaircraft',
		'battleship_engine',
		'battleship_armour',
		'super_heavy_battleship_technology',
		'escort_carrier_technology',
		'carrier_technology',
		'carrier_antiaircraft',
		'carrier_engine',
		'carrier_armour',
		'carrier_hanger'
	},
	submarine_engineering_research = {
		'submarine_technology',
		'submarine_antiaircraft',
		'submarine_engine',
		'submarine_hull',
		'submarine_torpedoes',
		'electric_powered_torpedo',					
		'air_launched_torpedo'
	},
	aeronautic_engineering_research = {
		'single_engine_aircraft_design',
		'twin_engine_aircraft_design',
		'basic_aeroengine',
		'basic_small_fueltank',
		'basic_single_engine_airframe',
		'basic_aircraft_machinegun',					
		'basic_medium_fueltank',
		'basic_twin_engine_airframe',
		'basic_bomb',
		'multi_role_fighter_development',
		'cas_development',
		'nav_development',
		'basic_four_engine_airframe',
		'basic_strategic_bomber',
		'aeroengine',
		'small_fueltank',
		'single_engine_airframe',
		'single_engine_aircraft_armament',
		'medium_fueltank',
		'twin_engine_airframe',
		'air_launched_torpedo',
		'small_bomb',
		'twin_engine_aircraft_armament',
		'medium_bomb',
		'large_fueltank',
		'four_engine_airframe',
		'strategic_bomber_armament',
		'large_bomb',
		'advanced_aircraft_design',
		'drop_tanks'
	},
	rocket_science_research = {
		'rocket_tests',
		'rocket_engine',
		'rocket_art',
		'rocket_art_ammo',
		'rocket_carriage_sights',
		'strategic_rocket_development',
		'flyingbomb_development',
		'flyingrocket_development',
		'strategicrocket_engine',
		'strategicrocket_warhead',
		'strategicrocket_structure',
		'radar_guided_missile',
		'sam'
	},
	chemical_engineering_research = {
		'oil_to_coal_conversion',
		'oil_refinning',
		'steel_production',
		'raremetal_refinning_techniques',
		'coal_processing_technologies'		
	},
	nuclear_physics_research = {
		'da_bomb',
		'atomic_research',
		'nuclear_research',
		'isotope_seperation',
		'civil_nuclear_research'
	},
	jetengine_research = {
		'jet_engine',
		'theorical_jet_engine'
	},
	mechanicalengineering_research = {
		'agriculture',
		'industral_production',
		'industral_efficiency',
		'construction_engineering',
		'advanced_construction_engineering',
		'supply_production',
		'electronic_mechanical_egineering',
		'decryption_machine',
		'encryption_machine',
		'radio_technology',
		'radio_detection_equipment',
		'radio',
		'census_tabulation_machine',
		'mechnical_computing_machine',
		'electronic_computing_machine'
	},
	automotive_research = {
		'lighttank_brigade',
		'lighttank_gun',
		'lighttank_engine',
		'lighttank_armour',
		'lighttank_reliability',
		'tank_brigade',
		'tank_gun',
		'tank_engine',
		'tank_armour',
		'tank_reliability',
		'heavy_tank_brigade',
		'heavy_tank_gun',
		'heavy_tank_engine',
		'heavy_tank_armour',
		'heavy_tank_reliability',
		'armored_car_armour',
		'armored_car_gun',
		'SP_brigade',
		'super_heavy_tank_brigade',
		'super_heavy_tank_gun',
		'super_heavy_tank_engine',
		'super_heavy_tank_armour',
		'super_heavy_tank_reliability'
	},
	electornicegineering_research = {
		'small_airsearch_radar',
		'medium_airsearch_radar',
		'large_airsearch_radar',
		'small_navagation_radar',
		'medium_navagation_radar',
		'large_navagation_radar',
		'smallwarship_radar',
		'smallwarship_asw',
		'largewarship_radar',
		'submarine_sonar',
		'submarine_airwarningequipment',
		'electronic_mechanical_egineering',
		'radio_technology',
		'radio_detection_equipment',
		'radio',
		'radar',
		'electronic_computing_machine',
		'decryption_machine',
		'encryption_machine'
	},
	artillery_research = {
		'art_barrell_ammo',
		'art_carriage_sights',
		'at_barrell_sights',
		'at_ammo_muzzel',
		'aa_barrell_ammo',
		'aa_carriage_sights',
		'heavy_aa_guns'
	},
	mobile_research = {
		'mechanised_infantry',
		'cavalry_smallarms',
		'cavalry_support',
		'cavalry_guns',
		'cavalry_at',
		'mortorised_infantry'
	},
	militia_research = {
		'militia_smallarms',
		'militia_support',
		'militia_guns',
		'militia_at'
	},
	infantry_research = {
		'basic_aircraft_machinegun',
		'twin_engine_aircraft_armament',
		'strategic_bomber_armament',
		'infantry_activation',
		'smallarms_technology',
		'infantry_support',
		'infantry_guns',
		'infantry_at',
		'mountain_infantry',
		'marine_infantry',
		'paratrooper_infantry',
		'night_goggles',
		'engineer_brigade_activation',
		'engineer_bridging_equipment',
		'engineer_assault_equipment',
		'imporved_police_brigade'
	}
}
------------------------------------------------------------------------------------
------------------------------------------------------------------------------------
function ConstructTechScoreTable(minister)
	
	--Utils.LUA_DEBUGOUT( "START Function ConstructPriorityList" )
	local ministerTag = minister:GetCountryTag()
	local tag = tostring(ministerTag)
	local ministerCountry = minister:GetCountry()
	local totalIC = ministerCountry:GetTotalIC()
	local baseIC = ministerCountry:GetMaxIC()
	local year = CCurrentGameState.GetCurrentDate():GetYear()
	
	local priority = {}
	local templist = {}
	
	
	-- Define here the priorities of each country
	-----------------------------------------------------------------------------------------
	------------------------------------------------GERMANY
	if tag == 'GER' then
		--Utils.LUA_DEBUGOUT( "GERMANY" )		
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
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
			templist = { light_cruiser, heavy_cruiser, battleship, aircraft_carrier, atomic, naval_bombers  }
			priority[2] = InsertList(priority[2], templist)
			templist = { destroyer, battlecruiser, strategic_bombers }
			priority[3] = InsertList(priority[3], templist)
			
		end
	-----------------------------------------------------------------------------------------
	------------------------------------------------SOVIET
	elseif tag == 'SOV' then
		--Utils.LUA_DEBUGOUT( "SOVIET UNION" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
							soviet2,
							mountain,
							heavy_tank,
							anti_aircraft,
							encryption
					}			
		-- Level 3 techs
		priority[3] = {	
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
			priority[2] = InsertList(priority[2], templist)
			templist = { destroyer, naval_bombers, strategic_bombers }
			priority[3] = InsertList(priority[3], templist)
			
		end
				
	-----------------------------------------------------------------------------------------
	------------------------------------------------UNITED STATES
	elseif tag == 'USA' or totalIC >= 275 then		--More than 275 total IC, use this template
		--Utils.LUA_DEBUGOUT( "UNITED STATES" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
							usa3,
							heavy_tank,
							sheavy_tank,
							anti_aircraft,
							submarine
					}	
	-----------------------------------------------------------------------------------------					
	------------------------------------------------UNITED KINGDOM
	elseif tag == 'ENG' then
		--Utils.LUA_DEBUGOUT( "UNITED KINGDOM" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
							england3,
							arctic,
							aircraft_carrier
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------FRANCE
	elseif tag == 'FRA' then
		--Utils.LUA_DEBUGOUT( "FRANCE" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
							france3,
							arctic,
							marine,
							anti_aircraft,
							naval_bombers,
							aircraft_carrier
					}			
	-----------------------------------------------------------------------------------------
	------------------------------------------------ITALY
	elseif tag == 'ITA' then
		--Utils.LUA_DEBUGOUT( "ITALY" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
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
	elseif tag == 'JAP' then
		--Utils.LUA_DEBUGOUT( "JAPAN" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
							mountain,							
							desert,
							arctic,
							anti_aircraft,
							destroyer,
							medecine
					}
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINOR WITH 140+ IC
	elseif 	totalIC >= 140 then	
		--Utils.LUA_DEBUGOUT( "MINOR 140+ IC" )
		-- Level 1 techs
		priority[1] = {	
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
		priority[2] = {	
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
		priority[3] = {	
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
	elseif tag == 'CHI' then
		--Utils.LUA_DEBUGOUT( "CHINA" )
		-- Level 1 techs
		priority[1] = {	
							china1,
							infantry
					}
		-- Level 2 techs				
		priority[2] = {	
							militia,
							jungle,
							artillery,
							supply
					}	
		-- Level 3 techs				
		priority[3] = {	
							tactical_bombers,
							desert
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------SPAIN
	elseif 	tag == 'SPA' or
			tag == 'SPR' then
		--Utils.LUA_DEBUGOUT( "SPAIN" )
		-- Level 1 techs
		priority[1] = {	
							italy1,
							infantry,
							artillery
					}
		-- Level 2 techs				
		priority[2] = {	
							italy2,
							mountain,
							light_cruiser,
							heavy_cruiser
					}	
		-- Level 3 techs				
		priority[3] = {	
							battleship,
							industry,
							supply,
							tactical_bombers
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINOR WITH 70+ IC
	elseif 	totalIC >= 70 then	
		--Utils.LUA_DEBUGOUT( "MINOR 70+ IC" )
		-- Level 1 techs
		priority[1] = {	
							italy1,
							infantry,
							artillery
					}	
		-- Level 2 techs
		priority[2] = {	
							italy2,
							mountain,
							engineer,						
							light_tank,													
							destroyer,
							light_cruiser,
							supply	
					}	
		-- Level 3 techs
		priority[3] = {	
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
	elseif 	tag == 'FIN' or		--FINLAND
			tag == 'SWE' or		--SWEDEN
			tag == 'NOR' or		--NORWAY
			tag == 'DEN' or		--DENMARK
			tag == 'CAN' then	--CANADA
		--Utils.LUA_DEBUGOUT( "NORTHERN COUNTRY" )
		-- Level 1 techs
		priority[1] = {	
							arctic,
							infantry
					}		
		-- Level 2 techs
		priority[2] = {	
							artillery,
							destroyer
					}
		-- Level 3 techs			
		priority[3] = {
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------NAVAL/JUNGLE/ISLAND COUNTRIES
	elseif 	tag == 'AST' or		--AUSTRALIA
			tag == 'NZL' or		--NEW ZEALAND
			tag == 'HOL' or		--NETHERLANDS
			tag == 'BEL' or		--BELGIUM
			tag == 'BRA' or		--BRAZIL
			tag == 'ARG' or		--ARGENTINA
			tag == 'MEX' or		--MEXICO
			tag == 'POR' then	--PORTUGAL
		--Utils.LUA_DEBUGOUT( "NAVAL/JUNGLE/ISLAND COUNTRY" )
		-- Level 1 techs
		priority[1] = {	
							infantry
					}
		-- Level 2 techs
		priority[2] = {	
							artillery,
							jungle,
							light_cruiser
					}	
		-- Level 3 techs
		priority[3] = {
					}													
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINORS IN THE MOUNTAINS
	elseif 	tag == 'AUS' or		--AUSTRIA
			tag == 'SCH' then	--SWITZERLAND
		--Utils.LUA_DEBUGOUT( "COUNTRY IN THE MOUNTAINS" )
		-- Level 1 techs
		priority[1] = {	
							infantry
					}	
		-- Level 2 techs
		priority[2] = {	
							mountain
					}							
		-- Level 3 techs
		priority[3] = {	
							artillery,
							arctic
					}	
	-----------------------------------------------------------------------------------------
	------------------------------------------------MINORS WITH NO MILITIA
	elseif 	tag == 'HUN' or		--HUNGARY
			tag == 'ROM' or		--ROMANIA
			tag == 'CZE' or		--CZECH
			tag == 'GRE' or		--GREECE
			tag == 'BUL' or		--BULGARIA
			tag == 'SAF' or		--SOUTH AFRICA
			tag == 'TUR' or		--TURKEY
			tag == 'POL' or		--POLAND
			tag == 'YUG' then	--YUGOSLAVIA
		--Utils.LUA_DEBUGOUT( "MINOR WITH NO MILITIA" )
		-- Level 1 techs
		priority[1] = {	
							infantry
					}	
		-- Level 2 techs
		priority[2] = {	
							artillery
					}	
		-- Level 3 techs
		priority[3] = {	
					}							
	-----------------------------------------------------------------------------------------
	------------------------------------------------GENERIC MINORS
	else
		--Utils.LUA_DEBUGOUT( "MINOR COUNTRY" )
		-- Level 1 techs
		priority[1] = {	
							infantry							
					}	
		-- Level 2 techs
		priority[2] = {	
							artillery,
							militia
					}	
		-- Level 3 techs
		priority[3] = {	
							arctic,
							desert,
							jungle
					}										
	end	
	-----------------------------------------------------------------------------------------
	--Common conditional techs
	
	-- Allow secret techs to major countries after 1942
	if totalIC >= 120 and year >= 1941 then
		--Utils.LUA_DEBUGOUT( "More than 120 IC and 1942: Secret tech projets" )
		table.insert(priority[3], secret)
	end
	
	-----------------------------------------------------------------------------------------
	-- Construct the final table
	-- Utils.LUA_DEBUGOUT( "Start Construct" )
	local techScoreTable = { }
	for i = table.getn(priority), 1, -1 do
		for _,tech_list in ipairs(priority[i]) do
			local score = 2 + table.getn(priority) - i
			for _,tech in ipairs(tech_list) do
				techScoreTable[tech] = score
			end
		end
	end	
	local maxPrio = 1 + table.getn(priority)
	-- Utils.LUA_DEBUGOUT("maxPrio: " .. maxPrio)
	-----------------------------------------------------------------------------------------
	-- Add resource techs
	local resourceTechs = {
		coal_processing_technologies = CGoodsPool._ENERGY_,
		steel_production = CGoodsPool._METAL_,
		raremetal_refinning_techniques = CGoodsPool._RARE_MATERIALS_,
		oil_to_coal_conversion = CGoodsPool._ENERGY_,
		oil_refinning = CGoodsPool._FUEL_
	}
	
	for tech,resource in pairs(resourceTechs) do
		if not techScoreTable[tech] then
			if 	ExistsImport(ministerTag, resource) or (
					GetAverageBalance(ministerCountry, resource) < 0 and
					not ExistsExport(ministerTag, resource)
				)
			then
				techScoreTable[tech] = maxPrio - 1 -- medium
			else
				-- Does our faction need this resource?
				local faction = ministerCountry:GetFaction()
				if 	faction == CCurrentGameState.GetFaction('axis')
				or	faction == CCurrentGameState.GetFaction('allies')
				or	faction == CCurrentGameState.GetFaction('comintern')
				then
					if GetFactionBalance(faction, resource) < 0 then
						techScoreTable[tech] = maxPrio - 1 -- medium
					end
				end
			end
		end
	end
	
	if not techScoreTable['supply_production'] then
		if	ExistsExport(ministerTag, CGoodsPool._SUPPLIES_) or  
			(ministerCountry:GetProductionDistributionAt(CDistributionSetting._PRODUCTION_SUPPLY_):GetNeeded():Get() / baseIC) > 0.20 -- 20% of IC into supplies
		then
			techScoreTable['supply_production'] = maxPrio - 1 -- medium
		else
			techScoreTable['supply_production'] = 2 -- minor
		end
	end
	-- Utils.LUA_DEBUGOUT("Resources finished")
	-----------------------------------------------------------------------------------------
	-- Add industry techs
	if not techScoreTable['construction_engineering'] then
		-- If we have enough resources, make it at least possible to build up our IC.
		if IsResourceRich(ministerCountry) then
			techScoreTable['construction_engineering'] = maxPrio
		end
	end
	if not techScoreTable['advanced_construction_engineering'] then
		-- If we have enough manpower base decision on average infrastructure. If not then
		-- go for it. Building infra is better than sitting on supplies...
		if HasExtraManpowerLeft(ministerCountry) then
			techScoreTable['advanced_construction_engineering'] = math.min(maxPrio * (1.5 - GetAverageInfrastructure(ministerCountry)), maxPrio * 1.1) -- at max 10% more than max
		else
			techScoreTable['advanced_construction_engineering'] = maxPrio * 1.1 -- 10% more than max
		end
	end
	-- Utils.LUA_DEBUGOUT("Industry finished")
	-----------------------------------------------------------------------------------------
	-- Add manpower tech
	if not techScoreTable['agriculture'] then
		techScoreTable['agriculture'] = math.min(maxPrio * (2 - ministerCountry:GetManpower():Get() / (2 * baseIC)), maxPrio * 1.2) -- 20% more than max
	end
	-- Utils.LUA_DEBUGOUT("Manpower finished")
	-----------------------------------------------------------------------------------------
	-- Add leadership tech
	if not techScoreTable['education'] then
		techScoreTable['education'] = maxPrio -- Always good
	end
	-- Utils.LUA_DEBUGOUT("Leadership finished")
	-----------------------------------------------------------------------------------------
	-- Add repair tech
	if not techScoreTable['civil_defence'] then
		if ministerCountry:IsAtWar() then
			techScoreTable['civil_defence'] = maxPrio - 1
		end
	end
	-- Utils.LUA_DEBUGOUT("Repair finished")
	-----------------------------------------------------------------------------------------
	-- Add dependend techs
	local techStatus = ministerCountry:GetTechnologyStatus()
	local dependendTechs = {}
	for tech,score in pairs(techScoreTable) do
		if dependencies[tech] then
			for dep,lvl in pairs(dependencies[tech]) do
				if not techScoreTable[dep] or techScoreTable[dep] < score then
					local depTech = GetTechByName(dep)
					if techStatus:GetLevel(depTech) < lvl then
						dependendTechs[dep] = score + 0.5
					end
				end
			end
		end
	end
	for tech,score in pairs(dependendTechs) do
		techScoreTable[tech] = score
	end
	-- Utils.LUA_DEBUGOUT("Dependencies finished")
	-----------------------------------------------------------------------------------------
	-- Utils.LUA_DEBUGOUT( "EXIT function" )
	return techScoreTable
end

function GetTechsForTheoryTech(theoryTechName)
	if theoryTable[theoryTechName] then
		return theoryTable[theoryTechName]
	else
		return {}
	end
end

function GetCategoryNameForTheoryTech(theoryTechName)
	if theoryTechName == 'naval_engineering_research' then
		return 'naval_engineering'
	elseif theoryTechName == 'submarine_engineering_research' then
		return 'submarine_engineering'
	elseif theoryTechName == 'aeronautic_engineering_research' then
		return 'aeronautic_engineering'
	elseif theoryTechName == 'rocket_science_research' then
		return 'rocket_science'
	elseif theoryTechName == 'chemical_engineering_research' then
		return 'chemical_engineering'
	elseif theoryTechName == 'nuclear_physics_research' then
		return 'nuclear_physics'
	elseif theoryTechName == 'jetengine_research' then
		return 'jetengine_theory'
	elseif theoryTechName == 'mechanicalengineering_research' then
		return 'mechanicalengineering_theory'
	elseif theoryTechName == 'automotive_research' then
		return 'automotive_theory'
	elseif theoryTechName == 'electornicegineering_research' then
		return 'electornicegineering_theory'
	elseif theoryTechName == 'artillery_research' then
		return 'artillery_theory'
	elseif theoryTechName == 'mobile_research' then
		return 'mobile_theory'
	elseif theoryTechName == 'militia_research' then
		return 'militia_theory'
	elseif theoryTechName == 'infantry_research' then
		return 'infantry_theory'
	else
		return nil
	end
end

function InsertList(list1, list2)
	for _,v in ipairs(list2) do
		table.insert(list1, v)
	end
end
-- Darkzodiak