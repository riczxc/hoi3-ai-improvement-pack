require('hoi3')

module("hoi3.api", package.seeall)

CProvince = hoi3.MultitonObject:subclass('hoi3.api.CProvince')

---
-- @param number provinceId
function CProvince:initialize(id)
	hoi3.assertNonStatic(self)
	
	self.id = id
end

---
-- @since 1.4 
-- @param CBuilding  pBuilding
-- @return CProvinceBuilding
hoi3.f(CProvince, 'GetBuilding', 'CProvinceBuilding', 'CBuilding')

---
-- @since 1.4
-- @return number
hoi3.f(CProvince, 'GetCoastalFortLevel', hoi3.RAND_0TO10)

---
-- @since 1.3
-- @return CContinent
hoi3.f(CProvince, 'GetContinent', 'CContinent')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CProvince, 'GetController', 'CCountryTag')

function CProvince:GetControllerImpl()
	local tag = self:GetOwner()
	if tag:GetCountry():IsAtWar() then
		local r = hoi3.RAND_BOOL_UNLIKELY
		if r:compute() then
			while not tag:IsReal() do
				tag = CCountryTag.random() 
			end
		end
	end
	
	return tag
end

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
hoi3.f(CProvince, 'GetCurrentConstructionLevel', hoi3.RAND_0TO10, 'CBuilding')

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetFortLevel', hoi3.RAND_0TO10)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CProvince, 'GetInfrastructure', hoi3.RAND_0TO10)

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
hoi3.f(CProvince, 'GetIntelLevel', hoi3.RAND_0TO10, 'CCountryTag')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CProvince, 'GetMaxInfrastructure', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetNumberOfUnits', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CProvince, 'GetOwner', 'CCountryTag')

function CProvince:GetOwnerImpl()
	local tag = CCountryTag.random() 
	while not tag:IsReal() do
		tag = CCountryTag.random() 
	end
	return tag
end

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetProvinceID', hoi3.TYPE_NUMBER)

function CProvince:GetProvinceIDImpl()
	return self.id
end

---
-- @since 1.3
-- @return iterator<CUnit>
hoi3.f(CProvince, 'GetUnits', 'iterator<CUnit>')

---
-- @since 1.3
-- @param unknown
-- @return bool
hoi3.f(CProvince, 'HasAdjacentEnemyOrCB', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
hoi3.f(CProvince, 'HasBuilding', hoi3.TYPE_BOOLEAN, 'CBuilding')

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
hoi3.f(CProvince, 'IsFrontProvince', hoi3.TYPE_BOOLEAN, hoi3.TYPE_BOOLEAN)

-- A random CProvince is a random EXISTING tag !
function CProvince.random()
	return hoi3.randomTableMember(CProvince:getInstances())
end

function CProvince.userdataToInstance(myClass, userdata)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	if userdata.GetProvinceID == nil and type(userdata.GetProvinceID) ~= hoi3.TYPE_FUNCTION then
		hoi3.error("Bad signature for userdata, didn't match CProvince.userdataToInstance() !")
		return
	end
	
	local myInstance = CProvince(userdata:GetProvinceID())
	myInstance.__userdata = userdata
	return myInstance
end