require('hoi3')

module("hoi3.api", package.seeall)

CUnit = hoi3.Hoi3Object:subclass('hoi3.CUnit')

---
-- @since 1.3
-- @return iterator<CUnit> (or CSubUnitDefinition ?) 
hoi3.f(CUnit, 'GetChildren', 'iterator<CUnit>')

---
-- @since 1.3
-- @return CString
hoi3.f(CUnit, 'GetName', 'CString')

---
-- @since 1.3
-- @return bool
hoi3.f(CUnit, 'IsMoving', hoi3.TYPE_BOOLEAN)