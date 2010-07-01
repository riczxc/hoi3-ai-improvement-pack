require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CMilitaryAccessAction = CDiplomaticAction:subclass('hoi3.CMilitaryAccessAction')

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

function CMilitaryAccessAction:desc()
	return tostring(self.tag).." grants "..tostring(self.target).. " military access."
end