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
hoi3.f(CString, 'Getstring', false, hoi3.TYPE_STRING)

function CString:GetstringImpl()
	return self.string
end


---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CString, 'GetCharPtr', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

