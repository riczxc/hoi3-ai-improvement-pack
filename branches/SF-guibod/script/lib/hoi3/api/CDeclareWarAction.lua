require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CDeclareWarAction = CDiplomaticAction:subclass('hoi3.CDeclareWarAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDeclareWarAction
function CDeclareWarAction:initialize(countryTagA, countryTagB)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end