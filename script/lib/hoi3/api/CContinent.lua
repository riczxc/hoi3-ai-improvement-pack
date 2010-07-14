require('hoi3')

module("hoi3.api", package.seeall)

CContinent = hoi3.MultitonObject:subclass('hoi3.api.CContinent')

---
--
function CContinent:initialize(tag, name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, hoi3.TYPE_STRING)
	
	self.tag = tag
end 

---
-- @since 1.3
-- @return string 
hoi3.f(CContinent, 'GetName', hoi3.TYPE_STRING)

---
-- @since 1.3
-- @return string
hoi3.f(CContinent, 'GetTag', hoi3.TYPE_STRING)

function CContinent:GetTagImpl()
	return self.tag
end

function CContinent.random()
	return hoi3.randomTableMember(CContinent:getInstances())
end

function CContinent.userdataToInstance(myClass, userdata)	
	if userdata == nil then
		dtools.warn("Expected CContinent userdata but got nil !?")
		return
	end
	
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")

	if userdata.GetTag == nil and type(userdata.GetTag) ~= hoi3.TYPE_FUNCTION then
		hoi3.error("Bad signature for userdata, didn't match CContinent.userdataToInstance() !")
		return
	end
	
	local myInstance = CContinent(userdata:GetTag():GetString())
	myInstance.__userdata = userdata
	return myInstance
end