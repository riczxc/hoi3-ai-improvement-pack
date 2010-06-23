require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CGovernment = Hoi3Object:subclass('hoi3.CGovernment')

---
-- @since 1.3
-- @return bool
function CGovernment:IsValid()
	hoi3.throwNotYetImplemented()
end
