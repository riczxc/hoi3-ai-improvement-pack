require('hoi3')

module("hoi3.api", package.seeall)

CTechnology = hoi3.MultitonObject:subclass('hoi3.CTechnology')

---
-- @since 1.3 
-- @param unknown
-- @return bool
hoi3.f(CTechnology, 'CanResearch', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3 
-- @param unknown
-- @return bool
hoi3.f(CTechnology, 'CanUpgrade', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number
hoi3.f(CTechnology, 'GetDifficulty', false, hoi3.TYPE_NUMBER)
---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'GetEnableUnit', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return CTechnologyFolder
hoi3.f(CTechnology, 'GetFolder', false, 'CTechnologyFolder')

---
-- @since 1.3
-- @return number
hoi3.f(CTechnology, 'GetIndex', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return Cstring
hoi3.f(CTechnology, 'GetKey', false, 'CString')

---
-- @since 1.3 
-- @param unknown
-- @return unknown
hoi3.f(CTechnology, 'GetOnCompletion', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return table<CResearchBonus>
hoi3.f(CTechnology, 'GetResearchBonus', false, 'table<CResearchBonus>')

---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'IsOneLevelOnly', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'IsValid', false, hoi3.TYPE_BOOLEAN)