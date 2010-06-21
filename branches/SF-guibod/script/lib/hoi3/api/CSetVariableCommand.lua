require('hoi3.api.CCommand')

CSetVariableCommand = CCommand:subclass('hoi3.CSetVariableCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CSetVariableCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param CFixedPoint bSet
-- @return CSetVariableCommand
function CSetVariableCommand:initialize(which, flag, vVal)
	Hoi3Object.assertParameterType(1, which, 'CCountryTag')
	Hoi3Object.assertParameterType(2, flag, 'string')
	Hoi3Object.assertParameterType(3, bSet, 'CFixedPoint')

	Hoi3Object.throwNotYetImplemented()
end