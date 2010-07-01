require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CPeaceAction = CDiplomaticAction:subclass('hoi3.CPeaceAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CPeaceAction
function CPeaceAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function CPeaceAction:desc()
	return tostring(self.tag).." signs peace with "..tostring(self.target).. "."
end