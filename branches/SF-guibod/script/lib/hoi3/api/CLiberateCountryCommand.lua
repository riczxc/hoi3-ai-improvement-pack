require('hoi3.api.CCommand')

CLiberateCountryCommand = CCommand:subclass('hoi3.CLiberateCountryCommand')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CLiberateCountryCommand
function CLiberateCountryCommand:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end