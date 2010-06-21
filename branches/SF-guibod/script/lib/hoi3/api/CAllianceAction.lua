require('hoi3.api.CDiplomaticAction')

CAllianceAction = CDiplomaticAction:subclass('hoi3.CAllianceAction')

---
-- @since 1.3
-- @return CAllianceAction
function CAllianceAction:initialize(countryTagA,  countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end