require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CMilitaryAccessAction = CDiplomaticAction:subclass('hoi3.api.CMilitaryAccessAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CMilitaryAccessAction.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag countryTagB
-- @return CMilitaryAccessAction
function CMilitaryAccessAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CMilitaryAccessAction, 'Create', hoi3.TYPE_UNKNOWN)

function CMilitaryAccessAction:desc()
	return tostring(self.tag).." grants "..tostring(self.target).. " military access."
end