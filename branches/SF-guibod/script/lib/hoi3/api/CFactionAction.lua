require('hoi3.api.CDiplomaticAction')

CFactionAction = CDiplomaticAction:subclass('hoi3.CFactionAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CFactionAction
function CFactionAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end