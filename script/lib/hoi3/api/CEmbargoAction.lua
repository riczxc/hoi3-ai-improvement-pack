require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CEmbargoAction = CDiplomaticAction:subclass('hoi3.CEmbargoAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CEmbargoAction
function CEmbargoAction:initialize(countryTagA, countryTagB)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	self.countryTagA = countryTagA
	self.countryTagB = countryTagB
end