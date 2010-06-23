require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CPersonality = Hoi3Object:subclass('hoi3.CPersonality')

---
-- @since 2.0
-- @return CString
function CPersonality:GetKey()
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return number
function CPersonality:GetIndex()
	hoi3.throwNotYetImplemented()
end