require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CSetFlagCommand = CCommand:subclass('hoi3.CSetFlagCommand')

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param bool bSet = true
-- @return CSetFlagCommand
function CSetFlagCommand:initialize(which, flag, bSet)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, which, 'CCountryTag')
	hoi3.assertParameterType(2, flag, hoi3.TYPE_STRING)
	hoi3.assertParameterType(3, bSet, hoi3.TYPE_BOOLEAN)

	hoi3.throwNotYetImplemented()
end