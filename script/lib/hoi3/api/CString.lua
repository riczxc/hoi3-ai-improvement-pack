require('hoi3.Hoi3Object')

CString = Hoi3Object:subclass('hoi3.CString')

---
-- @since 1.3
-- @return string
function CString:Getstring()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CString:GetCharPtr(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end


---
-- @since 1.3
-- @param string str
-- @return Cstring
function CString:initialize(str)
	Hoi3Object.assertParameterType(1, str, 'string')

	Hoi3Object.throwNotYetImplemented()
end