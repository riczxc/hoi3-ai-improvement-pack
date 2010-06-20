require('hoi3.Hoi3Object')

CIdeologyGroupObject = Hoi3Object:subclass('hoi3.CIdeologyGroupObject')

---
-- @since 1.3
-- @return CFaction
function CIdeologyGroupObject:GetFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CIdeologyGroupObject:GetPosition(...)
	Hoi3Object.throwUnknownSignature()
end