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
function CProvince:GetBuilding(pBuilding)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, pBuilding, 'CBuilding')
	
	return CProvince:loadResultOrImplOrRandom(
		'CProvinceBuilding',
		'GetBuilding'
	)
end

---
-- @since 1.4
-- @return number
function CProvince:GetCoastalFortLevel()
	hoi3.assertNonStatic(self)
	
	local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	r.min = 0
	r.max = 10
	
	return CProvince:loadResultOrImplOrRandom(
		r,
		'GetCoastalFortLevel'
	)
end

---
-- @since 1.3
-- @return CContinent
function CProvince:GetContinent()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CContinent',
		'GetContinent'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetController()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetController'
	)
end

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
function CProvince:GetCurrentConstructionLevel(pBuilding)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, pBuilding, 'CBuilding')
	
	local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	r.min = 0
	r.max = 10
	
	return CProvince:loadResultOrImplOrRandom(
		r,
		'GetCurrentConstructionLevel',
		pBuilding
	)
end

---
-- @since 1.3
-- @return number
function CProvince:GetFortLevel()
	hoi3.assertNonStatic(self)
	local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	r.min = 0
	r.max = 10
	
	return CProvince:loadResultOrImplOrRandom(
		r,
		'GetCurrentConstructionLevel'
	)
end
---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetInfrastructure()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetInfrastructure'
	)
end

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
function CProvince:GetIntelLevel(observer)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, observer, 'CCountryTag')
	
	return CProvince:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetIntelLevel',
		observer
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetMaxInfrastructure()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetMaxInfrastructure'
	)
end

---
-- @since 1.3
-- @return number
function CProvince:GetNumberOfUnits()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumberOfUnits'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetOwner()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetOwner'
	)
end

---
-- @since 1.3
-- @return number
function CProvince:GetProvinceID()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetProvinceID'
	)
end

---
-- @since 1.3
-- @return CUnitList
function CProvince:GetUnits()
	hoi3.assertNonStatic(self)
	return CProvince:loadResultOrImplOrRandom(
		'CUnitList',
		'GetUnits'
	)
end

---
-- @since 1.3
-- @return bool
function CProvince:HasAdjacentEnemyOrCB(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
function CProvince:HasBuilding(building)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, building, 'CBuilding')
	
	return CProvince:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasBuilding',
		building
	)
end

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
function CProvince:IsFrontProvince(unknownFlag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, unknownFlag, hoi3.TYPE_BOOLEAN)

	return CProvince:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsFrontProvince',
		unknownFlag
	)
end

-- A random CProvince is a random EXISTING tag !
function CProvince.random()
	return randomTableMember(CProvince:getInstances())
end