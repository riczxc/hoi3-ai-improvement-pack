require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitDataBase = hoi3.AbstractObject:subclass('hoi3.CSubUnitDataBase')

---
-- @since 1.3
-- @static
-- @param string subUnitName
-- @return CSubUnitDefinition 
hoi3.f(CSubUnitDataBase, 'CSubUnitDefinition', false, hoi3.TYPE_STRING)

---
-- @since 1.3
-- @static
-- @return table<CSubUnitDefinition>
hoi3.f(CSubUnitDataBase, 'GetSubUnitList', false, 'table<CSubUnitDefinition>')