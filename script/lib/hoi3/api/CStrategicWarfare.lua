require('hoi3')

module("hoi3.api", package.seeall)

CStrategicWarfare = hoi3.Hoi3Object:subclass('hoi3.CStrategicWarfare')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetBombingImpact', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetAlliesImpact', 'CFixedPoint')
---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetConvoyImpact', 'CFixedPoint')