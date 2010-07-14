require('hoi3')

module("hoi3.api", package.seeall)

CString = hoi3.Hoi3Object:subclass('hoi3.api.CString')

-- Constructor signature
-- information only, that will be used by documentation generator.
CString.constructorSignature = {hoi3.TYPE_STRING}

---
-- @since 1.3
-- @param string str
-- @return Cstring
function CString:initialize(str)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, str, hoi3.TYPE_STRING)

	self._string = str
end

---
-- @since 1.3
-- @return string
hoi3.f(CString, 'GetString', hoi3.TYPE_STRING)

function CString:GetStringImpl()
	return self._string
end


---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CString, 'GetCharPtr', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

function CString.random()
	return CString(hoi3.RAND_STRING:compute()) 
end

function CString:__eq(val)
	if type(val) == hoi3.TYPE_TABLE and
		 middleclass.instanceOf(CString,val) then
		return self._string == val._string
	end
end

function CString:__tostring()
	return self._string
end

function CString.userdataToInstance(myClass, userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	local myInstance = CString:new(userdata:GetString())
	myInstance.__userdata = userdata
	return myInstance
end