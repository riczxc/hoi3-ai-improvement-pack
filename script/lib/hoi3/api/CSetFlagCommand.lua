require('hoi3.api.CCommand')

CSetFlagCommandObject = CCommandObject:subclass('hoi3.CSetFlagCommandObject')

---
-- @since 1.3
-- @return CChangeInvestmentCommandObject 
function CSetFlagCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param bool bSet = true
-- @return CSetFlagCommandObject
function CSetFlagCommand(which, flag, bSet)
	Hoi3Object.assertParameterType(1, which, 'CCountryTag')
	Hoi3Object.assertParameterType(2, flag, 'string')
	Hoi3Object.assertParameterType(3, bSet, 'boolean')

	Hoi3Object.throwNotYetImplemented()
end