require('hoi3.Hoi3Object')

CTechnology = Hoi3Object:subclass('hoi3.CTechnology')

---
-- @since 1.3 
-- @return bool
function CTechnology:CanResearch(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3 
-- @return bool
function CTechnology:CanUpgrade(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CTechnology:GetDifficulty()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:GetEnableUnit()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTechnologyFolder
function CTechnology:GetFolder()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CTechnology:GetIndex()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return Cstring
function CTechnology:GetKey()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return unknown
function CTechnology:GetOnCompletion(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return table<CResearchBonus>
function CTechnology:GetResearchBonus()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:IsOneLevelOnly()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:IsValid()
	Hoi3Object.throwNotYetImplemented()
end