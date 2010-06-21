require('hoi3.api.CCommand')

CToggleMobilizationCommand = CCommand:subclass('hoi3.CToggleMobilizationCommand')

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param boolean  bMobilize
-- @return CToggleMobilizationCommand
function CToggleMobilizationCommand:initialize(countryTag, bMobilize)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, bMobilize, 'boolean')

	Hoi3Object.throwNotYetImplemented()
end