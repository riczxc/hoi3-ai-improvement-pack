require('hoi3')

module("hoi3.api", package.seeall)

CPersonality = hoi3.Hoi3Object:subclass('hoi3.CPersonality')

---
-- @since 2.0
-- @return CString
function CPersonality:GetKey()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return number
function CPersonality:GetIndex()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end