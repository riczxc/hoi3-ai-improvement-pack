require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CSetFlagCommand = CCommand:subclass('hoi3.CSetFlagCommand')

---
-- @since 1.3
-- @param CCountryTag  Which
-- @param string Flag
-- @param bool value
-- @return CSetFlagCommand
function CSetFlagCommand:initialize(tag, flag, value)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, which, 'CCountryTag')
	hoi3.assertParameterType(2, flag, hoi3.TYPE_STRING)
	hoi3.assertParameterType(3, bSet, hoi3.TYPE_BOOLEAN)

	self.tag = tag
	self.flag = flag
	self.value = value
end

function CSetFlagCommand:desc()
	return tostring(self.flag).." set to "..tostring(self.value)..
		" by "..tostring(self.tag).."."
end