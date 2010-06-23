require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CAction = Hoi3Object:subclass('hoi3.CAction')

---
-- @since 1.3
-- @return unknown 
function CAction.Create()
	hoi3.throwUnknownReturnType()
end 