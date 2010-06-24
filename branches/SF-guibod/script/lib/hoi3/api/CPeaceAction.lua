require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CPeaceAction = CDiplomaticAction:subclass('hoi3.CPeaceAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CPeaceAction
function CPeaceAction:initialize(countryTagA, countryTagB)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end