require('hoi3.api.CDiplomaticAction')

CMilitaryAccessActionObject = CDiplomaticActionObject:subclass('hoi3.CMilitaryAccessAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CMilitaryAccessActionObject
function CMilitaryAccessAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end