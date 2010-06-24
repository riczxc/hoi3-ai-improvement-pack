require('hoi3')

module("hoi3.api", package.seeall)

CTechnology = hoi3.Hoi3Object:subclass('hoi3.CTechnology')

---
-- @since 1.3 
-- @return bool
function CTechnology:CanResearch(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3 
-- @return bool
function CTechnology:CanUpgrade(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CTechnology:GetDifficulty()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:GetEnableUnit()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTechnologyFolder
function CTechnology:GetFolder()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CTechnology:GetIndex()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return Cstring
function CTechnology:GetKey()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return unknown
function CTechnology:GetOnCompletion(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return table<CResearchBonus>
function CTechnology:GetResearchBonus()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:IsOneLevelOnly()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CTechnology:IsValid()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end