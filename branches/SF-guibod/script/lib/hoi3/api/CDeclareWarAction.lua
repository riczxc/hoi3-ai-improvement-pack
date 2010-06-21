require('hoi3.api.CDiplomaticAction')

CDeclareWarAction = CDiplomaticAction:subclass('hoi3.CDeclareWarAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDeclareWarAction
function CDeclareWarAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end