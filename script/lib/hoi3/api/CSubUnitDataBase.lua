require('hoi3.AbstractObject')

CSubUnitDataBase = AbstractObject:subclass('hoi3.CSubUnitDataBase')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
function CSubUnitDataBase.CSubUnitDefinition(subUnitName)
	Hoi3Object.assertParameterType(1, subUnitName, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CSubUnitDefinition>
function CSubUnitDataBase.GetSubUnitList()
	Hoi3Object.throwNotYetImplemented()
end