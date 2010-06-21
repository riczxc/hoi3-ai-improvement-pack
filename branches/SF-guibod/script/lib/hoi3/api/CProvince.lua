require('hoi3.Hoi3Object')

CProvince = Hoi3Object:subclass('hoi3.CProvince')

---
-- @since 1.4 
-- @param CBuilding  pBuilding
-- @return CProvinceBuilding
function CProvince:GetBuilding(pBuilding)
	Hoi3Object.assertParameterType(1, pBuilding, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CProvince:GetCoastalFortLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvince:GetContinent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetController()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
function CProvince:GetCurrentConstructionLevel(pBuilding)
	Hoi3Object.assertParameterType(1, pBuilding, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetFortLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvince:GetContinent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetInfrastructure()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
function CProvince:GetIntelLevel(observer)
	Hoi3Object.assertParameterType(1, observer, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvince:GetMaxInfrastructure()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetNumberOfUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvince:GetOwner()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvince:GetProvinceID()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CUnitList
function CProvince:GetUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CProvince:HasAdjacentEnemyOrCB(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
function CProvince:HasBuilding(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
function CProvince:IsFrontProvince(unknownFlag)
	Hoi3Object.throwNotYetImplemented()
end