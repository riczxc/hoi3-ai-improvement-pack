require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructBuildingCommand = CCommand:subclass('hoi3.CConstructBuildingCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CBuilding building
-- @param number provinceId
-- @param number quantity
-- @return CConstructBuildingCommand
function CConstructBuildingCommand:initialize(actor, building, provinceId, quantity)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CBuilding')
	hoi3.assertParameterType(3, provinceId, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(4, quantity, hoi3.TYPE_NUMBER)

	hoi3.throwNotYetImplemented()
end