require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CDeclareWarAction = CDiplomaticAction:subclass('hoi3.api.CDeclareWarAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CDeclareWarAction
function CDeclareWarAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function CDeclareWarAction:desc()
	return tostring(self.tag).." declares war to "..tostring(self.target).. " !"
end