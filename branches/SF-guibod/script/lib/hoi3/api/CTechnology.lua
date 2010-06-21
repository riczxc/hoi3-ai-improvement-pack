require('hoi3.Hoi3Object')

CTechnologyObject = Hoi3Object:subclass('hoi3.CTechnologyObject')

---
-- @since 1.3 
-- @return bool
function CTechnologyObject:CanResearch(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3 
-- @return bool
function CTechnologyObject:CanUpgrade(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CTechnologyObject:GetDifficulty()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnologyObject:GetEnableUnit()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTechnologyFolder
function CTechnologyObject:GetFolder()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CTechnologyObject:GetIndex()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return Cstring
function CTechnologyObject:GetKey()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return unknown
function CTechnologyObject:GetOnCompletion(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return table<CResearchBonus>
function CTechnologyObject:GetResearchBonus()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnologyObject:IsOneLevelOnly()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnologyObject:IsValid()
	Hoi3Object.throwNotYetImplemented()
end