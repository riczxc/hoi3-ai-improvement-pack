require('hoi3.api.CDiplomaticAction')

CGuaranteeAction = CDiplomaticAction:subclass('hoi3.CGuaranteeAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CGuaranteeAction
function CGuaranteeAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end