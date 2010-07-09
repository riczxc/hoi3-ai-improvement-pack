require('hoi3')

module("hoi3.api", package.seeall)

CMilitaryConstruction = hoi3.api.CConstruction:subclass('hoi3.api.CMilitaryConstruction')

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
-- @return iterator<CBrigadeConstructionDefinition>
hoi3.f(CMilitaryConstruction, 'GetBrigades', 'iterator<CBrigadeConstructionDefinition>')


function CMilitaryConstruction.random()
	return CMilitaryConstruction()
end