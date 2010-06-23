require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CSubUnitConstructionEntryList = Hoi3Object:subclass('hoi3.CSubUnitConstructionEntryList')

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryList:GetHeadData()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CSubUnitConstructionEntryList:GetSize()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CSubUnitConstructionEntry
function CSubUnitConstructionEntryList:GetTailData()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CSubUnitConstructionEntryList:IsEmpty()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitConstructionEntry request
-- @return void
function CSubUnitConstructionEntryList:Remove(request)
	hoi3.assertParameterType(1, request, 'CSubUnitConstructionEntry')

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryList:RemoveHead()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CSubUnitConstructionEntryList:RemoveTail()
	hoi3.throwNotYetImplemented()
end
