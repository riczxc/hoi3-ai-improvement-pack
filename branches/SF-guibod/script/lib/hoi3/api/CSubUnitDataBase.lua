require('hoi3.Hoi3Object')

CSubUnitDataBaseObject = Hoi3Object:subclass('hoi3.CSubUnitDataBaseObject')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
function CSubUnitDataBaseObject.CSubUnitDefinition(subUnitName)
	Hoi3Object.assertParameterType(1, subUnitName, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CSubUnitDefinition>
function CSubUnitDataBaseObject.GetSubUnitList()
	Hoi3Object.throwNotYetImplemented()
end

-- CSubUnitDataBase has static methods and properties
-- we need to declare a CSubUnitDataBase table 
CSubUnitDataBase = CSubUnitDataBaseObject