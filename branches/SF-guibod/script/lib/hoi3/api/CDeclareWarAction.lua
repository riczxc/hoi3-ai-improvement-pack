require('hoi3.api.CDiplomaticAction')

CDeclareWarActionObject = CDiplomaticActionObject:subclass('hoi3.CDeclareWarActionObject')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDeclareWarActionObject
function CDeclareWarAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end