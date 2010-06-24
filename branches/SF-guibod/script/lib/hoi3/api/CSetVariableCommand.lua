require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CSetVariableCommand = CCommand:subclass('hoi3.CSetVariableCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CSetVariableCommand:Clone()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param CFixedPoint bSet
-- @return CSetVariableCommand
function CSetVariableCommand:initialize(which, flag, vVal)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, which, 'CCountryTag')
	hoi3.assertParameterType(2, flag, hoi3.TYPE_STRING)
	hoi3.assertParameterType(3, bSet, 'CFixedPoint')

	hoi3.throwNotYetImplemented()
end