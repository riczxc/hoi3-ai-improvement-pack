require('hoi3.api.CCommand')

CLiberateCountryCommandObject = CCommandObject:subclass('hoi3.CLiberateCountryCommandObject')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CLiberateCountryCommandObject
function CLiberateCountryCommand(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end