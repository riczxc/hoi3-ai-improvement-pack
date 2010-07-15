require('hoi3')

module("hoi3.api", package.seeall)

CVariables = hoi3.Hoi3Object:subclass('hoi3.api.CVariables')

function CVariables:initialize()
end

---
-- @since 2.0
-- @return unknown 
hoi3.f(CVariables, 'GetVariable', hoi3.TYPE_UNKNOWN)

function CVariables.userdataToInstance(myClass, userdata, parent)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	hoi3.assert(parent ~= nil and 
		type(parent) == hoi3.TYPE_TABLE and 
		middleclass.instanceOf(hoi3.api.CCountry, parent),
		"CVariables.userdataToInstance needs parent argument to be set on a valid CCountry instance.")
		
	local source = parent:GetCountryTag()
		
	local myInstance = hoi3.api.CVariables(source)
	myInstance.__userdata = userdata
	return myInstance
end