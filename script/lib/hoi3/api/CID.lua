require('hoi3')

module("hoi3.api", package.seeall)

CID = hoi3.Hoi3Object:subclass('hoi3.api.CID')

-- Constructor signature
-- information only, that will be used by documentation generator.
CID.constructorSignature = {}

---
-- @return CID
function CID:initialize()
	hoi3.assertNonStatic(self)
end