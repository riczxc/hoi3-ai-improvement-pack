require('hoi3.api.CList')

CSubUnitConstructionEntryList = Hoi3Object:subclass('hoi3.CSubUnitConstructionEntryList')

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryList:GetHeadData()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CSubUnitConstructionEntryList:GetSize()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryList:GetTailData()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CSubUnitConstructionEntryList:IsEmpty()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitConstructionEntry request
-- @return void
function CSubUnitConstructionEntryList:Remove(request)
	Hoi3Object.assertParameterType(1, request, 'CSubUnitConstructionEntry')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryList:RemoveHead()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryList:RemoveTail()
	Hoi3Object.throwNotYetImplemented()
end
