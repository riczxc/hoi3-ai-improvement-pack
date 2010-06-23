require('hoi3.AbstractObject')

module("hoi3.api", package.seeall)

CSubUnitDataBase = AbstractObject:subclass('hoi3.CSubUnitDataBase')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
function CSubUnitDataBase.CSubUnitDefinition(subUnitName)
	hoi3.assertParameterType(1, subUnitName, 'string')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CSubUnitDefinition>
function CSubUnitDataBase.GetSubUnitList()
	hoi3.throwNotYetImplemented()
end