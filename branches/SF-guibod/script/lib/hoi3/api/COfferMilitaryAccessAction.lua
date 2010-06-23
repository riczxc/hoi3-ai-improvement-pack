require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

COfferMilitaryAccessAction = CDiplomaticAction:subclass('hoi3.COfferMilitaryAccessAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return COfferMilitaryAccessAction
function COfferMilitaryAccessAction:initialize(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end