require('hoi3')

module("hoi3.api", package.seeall)

CResearchBonus = hoi3.Hoi3Object:subclass('hoi3.api.CResearchBonus')
CResearchBonus.properties = {
	_vWeight	= { "read only", 'CFixedPoint' },
	_pCategory 	= { "read only", 'CTechnologyCategory' }
}

function CResearchBonus:initialize(vWeight, pCategory)
  	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, vWeight, 'CFixedPoint')
  	hoi3.assertParameterType(2, pCategory, 'CTechnologyCategory')
  
  	--CFixedPoint
  	self._vWeight	= vWeight
  	--CTechnologyCategory
  	self._pCategory	= pCategory
end

function CResearchBonus.userdataToInstance(myClass, userdata, parent)
	if userdata == nil then
		dtools.warn("Expected CResearchBonus userdata but got nil !?")
		return
	end
	
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	if userdata._vWeight ~= nil and userdata._pCategory ~= nil then
		hoi3.error("Bad signature for userdata, didn't match CResearchBonus.userdataToInstance() !")
		return
	end
	
	local myInstance = CResearchBonus(
		hoi3.api.CFixedPoint(userdata._vWeight:Get()),
		hoi3.api.CTechnologyCategory:userdataToInstance(userdata._pCategory,parent)
	)
	myInstance.__userdata = userdata
	return myInstance
end