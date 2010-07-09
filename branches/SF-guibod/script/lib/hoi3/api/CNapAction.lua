require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CNapAction = CDiplomaticAction:subclass('hoi3.api.CNapAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CNapAction.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CNapAction
function CNapAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function CNapAction:desc()
	return tostring(self.tag).." propose non-aggression pact to "..tostring(self.target).. "."
end