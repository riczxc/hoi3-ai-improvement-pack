require('hoi3.AbstractObject')

CBuildingDataBase = AbstractObject:subclass('hoi3.CBuildingDataBase')

---
-- @since 1.3
-- @param string building
-- @return CBuilding 
function CBuildingDataBase.GetBuilding(building)
	Hoi3Object.assertParameterType(1, building, 'string')
	
	return CBuildingDataBase.loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, building, 'number')
	
	return CBuildingDataBase.loadResultOrFakeOrRandom(
		CBuildingDataBase,
		'CBuilding',
		'GetBuilding',
		building
	)
end