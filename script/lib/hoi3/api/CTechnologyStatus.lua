require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CTechnologyStatus = Hoi3Object:subclass('hoi3.CTechnologyStatus')

---
-- @since 1.3
-- @return bool 
function CTechnologyStatus:CanResearch(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint 
function CTechnologyStatus:GetCost(tech, level)
	hoi3.assertParameterType(1, tech, 'CTechnology')
	hoi3.assertParameterType(2, level, 'number')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CTechnologyStatus:GetEffectiveYear(...)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @return number 
function CTechnologyStatus:GetLevel(tech)
	hoi3.assertParameterType(1, tech, 'CTechnology')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint 
function CTechnologyStatus:GetYear(tech, level)
	hoi3.assertParameterType(1, tech, 'CTechnology')
	hoi3.assertParameterType(2, level, 'number')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitDefinition  unit
-- @return bool 
function CTechnologyStatus:IsUnitAvailable(unit)
	hoi3.assertParameterType(1, unit, 'CSubUnitDefinition')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return bool 
function CTechnologyStatus:IsBuildingAvailable(building)
	hoi3.assertParameterType(1, building, 'CBuilding')
	
	hoi3.throwNotYetImplemented()
end
