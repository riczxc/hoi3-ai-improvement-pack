require('hoi3')

module("hoi3.api", package.seeall)

CBuildingDataBase = hoi3.AbstractObject:subclass('hoi3.CBuildingDataBase')

---
-- @since 1.3
-- @param string building
-- @return CBuilding 
function CBuildingDataBase.GetBuilding(building)
	hoi3.assertParameterType(1, building, hoi3.TYPE_STRING)
	
	return CBuildingDataBase.loadResultOrImplOrRandom(
		CBuildingDataBase,
		'CBuilding',
		'GetBuilding',
		building
	)
end

---
-- @since 1.3
-- @param number building
-- @return CBuilding 
function CBuildingDataBase.GetBuildingFromIndex(building)
	hoi3.assertParameterType(1, building, hoi3.TYPE_NUMBER)
	
	return CBuildingDataBase.loadResultOrImplOrRandom(
		CBuildingDataBase,
		'CBuilding',
		'GetBuilding',
		building
	)
end