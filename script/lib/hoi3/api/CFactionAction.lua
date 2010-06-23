require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CFactionAction = CDiplomaticAction:subclass('hoi3.CFactionAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CFactionAction
function CFactionAction:initialize(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end