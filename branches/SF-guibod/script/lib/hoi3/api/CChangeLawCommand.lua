require('hoi3.api.CCommand')

CChangeLawCommandObject = CCommandObject:subclass('hoi3.CChangeLawCommandObject')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CLaw law
-- @param CLawGroup lawGroup
-- @return CChangeLawCommandObject
function CChangeLawCommand(actor, law, lawGroup)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, law, 'CLaw')
	Hoi3Object.assertParameterType(3, lawGroup, 'CLawGroup')

	Hoi3Object.throwNotYetImplemented()
end