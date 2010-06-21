require('hoi3.api.CCommand')

CToggleMobilizationCommandObject = CCommandObject:subclass('hoi3.CToggleMobilizationCommandObject')

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param boolean  bMobilize
-- @return CToggleMobilizationCommandObject
function CToggleMobilizationCommand(countryTag, bMobilize)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, bMobilize, 'boolean')

	Hoi3Object.throwNotYetImplemented()
end