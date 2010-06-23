require('hoi3')

module("hoi3.api", package.seeall)

CString = hoi3.Hoi3Object:subclass('hoi3.CString')

---
-- @since 1.3
-- @return string
function CString:Getstring()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CString:GetCharPtr(...)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end


---
-- @since 1.3
-- @param string str
-- @return Cstring
function CString:initialize(str)
	hoi3.assertParameterType(1, str, 'string')

	hoi3.throwNotYetImplemented()
end