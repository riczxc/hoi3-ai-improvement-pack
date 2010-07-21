require('hoi3')

module("hoi3.api", package.seeall)

CBrigadeConstructionDefinition  = hoi3.MultitonObject:subclass('hoi3.api.CBrigadeConstructionDefinition ')

function CBrigadeConstructionDefinition:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return Cstring
hoi3.f(CBrigadeConstructionDefinition, 'GetType', 'CSubUnitDefinition')

function CBrigadeConstructionDefinition:GetTypeImpl()
	return CSubUnitDefinition(self.key)
end

function CBrigadeConstructionDefinition.random()
	return hoi3.randomTableMember(CBrigadeConstructionDefinition:getInstances())
end

function CBrigadeConstructionDefinition.userdataToInstance(myClass, userdata, parent)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert(type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	if userdata.GetType == nil and type(userdata.GetType) ~= hoi3.TYPE_FUNCTION then
		hoi3.error("Bad signature for userdata, didn't match CBrigadeConstructionDefinition.userdataToInstance() !")
		return
	end

	local myInstance
	myInstance = CBrigadeConstructionDefinition(userdata:GetType():GetKey():GetString())
	myInstance.__userdata = userdata
	--end
	return myInstance
end