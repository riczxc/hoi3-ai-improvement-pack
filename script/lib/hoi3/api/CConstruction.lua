require('hoi3')

module("hoi3.api", package.seeall)

CConstruction = hoi3.Hoi3Object:subclass('hoi3.CConstruction')

---
-- @since 2.0
-- @return number 
hoi3.f(CConstruction, 'GetCost', false, hoi3.TYPE_NUMBER)

---
-- @since 2.0
-- @return CMilitaryConstruction
hoi3.f(CConstruction, 'GetMilitary', false, 'CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
hoi3.f(CConstruction, 'IsMilitary', false, hoi3.TYPE_BOOLEAN)

-- A random CConstruction is a random EXISTING tag !
function CConstruction.random()
	local ret = CConstruction()
	print(ret)
	return ret
end