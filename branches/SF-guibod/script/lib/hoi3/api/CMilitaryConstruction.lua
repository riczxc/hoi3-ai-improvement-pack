require('hoi3')

module("hoi3.api", package.seeall)

CMilitaryConstruction = hoi3.Hoi3Object:subclass('hoi3.CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
hoi3.f(CMilitaryConstruction, 'IsLand', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return bool
hoi3.f(CMilitaryConstruction, 'IsAir', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return bool
hoi3.f(CMilitaryConstruction, 'IsNaval', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return iterator<CBrigade>
hoi3.f(CMilitaryConstruction, 'GetBrigades', 'iterator<CBrigade>')


function CMilitaryConstruction.random()
	return CMilitaryConstruction()
end