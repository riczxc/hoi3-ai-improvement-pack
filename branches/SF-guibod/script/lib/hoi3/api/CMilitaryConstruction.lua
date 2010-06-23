require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CMilitaryConstruction = Hoi3Object:subclass('hoi3.CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsLand()
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsAir()
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsNaval()
	hoi3.throwNotYetImplemented()
end