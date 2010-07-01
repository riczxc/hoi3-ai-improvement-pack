require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CInfluenceNation = CDiplomaticAction:subclass('hoi3.CInfluenceNation')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CInfluenceNation
function CInfluenceNation:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function CInfluenceNation:desc()
	return tostring(self.tag).." influences "..tostring(self.target).. "."
end