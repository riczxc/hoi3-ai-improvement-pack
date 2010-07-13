require('hoi3.CList')

module("hoi3.api", package.seeall)

CList_CSubUnitConstructionEntry = hoi3.CList:subclass('hoi3.api.CList_CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
hoi3.f(CList_CSubUnitConstructionEntry, 'GetHeadData', 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return number
hoi3.f(CList_CSubUnitConstructionEntry, 'GetSize', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
hoi3.f(CList_CSubUnitConstructionEntry, 'GetTailData', 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return bool
hoi3.f(CList_CSubUnitConstructionEntry, 'IsEmpty', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CSubUnitConstructionEntry request
-- @return void
hoi3.f(CList_CSubUnitConstructionEntry, 'Remove', hoi3.TYPE_VOID, 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return void
hoi3.f(CList_CSubUnitConstructionEntry, 'RemoveHead', hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return void
hoi3.f(CList_CSubUnitConstructionEntry, 'RemoveTail', hoi3.TYPE_VOID)