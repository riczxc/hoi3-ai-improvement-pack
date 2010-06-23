require('hoi3')

module("hoi3.api", package.seeall)

CStrategicWarfare = hoi3.Hoi3Object:subclass('hoi3.CStrategicWarfare')

---
-- @since 1.3
-- @return CFixedPoint
function CStrategicWarfare:GetBombingImpact()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CStrategicWarfare:GetAlliesImpact()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CStrategicWarfare:GetConvoyImpact()
	hoi3.throwNotYetImplemented()
end