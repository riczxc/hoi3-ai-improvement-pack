require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CProvince = Hoi3Object:subclass('hoi3.CProvince')

---
-- @since 1.4 
-- @param CBuilding  pBuilding
-- @return CProvinceBuilding
function CProvince:GetBuilding(pBuilding)
	hoi3.assertParameterType(1, pBuilding, 'CBuilding')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CProvince:GetCoastalFortLevel()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvince:GetContinent()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetController()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
function CProvince:GetCurrentConstructionLevel(pBuilding)
	hoi3.assertParameterType(1, pBuilding, 'CBuilding')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetFortLevel()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvince:GetContinent()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetInfrastructure()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
function CProvince:GetIntelLevel(observer)
	hoi3.assertParameterType(1, observer, 'CCountryTag')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetMaxInfrastructure()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetNumberOfUnits()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetOwner()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetProvinceID()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CUnitList
function CProvince:GetUnits()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CProvince:HasAdjacentEnemyOrCB(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
function CProvince:HasBuilding(building)
	hoi3.assertParameterType(1, building, 'CBuilding')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
function CProvince:IsFrontProvince(unknownFlag)
	hoi3.throwNotYetImplemented()
end