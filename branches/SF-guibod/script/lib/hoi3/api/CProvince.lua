require('hoi3.Hoi3Object')

CProvinceObject = Hoi3Object:subclass('hoi3.CProvinceObject')

---
-- @since 1.4 
-- @param CBuilding  pBuilding
-- @return CProvinceBuilding
function CProvinceObject:GetBuilding(pBuilding)
	Hoi3Object.assertParameterType(1, pBuilding, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CProvinceObject:GetCoastalFortLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvinceObject:GetContinent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvinceObject:GetController()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param CBuilding  pBuilding
-- @return number
function CProvinceObject:GetCurrentConstructionLevel(pBuilding)
	Hoi3Object.assertParameterType(1, pBuilding, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvinceObject:GetFortLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CContinent
function CProvinceObject:GetContinent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvinceObject:GetInfrastructure()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  observer
-- @return number
function CProvinceObject:GetIntelLevel(observer)
	Hoi3Object.assertParameterType(1, observer, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CProvinceObject:GetMaxInfrastructure()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvinceObject:GetNumberOfUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CProvinceObject:GetOwner()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CProvinceObject:GetProvinceID()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CUnitList
function CProvinceObject:GetUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CProvinceObject:HasAdjacentEnemyOrCB(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool
function CProvinceObject:HasBuilding(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param bool unknownFlag
-- @return bool
function CProvinceObject:IsFrontProvince(unknownFlag)
	Hoi3Object.throwNotYetImplemented()
end