require('hoi3.api.CCommand')

CChangeLawCommand = CCommand:subclass('hoi3.CChangeLawCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CLaw law
-- @param CLawGroup lawGroup
-- @return CChangeLawCommand
function CChangeLawCommand:initialize(actor, law, lawGroup)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, law, 'CLaw')
	Hoi3Object.assertParameterType(3, lawGroup, 'CLawGroup')

	Hoi3Object.throwNotYetImplemented()
end