require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CLiberateCountryCommand = CCommand:subclass('hoi3.CLiberateCountryCommand')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CLiberateCountryCommand
function CLiberateCountryCommand:initialize(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end