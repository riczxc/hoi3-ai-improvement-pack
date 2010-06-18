require('hoi3.api.CCommand')

CConstructBuildingCommandObject = CCommandObject:subclass('hoi3.CConstructBuildingCommandObject')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CBuilding building
-- @param number provinceId
-- @param number quantity
-- @return CConstructBuildingCommandObject
function CConstructBuildingCommand(actor, building, provinceId, quantity)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, target, 'CBuilding')
	Hoi3Object.assertParameterType(3, provinceId, 'number')
	Hoi3Object.assertParameterType(4, quantity, 'number')

	Hoi3Object.throwNotYetImplemented()
end