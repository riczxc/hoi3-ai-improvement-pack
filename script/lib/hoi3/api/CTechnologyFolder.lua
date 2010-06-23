require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyFolder = hoi3.Hoi3Object:subclass('hoi3.CTechnologyFolder')

---
-- @since 1.3 
-- @return number
function CTechnologyFolder:GetIndex()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return CString
--function CTechnologyFolder:GetKey()
CTechnologyFolder.GetKey = function()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3 
-- @return bool
function CTechnologyFolder:IsValid()
	hoi3.throwNotYetImplemented()
end