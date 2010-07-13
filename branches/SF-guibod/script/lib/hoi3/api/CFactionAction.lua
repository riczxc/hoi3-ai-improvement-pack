require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CFactionAction = CDiplomaticAction:subclass('hoi3.api.CFactionAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CFactionAction.constructorSignature = {'CCountryTag','CCountryTag' }

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag countryTagB
-- @return CFactionAction
function CFactionAction:initialize(tag, ally)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, ally, 'CCountryTag')

	self.tag = tag
	self.ally = ally
end

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CFactionAction, 'Create', hoi3.TYPE_UNKNOWN)

function CFactionAction:desc()
	return tostring(self.tag).." invites "..tostring(self.ally).. " to faction."
end