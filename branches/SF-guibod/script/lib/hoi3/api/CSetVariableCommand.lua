require('hoi3.api.CCommand')

CSetVariableCommandObject = CCommandObject:subclass('hoi3.CSetVariableCommandObject')

---
-- @since 1.3
-- @return CChangeInvestmentCommandObject 
function CSetVariableCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param CFixedPoint bSet
-- @return CSetVariableCommandObject
function CSetVariableCommand(which, flag, vVal)
	Hoi3Object.assertParameterType(1, which, 'CCountryTag')
	Hoi3Object.assertParameterType(2, flag, 'string')
	Hoi3Object.assertParameterType(3, bSet, 'CFixedPoint')

	Hoi3Object.throwNotYetImplemented()
end