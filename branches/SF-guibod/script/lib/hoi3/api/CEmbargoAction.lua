require('hoi3.api.CDiplomaticAction')

CEmbargoAction = CDiplomaticAction:subclass('hoi3.CEmbargoAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CEmbargoAction
function CEmbargoAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end