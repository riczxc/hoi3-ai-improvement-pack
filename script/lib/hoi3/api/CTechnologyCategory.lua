require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CTechnologyCategory = Hoi3Object:subclass('hoi3.CTechnologyCategory')

---
-- @since1.3 
-- @return CString
function CTechnologyCategory:GetKey()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return number
function CTechnologyCategory:GetIndex()
	hoi3.throwNotYetImplemented()
end