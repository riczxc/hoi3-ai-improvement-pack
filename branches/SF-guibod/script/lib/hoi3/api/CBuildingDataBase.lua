require('hoi3.Hoi3Object')

CBuildingDataBaseObject = Hoi3Object:subclass('hoi3.Hoi3Object')

---
-- @since 1.3
-- @param string building
-- @return CBuilding 
function CBuildingDataBaseObject.GetBuilding(building)
	Hoi3Object.assertParameterType(1, building, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number building
-- @return CBuilding 
function CBuildingDataBaseObject.GetBuildingFromIndex(building)
	Hoi3Object.assertParameterType(1, building, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

-- CBuildingDataBase has static methods and properties
-- we need to declare a CBuildingDataBase table 
CBuildingDataBase = CBuildingDataBaseObject