require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CInfluenceAllianceLeader = CDiplomaticAction:subclass('hoi3.CInfluenceAllianceLeader')

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

function CInfluenceAllianceLeader:desc()
	return tostring(self.tag).." aligns toward "..tostring(self.leader).. "."
end