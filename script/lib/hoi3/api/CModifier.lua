require('hoi3')

module("hoi3.api", package.seeall)

CModifier = hoi3.Hoi3Object:subclass('hoi3.api.CModifier')

function CModifier:initialize()
end

CModifier._MODIFIER_AIR_CAPACITY_	= 46
CModifier._MODIFIER_AIR_ORGANISATION_	= 70
CModifier._MODIFIER_ALIGN_TOWARDS_	= 47
CModifier._MODIFIER_ATTACK_REINFORCE_CHANCE_	= 63
CModifier._MODIFIER_ATTRITION_	= 7
CModifier._MODIFIER_COASTAL_FORT_LEVEL_	= 11
CModifier._MODIFIER_COMBAT_MOVEMENT_SPEED_	= 62
CModifier._MODIFIER_COMBAT_WIDTH_	= 65
CModifier._MODIFIER_COUNTER_ESPIONAGE_	= 55
CModifier._MODIFIER_COUNTER_INTELLIGENCE_	= 54
CModifier._MODIFIER_DEFEND_REINFORCE_CHANCE_	= 64
CModifier._MODIFIER_DISSENT_	= 43
CModifier._MODIFIER_DRIFT_SPEED_	= 36
CModifier._MODIFIER_ESPIONAGE_BONUS_	= 42
CModifier._MODIFIER_FORT_LEVEL_	= 10
CModifier._MODIFIER_GLOBAL_CRUDE_OIL_	= 19
CModifier._MODIFIER_GLOBAL_ENERGY_	= 21
CModifier._MODIFIER_GLOBAL_FUEL_	= 29
CModifier._MODIFIER_GLOBAL_IC_	= 17
CModifier._MODIFIER_GLOBAL_INFRASTRUCTURE_	= 14
CModifier._MODIFIER_GLOBAL_LEADERSHIP_	= 33
CModifier._MODIFIER_GLOBAL_LEADERSHIP_MODIFIER_	= 35
CModifier._MODIFIER_GLOBAL_MANPOWER_	= 4
CModifier._MODIFIER_GLOBAL_MANPOWER_MODIFIER_	= 6
CModifier._MODIFIER_GLOBAL_METAL_	= 23
CModifier._MODIFIER_GLOBAL_MONEY_	= 31
CModifier._MODIFIER_GLOBAL_RARE_MATERIALS_	= 25
CModifier._MODIFIER_GLOBAL_REVOLT_RISK_	= 2
CModifier._MODIFIER_GLOBAL_SUPPLIES_	= 27
CModifier._MODIFIER_IC_	= 15
CModifier._MODIFIER_INCORPORATE_COST_	= 38
CModifier._MODIFIER_INDUSTRIAL_EFFICIENCY_	= 73
CModifier._MODIFIER_INFRASTRUCTURE_	= 12
CModifier._MODIFIER_LAND_ORGANISATION_	= 69
CModifier._MODIFIER_LOCAL_ANTI_AIR_	= 74
CModifier._MODIFIER_LOCAL_CRUDE_OIL_	= 18
CModifier._MODIFIER_LOCAL_ENERGY_	= 20
CModifier._MODIFIER_LOCAL_FUEL_	= 28
CModifier._MODIFIER_LOCAL_IC_	= 16
CModifier._MODIFIER_LOCAL_INFRASTRUCTURE_	= 13
CModifier._MODIFIER_LOCAL_LEADERSHIP_	= 32
CModifier._MODIFIER_LOCAL_LEADERSHIP_MODIFIER_	= 34
CModifier._MODIFIER_LOCAL_MANPOWER_	= 3
CModifier._MODIFIER_LOCAL_MANPOWER_MODIFIER_	= 5
CModifier._MODIFIER_LOCAL_METAL_	= 22
CModifier._MODIFIER_LOCAL_MONEY_	= 30
CModifier._MODIFIER_LOCAL_PARTISAN_SUPPORT_	= 75
CModifier._MODIFIER_LOCAL_RARE_MATERIALS_	= 24
CModifier._MODIFIER_LOCAL_REVOLT_RISK_	= 1
CModifier._MODIFIER_LOCAL_SUPPLIES_	= 26
CModifier._MODIFIER_MAX_WAR_EXHAUSTION_	= 9
CModifier._MODIFIER_MINIMUM_REVOLT_RISK_	= 0
CModifier._MODIFIER_NATIONAL_UNITY_	= 44
CModifier._MODIFIER_NATIONAL_UNITY_EFFECT_	= 67
CModifier._MODIFIER_NAVAL_BASE_EFFICIENCY_	= 79
CModifier._MODIFIER_NAVAL_CAPACITY_	= 45
CModifier._MODIFIER_NAVAL_ORGANISATION_	= 71
CModifier._MODIFIER_NEUTRALITY_CHANGE_	= 77
CModifier._MODIFIER_OFFICER_RECRUITMENT_	= 81
CModifier._MODIFIER_OFFMAP_INDUSTRY_INTEL_	= 60
CModifier._MODIFIER_OFFMAP_LAND_INTEL_	= 58
CModifier._MODIFIER_OFFMAP_NAVAL_INTEL_	= 59
CModifier._MODIFIER_OFFMAP_POLITICAL_INTEL_	= 61
CModifier._MODIFIER_ORG_REGAIN_	= 66
CModifier._MODIFIER_PARTISAN_EFFICENCY_	= 78
CModifier._MODIFIER_PEACE_CONSUMER_GOODS_DEMAND_	= 41
CModifier._MODIFIER_PEACE_OFFMAP_INTEL_	= 57
CModifier._MODIFIER_PEACETIME_MANPOWER_ROTATION_	= 50
CModifier._MODIFIER_RADAR_LEVEL_	= 48
CModifier._MODIFIER_RESEARCH_EFFICIENCY_	= 72
CModifier._MODIFIER_RESERVES_PENALTY_SIZE_	= 76
CModifier._MODIFIER_RULING_PARTY_SUPPORT_	= 68
CModifier._MODIFIER_SUPPLY_CONSUMPTION_	= 49
CModifier._MODIFIER_SUPPLY_THROUGHPUT_	= 80
CModifier._MODIFIER_SUSEPTIBILITY_	= 37
CModifier._MODIFIER_TERRITORIAL_PRIDE_	= 39
CModifier._MODIFIER_THREAT_IMPACT_	= 56
CModifier._MODIFIER_UNIT_RECRUITMENT_TIME_	= 51
CModifier._MODIFIER_UNIT_REPAIR_	= 53
CModifier._MODIFIER_UNIT_START_EXPERIENCE_	= 52
CModifier._MODIFIER_WAR_CONSUMER_GOODS_DEMAND_	= 40
CModifier._MODIFIER_WAR_EXHAUSTION_	= 8

---
-- @since 2.0
-- @param number modifier
-- @return number
hoi3.f(CModifier, 'GetValue', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CModifier.userdataToInstance(myClass, userdata, parent)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	hoi3.assert(parent ~= nil and 
		type(parent) == hoi3.TYPE_TABLE and 
		middleclass.instanceOf(hoi3.api.CCountry, parent),
		"CModifier.userdataToInstance needs parent argument to be set on a valid CCountry instance.")
		
	local source = parent:GetCountryTag()
		
	local myInstance = hoi3.api.CModifier(source)
	myInstance.__userdata = userdata
	return myInstance
end