require('hoi3')

module("hoi3.api", package.seeall)

CID = hoi3.Hoi3Object:subclass('hoi3.CID')

---
-- @return CID
function CID:initialize()
	hoi3.assertNonStatic(self)
	
	print("new CID!")
end