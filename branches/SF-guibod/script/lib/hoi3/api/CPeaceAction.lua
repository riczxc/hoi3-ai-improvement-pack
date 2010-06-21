require('hoi3.api.CDiplomaticAction')

CPeaceActionObject = CDiplomaticActionObject:subclass('hoi3.CPeaceAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CPeaceActionObject
function CPeaceAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end