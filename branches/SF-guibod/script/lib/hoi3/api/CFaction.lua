require('hoi3.Hoi3Object')

CFaction = Hoi3Object:subclass('hoi3.CFaction')

---
-- @since 1.3
-- @return CCountryTag
function CFaction:GetFactionLeader()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeologyGroup
function CFaction:GetIdeologyGroup()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CFaction:GetMembers()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CFaction:GetNormalizedProgress()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFaction:GetNumberOfMembers()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CFaction:GetProgress(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CFaction:IsValid()
	Hoi3Object.throwNotYetImplemented()
end
