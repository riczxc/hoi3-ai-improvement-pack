require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeLawCommand = CCommand:subclass('hoi3.CChangeLawCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CLaw law
-- @param CLawGroup lawGroup
-- @return CChangeLawCommand
function CChangeLawCommand:initialize(actor, law, lawGroup)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, law, 'CLaw')
	hoi3.assertParameterType(3, lawGroup, 'CLawGroup')

	self.actor = actor
	self.law = law
	self.lawGroup = lawGroup
end