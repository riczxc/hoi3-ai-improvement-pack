require('hoi3.api.CDiplomaticAction')

COfferMilitaryAccessActionObject = CDiplomaticActionObject:subclass('hoi3.COfferMilitaryAccessAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return COfferMilitaryAccessActionObject
function COfferMilitaryAccessAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end