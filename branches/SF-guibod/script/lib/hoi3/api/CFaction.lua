require('hoi3.Hoi3Object')

CFactionObject = Hoi3Object:subclass('hoi3.CFactionObject')

---
-- @since 1.3
-- @return CCountryTag
function CFactionObject:GetFactionLeader()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeologyGroup
function CFactionObject:GetIdeologyGroup()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CFactionObject:GetMembers()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CFactionObject:GetNormalizedProgress()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFactionObject:GetNumberOfMembers()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CFactionObject:GetProgress(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CFactionObject:IsValid()
	Hoi3Object.throwNotYetImplemented()
end
