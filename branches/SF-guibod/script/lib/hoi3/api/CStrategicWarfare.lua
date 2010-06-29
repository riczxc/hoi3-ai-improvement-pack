require('hoi3')

module("hoi3.api", package.seeall)

CStrategicWarfare = hoi3.Hoi3Object:subclass('hoi3.CStrategicWarfare')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetBombingImpact', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetAlliesImpact', false, 'CFixedPoint')
---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CStrategicWarfare, 'GetConvoyImpact', false, 'CFixedPoint')