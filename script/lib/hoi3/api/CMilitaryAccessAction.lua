require('hoi3.api.CDiplomaticAction')

CMilitaryAccessAction = CDiplomaticAction:subclass('hoi3.CMilitaryAccessAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CMilitaryAccessAction
function CMilitaryAccessAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end