require('hoi3')

module("hoi3.api", package.seeall)

CIdeologyGroup = hoi3.Hoi3Object:subclass('hoi3.CIdeologyGroup')

---
-- @since 1.3
-- @return CFaction
function CIdeologyGroup:GetFaction()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CIdeologyGroup:GetPosition(...)
	hoi3.throwUnknownSignature()
end