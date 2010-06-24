require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CCountryTagList = CList:subclass('hoi3.CCountryTagList')

---
-- @since 1.3
-- @return bool
function CCountryTagList:IsEnemy(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end  