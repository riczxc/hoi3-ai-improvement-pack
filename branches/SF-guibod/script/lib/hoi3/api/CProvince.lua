require('hoi3')

module("hoi3.api", package.seeall)

CProvince = hoi3.MultitonObject:subclass('hoi3.CProvince')

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
hoi3.f(CProvince, 'GetBuilding', false, 'CProvinceBuilding', 'CBuilding')

---
-- @since 1.4
-- @return number
hoi3.f(CProvince, 'GetCoastalFortLevel', false, hoi3.RAND_0TO10)

---
-- @since 1.3
-- @return CContinent
hoi3.f(CProvince, 'GetContinent', false, 'CContinent')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CProvince, 'GetController', false, 'CCountryTag')

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
hoi3.f(CProvince, 'GetCurrentConstructionLevel', false, hoi3.RAND_0TO10, 'CBuilding')

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetFortLevel', false, hoi3.RAND_0TO10)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CProvince, 'GetInfrastructure', false, hoi3.RAND_0TO10)

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
hoi3.f(CProvince, 'GetIntelLevel', false, hoi3.RAND_0TO10, 'CCountryTag')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CProvince, 'GetMaxInfrastructure', false, 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetNumberOfUnits', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CProvince, 'GetOwner', false, 'CCountryTag')

---
-- @since 1.3
-- @return number
hoi3.f(CProvince, 'GetProvinceID', false, hoi3.TYPE_NUMBER)

function CProvince:GetProvinceIDImpl()
	return self.id
end

---
-- @since 1.3
-- @return CUnitList
hoi3.f(CProvince, 'GetUnits', false, 'CUnitList')

---
-- @since 1.3
-- @param unknown
-- @return bool
hoi3.f(CProvince, 'HasAdjacentEnemyOrCB', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
hoi3.f(CProvince, 'HasBuilding', false, hoi3.TYPE_BOOLEAN, 'CBuilding')

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
hoi3.f(CProvince, 'IsFrontProvince', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_BOOLEAN)

-- A random CProvince is a random EXISTING tag !
function CProvince.random()
	return randomTableMember(CProvince:getInstances())
end