require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeSpyMission = CCommand:subclass('hoi3.api.CChangeSpyMission')

-- Constructor signature
-- information only, that will be used by documentation generator.
CChangeSpyMission.constructorSignature = {'CCountryTag','CCountryTag',hoi3.TYPE_NUMBER }

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @param number mission
-- @return CChangeSpyMission
function CChangeSpyMission:initialize(tag, target, mission)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	hoi3.assertParameterType(3, mission, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.target = target
	self.mission = mission
end

function CChangeSpyMission:desc()
	local m = {}
	m[1] = "SPYMISSION_BOOST_OUR_PARTY"
	m[2] = "SPYMISSION_BOOST_RULING_PARTY"
	m[3] = "SPYMISSION_COUNTER_ESPIONAGE"
	m[4] = "SPYMISSION_DISRUPT_PRODUCTION"
	m[5] = "SPYMISSION_DISRUPT_RESEARCH"
	m[6] = "SPYMISSION_INCREASE_THREAT"
	m[7] = "SPYMISSION_LOWER_NATIONAL_UNITY"
	m[8] = "SPYMISSION_LOWER_NEUTRALITY"
	m[9] = "SPYMISSION_MAX"
	m[10] = "SPYMISSION_MILITARY"
	m[11] = "SPYMISSION_NONE"
	m[12] = "SPYMISSION_POLITICAL"
	m[13] = "SPYMISSION_RAISE_NATIONAL_UNITY"
	m[14] = "SPYMISSION_SUPPORT_RESISTANCE"
	m[15] = "SPYMISSION_TECH"
	
	return "Spy mission changed toward "..tostring(self.target).." to "..
		tostring(m[self.mission] or "UNKNOWN INDEX")..
		" by "..tostring(self.tag).."."
end