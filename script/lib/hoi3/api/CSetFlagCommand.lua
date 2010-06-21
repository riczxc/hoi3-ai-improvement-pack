require('hoi3.api.CCommand')

CSetFlagCommand = CCommand:subclass('hoi3.CSetFlagCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CSetFlagCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param bool bSet = true
-- @return CSetFlagCommand
function CSetFlagCommand:initialize(which, flag, bSet)
	Hoi3Object.assertParameterType(1, which, 'CCountryTag')
	Hoi3Object.assertParameterType(2, flag, 'string')
	Hoi3Object.assertParameterType(3, bSet, 'boolean')

	Hoi3Object.throwNotYetImplemented()
end