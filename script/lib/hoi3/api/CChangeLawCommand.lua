require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeLawCommand = CCommand:subclass('hoi3.CChangeLawCommand')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CLaw law
-- @param CLawGroup group
-- @return CChangeLawCommand
function CChangeLawCommand:initialize(tag, law, group)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, law, 'CLaw')
	hoi3.assertParameterType(3, group, 'CLawGroup')

	self.tag = tag
	self.law = law
	self.group = group
end

function CChangeLawCommand:desc()
	return "Changed law to "..tostring(self.law:GetKey())..
		" in "..tostring(self.group:GetKey()).." group"..
		" by "..tostring(self.countryTag).."."
end