require('hoi3')

module("hoi3.api", package.seeall)

CString = hoi3.Hoi3Object:subclass('hoi3.CString')

---
-- @since 1.3
-- @param string str
-- @return Cstring
function CString:initialize(str)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, str, hoi3.TYPE_STRING)

	self.string = str
end

---
-- @since 1.3
-- @return string
function CString:Getstring()
	hoi3.assertNonStatic(self)
	return self.string
end

CString.test = hoi3.FunctionObject(CString, 'test', hoi3.TYPE_STRING, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return bool
function CString:GetCharPtr(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end


