require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CInfluenceAllianceLeader = CDiplomaticAction:subclass('hoi3.api.CInfluenceAllianceLeader')

-- Constructor signature
-- information only, that will be used by documentation generator.
CInfluenceAllianceLeader.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag leader
-- @return CInfluenceAllianceLeader
function CInfluenceAllianceLeader:initialize(tag, leader)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, leader, 'CCountryTag')

	self.tag = tag
	self.leader = leader
end

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CInfluenceAllianceLeader, 'Create', hoi3.TYPE_UNKNOWN)

function CInfluenceAllianceLeader:desc()
	return tostring(self.tag).." aligns toward "..tostring(self.leader).. "."
end