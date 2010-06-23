require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CIdeology = Hoi3Object:subclass('hoi3.CIdeology')

---
-- @since 1.3
-- @return CIdeologyGroup
function CIdeology:GetGroup()
	hoi3.throwNotYetImplemented()
end