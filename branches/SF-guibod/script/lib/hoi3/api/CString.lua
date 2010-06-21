require('hoi3.Hoi3Object')

CStringObject = Hoi3Object:subclass('hoi3.CStringObject')

---
-- @since 1.3
-- @return string
function CStringObject:Getstring()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CStringObject:GetCharPtr(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end


---
-- @since 1.3
-- @param string str
-- @return Cstring
function Cstring(country, techno)
	Hoi3Object.assertParameterType(1, str, 'string')

	Hoi3Object.throwNotYetImplemented()
end