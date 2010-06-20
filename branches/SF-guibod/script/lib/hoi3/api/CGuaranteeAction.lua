require('hoi3.api.CDiplomaticAction')

CGuaranteeActionObject = CDiplomaticActionObject:subclass('hoi3.CGuaranteeAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CGuaranteeActionObject
function CGuaranteeAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end