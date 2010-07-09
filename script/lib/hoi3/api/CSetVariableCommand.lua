require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CSetVariableCommand = CCommand:subclass('hoi3.api.CSetVariableCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CSetVariableCommand.constructorSignature = {'CCountryTag','CString','CFixedPoint'}

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param CFixedPoint bSet
-- @return CSetVariableCommand
function CSetVariableCommand:initialize(tag, var, value)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, var, 'CString')
	hoi3.assertParameterType(3, value, 'CFixedPoint')

	self.tag = tag
	self.var = var
	self.value = value
end

function CSetVariableCommand:desc()
	return tostring(self.var).." set to "..tostring(self.value)..
		" by "..tostring(self.tag).."."
end