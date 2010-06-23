require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CAllianceAction = CDiplomaticAction:subclass('hoi3.CAllianceAction')

---
-- @since 1.3
-- @return CAllianceAction
function CAllianceAction:initialize(countryTagA,  countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')
	
	hoi3.throwNotYetImplemented()
end