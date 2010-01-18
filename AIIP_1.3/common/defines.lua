defines = {

start_date = '1936.1.1',
end_date = '1948.1.1',

land_combat = 'land_doctrine_practical',
naval_combat = 'naval_doctrine_practical',
air_combat = 'air_doctrine_practical',
bombing = 'air_doctrine_practical',

base_militia = 'militia_brigade',

country = {
	CORE_LOSE 				= 50,
	CORE_GAIN 				= 50,
	YEARS_OF_NATIONALISM 	= 20,   -- Years of Nationalism
	YEARS_UNTIL_BROKEN 		= 2,    -- Years until rebel held capital results in broken country.
	REBEL_ACCEPTANCE_MONTHS = 60,
	ELECTION_RANDOMNESS 	= 0.15,
	ELECTION_MINISTER_DISSENT_PENALTY = -0.1,
	MAX_NUMBER_OF_SPIES 	= 10,
	SPY_DETECTION_CHANCE 	= 0.1,
	SPY_MISSION_CHANGE_DAYS = 7,
	SPY_CONNECTION_DETECTION_CHANCE 	 = 0.5,
	SPY_BASE_CONNECTION_DETECTION_CHANCE = 0.5,
	SPY_UNIT_DETECTION_CHANCE 		= 0.5,
	SPY_INTEL_MISSION_BONUS 		= 0.5,   -- % better when focusing on a field
	SPY_PARTY_ORGANIZATION_BOOST 	= 0.01,
	BASE_TECH_DECAY 				= -0.025,  -- how many percent lost each month in tech categories.
	NUKE_UNITY_IMPACT	= 1.0,		-- impact from being nukes.
	MOBILIZE_THREAT_IMPACT = 5.0,	-- threat from when mobilizing.
	SPY_THREAT_INCREASE_ACTION = 0.01,	-- daily threat increase from spy action
	POPULARITIY_RANDOMNESS = 10,
	PARTY_POP_CHANGE_RATE = 10, -- Inversly affects how fast party popularity gets closer to organisation
	MOBILIZATION_BONUS_DAYS = 30, -- Number of days reinforcements benefit from mobilization
	NO_MISSION_SPY_DETECTION_MULTIPLIER = 0.1 -- The risk of being detected is multiplied with this number when not performing any missions
},

economy = {
	MAX_PROVINCE_SELL_PRICE 	= 2000,
	LEADERSHIP_TO_DIPLOMACY 	= 0.5,	 -- Leadership to Diplomatic Influence factor.
	IC_TO_MONEY 				= 0.05,
	IC_TO_CONSUMER_GOODS 		= 5.0,
	IC_TO_SUPPLIES 				= 7.0,
	CONVOY_BUILD_COST 			= 2,
	CONVOY_BUILD_TIME 			= 40,
	ESCORT_BUILD_COST 			= 3,
	ESCORT_BUILD_TIME 			= 50,
	LEADERSHIP_TO_SPIES 		= 0.05,
	BUILDING_REPAIR_SPEED 		= 0.1,
	LEADERSHIP_TO_OFFICERS 		= 6,
	THREAT_FROM_CONVOYS_MODIFIER	= 0.1,
	CONVOY_CONSTRUCTION_SIZE 	= 10,
	MAX_DAILY_TRADE				= 100

},

military = {
	MAX_MANPOWER = 10,
	HISTORICAL_MODEL_MAX = 10, 	-- historical models max
	BASE_CHANCE_TO_AVOID_HIT = 0.8,	-- Base chance to avoid hit if defences left.
	CHANCE_TO_AVOID_HIT_AT_NO_DEF = 0.6,	-- chance to avoid hit if no defences left.
	RIVER_CROSSING_PENALTY = -0.5,	-- base river crossing penalty.
	AMPHIBIOUS_LANDING_PENALTY = -0.6,	-- amphibious landing penalty
	PARADROP_PENALTY = -0.5,	-- paradrop penalty
	MULTIPLE_COMBATS_PENALTY = 0.5,	-- multiple combat modifier
	ENVELOPMENT_PENALTY = 0.1,	-- envelopment penalty, for each direction.
	ENCIRCLED_PENALTY = 0.1,	-- for completely encircled units.
	DIG_IN_FACTOR = 0.02,	-- dig-in factor.
	COMBAT_SUPPLY_LACK_IMPACT = 0.5,	--combat penalty factor on lack of supplies.
	COMBAT_DISSENT_IMPACT = 0.02,	-- dissent modifier in combat.
	COMBINED_ARMS_BONUS = 0.2,	--combined arms
	SUPPLY_TAX = 0.1,	-- supplies cost for moving through a province.
	SUPPLYPOOL_DAYS = 30,	-- days of supply.
	RADAR_RANGE = 0.18,
	BASE_RADIO_STRENGTH = 10,
	EXP_GAIN_LAND = 0.15,
	EXP_GAIN_NAVAL = 4.0,
	EXP_GAIN_AIR = 0.2,
	EXP_GAIN_DIV = 1.5,
	EXP_GAIN_LEADER = 100.0,
	LAND_SPEED_MODIFIER = 0.05,
	NAVAL_SPEED_MODIFIER = 0.5,
	AIR_SPEED_MODIFIER = 0.3,	
	MINIMUM_STRENGTH = 50,	--minimum strength of a land division at production.  50 = 5000 men.
	BRIGADES_IN_DIVISION = 4,	--number of allowed brigades in a division.
	COMBAT_LEADER_IMPACT = 0.05,	
	COMBAT_MOVEMENT_SPEED = 0.33,	
	COMBAT_PUSHBACK_DAMAGE = 1.0,	
	COMBAT_PUSHBACK_CHANCE_FOR_DAMAGE = 50,	-- 10 = 10%
	UNIT_ATTACK_DELAY = 168,
	UNIT_ATTACK_DELAY_MODIFY = 10,
	UNIT_DIGIN_CAP = 10,
	BOMB_STRATEGIC_RESOURCES = 0.25,
	BOMB_STRATEGIC_PRODUCTION = 0.01,
	BOMB_STRATEGIC_BUILDINGS = 0.01,
	OFFICER_COMBAT_LOSS = 0.007,
	AGGRESSIVE_ORGANISATION_LIMIT = 0.05,
	DEFENSIVE_ORGANISATION_LIMIT = 0.3,
	PASSIVE_ORGANISATION_LIMIT = 0.6,
	AGGRESSIVE_STRENGTH_LIMIT = 0.05,
	DEFENSIVE_STRENGTH_LIMIT = 0.3,	
	PASSIVE_STRENGTH_LIMIT = 0.6,
	LAND_COMBAT_THREAT_IMPACT = 0.25,
	NAVAL_COMBAT_THREAT_IMPACT = 0.5,
	AIR_COMBAT_THREAT_IMPACT = 0.025,
	BOMBING_THREAT_IMPACT = 0.15,
	LAND_DOCTRINE_INCREASE = 0.001,
	NAVAL_DOCTRINE_INCREASE = 0.01,
	AIR_DOCTRINE_INCREASE = 0.01,
	BOMBING_DOCTRINE_INCREASE = 0.01,
	COMBAT_DIFFICULTY_IMPACT = 0.2,
	BASE_COMBAT_WIDTH = 10,
	ADDITIONAL_COMBAT_WIDTH = 5,
	RETREAT_PROGRESS = 0.9,
	BASE_NIGHT_PENALTY = -0.5,
	BASE_FORT_PENALTY = -0.09,
	BASE_STACKING_PENALTY = -0.05,
	RADAR_COMBAT_IMPACT = 0.05,
	COMBAT_EVENT_DURATION = 8,
	STRAT_RAIDER_FOUGHT_IMPACT = 0.1,
	STRAT_BOMBER_FOUGHT_IMPACT = 0.1,
	STRAT_AIR_RAIDER_FOUGHT_IMPACT = 0.1,
	STRAT_NO_ALLIES_HELP_PENALTY = -0.001,
	STRAT_ALLIES_HELP = 0.1,
	STRAT_BOMBING_PENALTY = -0.05,
	STRAT_CONVOY_DAMAGE = -0.03,
	LAND_COMBAT_ORG_DICE_SIZE = 3,
	LAND_COMBAT_STR_DICE_SIZE = 2,
	LAND_COMBAT_STR_ARMOR_ON_SOFT_DICE_SIZE = 2,
	LAND_COMBAT_ORG_ARMOR_ON_SOFT_DICE_SIZE = 5,
	LAND_COMBAT_STR_DAMAGE_MODIFIER = 0.15,
	LAND_COMBAT_ORG_DAMAGE_MODIFIER = 1.0,
	AIR_COMBAT_ORG_DICE_SIZE = 8,
	AIR_COMBAT_STR_DICE_SIZE = 3,
	AIR_COMBAT_CRITICAL_HIT_DAMAGE_MUL = 10,
	AIR_COMBAT_CRITICAL_HIT_DAMAGE_CHANCE = 10,
	AIR_COMBAT_ORG_DAMAGE_MODIFIER = 2.5,
	AIR_COMBAT_STR_DAMAGE_MODIFIER = 2.0,
	NAVAL_COMBAT_ORG_DICE_SIZE = 8,
	NAVAL_COMBAT_STR_DICE_SIZE = 3,
	NAVAL_COMBAT_CRITICAL_HIT_DAMAGE_MUL = 10,
	NAVAL_COMBAT_CRITICAL_HIT_DAMAGE_CHANCE = 10,
	NAVAL_COMBAT_ORG_DAMAGE_MODIFIER = 1,
	NAVAL_COMBAT_STR_DAMAGE_MODIFIER = 1,
	AIR_COMBAT_ON_BOMBING = -0.1,
	BASE_PROXIMITY_BONUS = 0.1,
	INTERCEPT_ATTACK_BONUS = 0.2,
	AIR_SUP_DEFEND_BONUS = 0.2,
	SHORE_BOMBARDMENT_MOD = -0.001,
	SHORE_BOMBARDMENT_CAP = -0.25,
	AIR_STACKING_PENALTY = -0.10,
	NAVAL_STACKING_PENALTY = -0.02,
	STRAT_REDEP_BASE_SPEED = 20,
	STRAT_REDEP_SUPPLY_MOD = 2.0,
	STRAT_REDEP_ORG_LOSS = 0.02,
	AIR_RANK_1 = 4,
	AIR_RANK_2 = 8,
	AIR_RANK_3 = 12,
	AIR_RANK_4 = 16,
	NAVAL_RANK_1 = 6,
	NAVAL_RANK_2 = 12,
	NAVAL_RANK_3 = 18,
	NAVAL_RANK_4 = 30,
	RADIO_CORPS_LEADER_DISTANCE = 100,
	RADIO_ARMY_LEADER_DISTANCE = 200,
	RADIO_ARMYGROUP_LEADER_DISTANCE = 300,
	RADIO_THEATHRE_LEADER_DISTANCE = 1000,
	
	OWNED_AND_CONTROLLED_THROUGHPUT_CAP_BONUS = 2,
	INFRA_THROUGHPUT_IMPACT = 4,
	SURPRISE_BONUS = 0.33


},

diplomacy = {
	WARDEC_BELIGERENCY = 40.0, 
	WARDEC_WAR_DIPLOMACY_HIT = 100.0,
	WARDEC_INFLUENCE_COST = 0.0,
	JOIN_ALLIANCE_INFLUENCE_COST = 5.0,
	LEAVE_ALLIANCE_INFLUENCE_COST = 1.0,
	GUARANTEE_INFLUENCE_COST = 5.0,
	REVOKE_GUARANTEE_INFLUENCE_COST = 1.0,
	CALLALLY_INFLUENCE_COST = 10.0,
	NAP_INFLUENCE_COST = 5.0,
	PURCHASE_INFLUENCE_COST = 0.0,
	EMBARGO_INFLUENCE_COST = 5.0,
	MILACCESS_INFLUENCE_COST = 1.0,
	INFLUENCE_INFLUENCE_COST = 3.0,
	RELATION_INFLUENCE_COST = 1.0,
	JOINBLOCK_INFLUENCE_COST = 5.0,	
	ALLIANCE_NEUTRALITY_LIMIT = 25.0,
	ALLIANCE_RELATION_CHANGE = 15.0,
	ALLIANCE_REJECT_RELATION_CHANGE = -50.0,
	GUARANTEE_NEUTRALITY_LIMIT = 60.0,
	NAP_RELATION_CHANGE = 50.0,
	LEAVE_NAP_RELATION_CHANGE = -30.0,
	NAP_JOIN_INFLUENCE_COST = 5.0,
	NAP_REJECT_RELATION_CHANGE = -20.0,
	LEAVE_NAP_INFLUENCE_COST = 1.0,
	LEAVE_NAP_THREAT_COST = 5.0,
	MILACC_ACCEPT_RELATION_CHANGE = 10,
	MILACC_DECLINE_RELATION_CHANGE = -10,
	MILACC_CANCEL_RELATION_CHANGE = -20,
	REVOKE_GUARANTEE_RELATION_CHANGE = -20,
	DAYS_OF_INFLUENCE_RELATION_CHANGE = -1,
	DAYS_OF_ALIGN_RELATION_CHANGE = 90,
	ALIGN_INFLUENCE_COST = 1.0,
	EMBARGO_RELATION_CHANGE = -30.0,
	EMBARGO_NETRALITY = 30.0,
	EMBARGO_THREAT_COST = 1.0,
	JOIN_FACTION_INFLUENCE_COST = 0,
	INVITE_FACTION_INFLUENCE_COST = 0,
	JOIN_FACTION_NEUTRALITY = 50.0,
	INVITE_FACTION_NEUTRALITY = 50.0,
	TRADE_RELATION_CHANGES = 15.0,
	TRADE_INFLUENCE_COST = 3.0,
	TRADE_CANCEL_INFLUENCE_COST = 1.0,
	TRADE_CANCEL_RELATION_COST = 15.0,
	EXPEDITION_INFLUENCE_COST = 1.0,
	EXPEDITION_RETURN_TIME = 30.0,
	EXPEDITION_RECLAIM_TIME = 30.0,
	LICENCE_INFLUENCE_COST = 1.0,
	ALLOW_DEBT_INFLUENCE_COST = 1.0, 
	REVOKE_DEBT_INFLUENCE_COST = 1.0,
	YEARS_TO_REPAY_DEBT = 50.0,
	INFLUENCE_UPKEEP = 1.0,
	REGULAR_CONSTRUCTION_THREAT_IMPACT = 1.0,
	NEUT_INCREASE_DIFF_CONTINENT = 10,
	NEUT_REDUCTION_AT_CLAIMS = 20


},  

alignment = {
	ALIGNMENT_INTERVAL = 24,
	RELATION_WEIGHT = 0.02,
	IDEOLOGY_WEIGHT = 1.25,
	PROXIMITY_WEIGHT = 0.02,
	REVANCHISM_WEIGHT = 1.0,
	THREAT_WEIGHT = 0.15,
	REPULSION_WEIGHT = 0.01,
	FACTION_JOIN_DIST = 50.0,
	WAR_THREAT = 35.0,
	LARGE_COUNTRY_IC = 300.0 -- used to scale threat impact with country IC
},

map = {
	SUEZ = 11381,
	SUEZ_BLOCKER = 5612,
	PANAMA = 11383,
	PANAMA_BLOCKER = 7717,
	BALTIC = 10517,
	BALTIC_BLOCKER = 1482,
	BLACKSEA = 11382,
	BLACKSEA_BLOCKER = 4503,
	GIBRALTAR = 10559,
	GIBRALTAR_BLOCKER = 5191
},


weather = {
	PRESSUREMIN 			= 870,	                           
	PRESSUREMAX 			= 1090,                                   
	PRESSUREDEFAULT 		= 1013,                                   
	PRESSURESTEP			= 5,                                      
	PRESSUREREDUCTION		= 2,                                      
	PRESSUREPROPAGATION 	= 10,                                     
	PRESSURETHRESHOLD 		= 300,                                    
	MAXHUMIDITY 			= 100,                                    
	MINHUMIDITY 			= 0,                                      
	MAXFROMEACHPRESSURE 	= 8,                                      
	HIGHTEMPERATUREATTRITIONTHRESHOLD 	= 30,     
	LOWTEMPERATUREATTRITIONTHRESHOLD 	= -10,    
	WINDATTRITIONTHRESHOLD 				= 30,     
	CLOUDCOVERAGETEMPERATUREDROP 		= 8,      
	LANDRAINIMPACTMODIFIER				= 0.005, 
	LANDRAINIMPACTCAP 					= 0.90,   
	LANDLOWTEMPERATURETHRESHOLD 		= -1,     
	LANDLOWTEMPERATUREIMPACT			= 0.05,    
	LANDHIGHTEMPERATURETHRESHOLD 		= 20,     
	LANDHIGHTEMPERATUREIMPACT 			= 0.05,    
	AIRLOWTEMPERATURETHRESHOLD 			= -5,     
	AIRLOWTEMPERATUREIMPACT 			= 0.2,    
	AIRHIGHTEMPERATURETHRESHOLD 		= 30,   
	AIRHIGHTEMPERATUREIMPACT 			= 0.2,  
	AIRWINDSPEEDMODIFIER 				= 0.025,
	AIRCLOUDMODIFIER 					= 0.25, 
	AIRRAINMODIFIER 					= 0.05, 
	BOMBLOWTEMPERATURETHRESHOLD 		= -5,   
	BOMBLOWTEMPERATUREIMPACT 			= 0.2,  
	BOMBHIGHTEMPERATURETHRESHOLD 		= 30,   
	BOMBHIGHTEMPERATUREIMPACT 			= 0.2,  
	BOMBWINDSPEEDMODIFIER 				= 0.025,
	BOMBCLOUDMODIFIER 					= 0.25,  
	BOMBRAINMODIFIER 					= 0.05,  
	NAVALWINDSPEEDMODIFIER 				= 0.001,  
	NAVALRAINMODIFIER 					= 0.33,  
	MUDDYNESSMOVEMENTMODIFIER 			= -0.75, 
	HOURLYFROZENINCREASE 				= 0.01,  
	HOURLYTHAW 							= 0.01,  
	TEMPERATURECHANGESPEED 				= 0.1,   
	WEATHERMOVEMENTDELAY 				= 2,     
	LOWPRESSUREBASE 					= 100,   
	LOWPRESSUREOFFSET 					= 100,   
	ALLOWEDTOFLYTHRESHOLD 				= 0.8,   
	SPOTTINGCLOUDMODIFIER 				= 0.2,   
	SPOTTINGRAINMODIFIER 				= 0.2,   
	MUDDYNESSSUPPLYTAXMODIFIER			= 0.25,  
	FIRINGRANGEMODIFIER				= -0.5,
	GFX_RAINIMPACT_LIMIT				= 0.1,
	GFX_RAIN_LIMIT						= 0.1,
	GFX_SNOW_LIMIT						= 0.1,
	GFX_STORM_LIMIT						= 15.0,
	GFX_SNOW_STORM_LIMIT				= 15.0,
	GFX_PARTIAL_CLOUD_LIMIT				= 0.3,
	GFX_CLOUD_LIMIT						= 0.8
},

goods_cost = {
	SUPPLIES 		= 0.25,
	FUEL 			= 0.75,
	MONEY 			= 0.0,
	CRUDE_OIL 		= 0.75,
	METAL 			= 0.1,
	ENERGY 			= 0.05,
	RARE_MATERIALS 		= 0.2
}

}
