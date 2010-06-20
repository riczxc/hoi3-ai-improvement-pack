require('hoi3.api.CDiplomaticAction')

CInfluenceNationObject = CDiplomaticActionObject:subclass('hoi3.CInfluenceNation')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CInfluenceNationObject
function CInfluenceNation(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end