require('hoi3')

module("hoi3.api", package.seeall)

CMilitaryConstruction = hoi3.Hoi3Object:subclass('hoi3.CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsLand()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsAir()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsNaval()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end