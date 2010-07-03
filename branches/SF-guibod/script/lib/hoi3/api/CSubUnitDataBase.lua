require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitDataBase = hoi3.AbstractObject:subclass('hoi3.CSubUnitDataBase')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
hoi3.f(CSubUnitDataBase, 'GetSubUnit', true, 'CSubUnitDefinition', hoi3.TYPE_STRING)

function CSubUnitDataBase.GetSubUnit(key)
	return CSubUnitDefinition:getInstance(key)
end

---
-- @since 1.3
-- @static
-- @return iterator<CSubUnitDefinition>
hoi3.f(CSubUnitDataBase, 'GetSubUnitList', true, 'iterator<CSubUnitDefinition>')

function CSubUnitDataBase.GetSubUnitListImpl()
	return CSubUnitDefinition:getInstances()
end