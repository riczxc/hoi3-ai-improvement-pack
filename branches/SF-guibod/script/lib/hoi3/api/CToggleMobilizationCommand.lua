require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CToggleMobilizationCommand = CCommand:subclass('hoi3.CToggleMobilizationCommand')

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param boolean  bMobilize
-- @return CToggleMobilizationCommand
function CToggleMobilizationCommand:initialize(countryTag, bMobilize)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	hoi3.assertParameterType(2, bMobilize, hoi3.TYPE_BOOLEAN)

	hoi3.throwNotYetImplemented()
end