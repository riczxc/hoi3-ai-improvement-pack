require('hoi3')

module("hoi3.api", package.seeall)

CConstruction = hoi3.Hoi3Object:subclass('hoi3.api.CConstruction')

---
-- @since 2.0
-- @return number 
hoi3.f(CConstruction, 'GetCost', hoi3.TYPE_NUMBER)

---
-- @since 2.0
-- @return number 
hoi3.f(CConstruction, 'GetSize', hoi3.TYPE_UNKNOWN)


---
-- @since 2.0
-- @return CMilitaryConstruction
hoi3.f(CConstruction, 'GetMilitary', 'CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
hoi3.f(CConstruction, 'IsMilitary', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return bool
hoi3.f(CConstruction, 'IsConvoy', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return bool
hoi3.f(CConstruction, 'IsBuilding', hoi3.TYPE_BOOLEAN)

-- A random CConstruction is a random EXISTING tag !
function CConstruction.random()
	return CConstruction()
end