require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitDataBase = hoi3.AbstractObject:subclass('hoi3.CSubUnitDataBase')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
function CSubUnitDataBase.CSubUnitDefinition(subUnitName)
	hoi3.assertParameterType(1, subUnitName, hoi3.TYPE_STRING)
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CSubUnitDefinition>
function CSubUnitDataBase.GetSubUnitList()
	hoi3.throwNotYetImplemented()
end