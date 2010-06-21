require('hoi3.api.CDiplomaticAction')

CInfluenceNation = CDiplomaticAction:subclass('hoi3.CInfluenceNation')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CInfluenceNation
function CInfluenceNation:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end