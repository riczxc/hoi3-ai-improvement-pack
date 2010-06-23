require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CFaction = Hoi3Object:subclass('hoi3.CFaction')

---
-- @since 1.3
-- @return CCountryTag
function CFaction:GetFactionLeader()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeologyGroup
function CFaction:GetIdeologyGroup()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CFaction:GetMembers()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CFaction:GetNormalizedProgress()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFaction:GetNumberOfMembers()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CFaction:GetProgress(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CFaction:IsValid()
	hoi3.throwNotYetImplemented()
end
