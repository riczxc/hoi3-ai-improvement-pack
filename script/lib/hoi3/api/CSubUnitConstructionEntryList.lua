require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CSubUnitConstructionEntryList = CList:subclass('hoi3.api.CSubUnitConstructionEntryList')

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
hoi3.f(CSubUnitConstructionEntryList, 'GetHeadData', 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitConstructionEntryList, 'GetSize', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
hoi3.f(CSubUnitConstructionEntryList, 'GetTailData', 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitConstructionEntryList, 'IsEmpty', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CSubUnitConstructionEntry request
-- @return void
hoi3.f(CSubUnitConstructionEntryList, 'Remove', hoi3.TYPE_VOID, 'CSubUnitConstructionEntry')

---
-- @since 1.3
-- @return void
hoi3.f(CSubUnitConstructionEntryList, 'RemoveHead', hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return void
hoi3.f(CSubUnitConstructionEntryList, 'RemoveTail', hoi3.TYPE_VOID)