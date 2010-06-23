require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CTheatre = Hoi3Object:subclass('hoi3.CTheatre')

---
-- @since 1.3
-- @return number 
function CTheatre:GetPriority()
	hoi3.throwNotYetImplemented()
end