require('hoi3.api.CList')

CSubUnitConstructionEntryListObject = Hoi3Object:subclass('hoi3.CSubUnitConstructionEntryListObject')

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryListObject:GetHeadData()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CSubUnitConstructionEntryListObject:GetSize()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryListObject:GetTailData()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CSubUnitConstructionEntryListObject:IsEmpty()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitConstructionEntry request
-- @return void
function CSubUnitConstructionEntryListObject:Remove(request)
	Hoi3Object.assertParameterType(1, request, 'CSubUnitConstructionEntry')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryListObject:RemoveHead()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryListObject:RemoveTail()
	Hoi3Object.throwNotYetImplemented()
end
