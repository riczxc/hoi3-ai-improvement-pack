require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CEmbargoAction = CDiplomaticAction:subclass('hoi3.CEmbargoAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CEmbargoAction
function CEmbargoAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function CEmbargoAction:desc()
	return tostring(self.tag).." embargoes "..tostring(self.target).. " !"
end