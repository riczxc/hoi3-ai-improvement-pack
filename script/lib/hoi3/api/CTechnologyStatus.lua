require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyStatus = hoi3.Hoi3Object:subclass('hoi3.api.CTechnologyStatus')

---
-- @since 1.3
-- @return bool 
hoi3.f(CTechnologyStatus, 'CanResearch', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint
hoi3.f(CTechnologyStatus, 'GetCost', 'CFixedPoint', 'CTechnology', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CTechnologyStatus, 'GetEffectiveYear', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CTechnology  tech
-- @return number
hoi3.f(CTechnologyStatus, 'GetLevel', hoi3.TYPE_NUMBER, 'CTechnology')

---
-- @since 1.3
-- @param CTechnology  tech
-- @param number level
-- @return CFixedPoint 
hoi3.f(CTechnologyStatus, 'GetYear', 'CFixedPoint', 'CTechnology', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CSubUnitDefinition  unit
-- @return bool
hoi3.f(CTechnologyStatus, 'IsUnitAvailable', hoi3.TYPE_BOOLEAN)
 
---
-- @since 1.3
-- @param CBuilding  building
-- @return bool 
hoi3.f(CTechnologyStatus, 'IsBuildingAvailable', hoi3.TYPE_BOOLEAN, 'CBuilding')

function CTechnologyStatus.random()
	return CTechnologyStatus()
end