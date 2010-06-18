require('hoi3.api.CDiplomaticAction')

CFactionActionObject = CDiplomaticActionObject:subclass('hoi3.CFactionAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CFactionActionObject
function CFactionAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end