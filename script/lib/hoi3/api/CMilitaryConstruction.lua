require('hoi3.Hoi3Object')

CMilitaryConstruction = Hoi3Object:subclass('hoi3.CMilitaryConstruction')

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsLand()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsAir()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CMilitaryConstruction:IsNaval()
	Hoi3Object.throwNotYetImplemented()
end