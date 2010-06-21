require('hoi3.Hoi3Object')

CTechnologyStatusObject = Hoi3Object:subclass('hoi3.CTechnologyStatusObject')

---
-- @since 1.3
-- @return bool 
function CTechnologyStatusObject:CanResearch(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint 
function CTechnologyStatusObject:GetCost(tech, level)
	Hoi3Object.assertParameterType(1, tech, 'CTechnology')
	Hoi3Object.assertParameterType(2, level, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CTechnologyStatusObject:GetEffectiveYear(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @return number 
function CTechnologyStatusObject:GetLevel(tech)
	Hoi3Object.assertParameterType(1, tech, 'CTechnology')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint 
function CTechnologyStatusObject:GetYear(tech, level)
	Hoi3Object.assertParameterType(1, tech, 'CTechnology')
	Hoi3Object.assertParameterType(2, level, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitDefinition  unit
-- @return bool 
function CTechnologyStatusObject:IsUnitAvailable(unit)
	Hoi3Object.assertParameterType(1, unit, 'CSubUnitDefinition')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool 
function CTechnologyStatusObject:IsBuildingAvailable(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end
