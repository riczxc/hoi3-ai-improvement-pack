require('hoi3.Hoi3Object')

CIdeologyGroup = Hoi3Object:subclass('hoi3.CIdeologyGroup')

---
-- @since 1.3
-- @return CFaction
function CIdeologyGroup:GetFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CIdeologyGroup:GetPosition(...)
	Hoi3Object.throwUnknownSignature()
end