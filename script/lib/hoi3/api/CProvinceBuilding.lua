require('hoi3')

module("hoi3.api", package.seeall)

CProvinceBuilding = hoi3.Hoi3Object:subclass('hoi3.CProvinceBuilding')

---
-- @since 1.4
-- @return CFixedPoint
hoi3.f(CProvinceBuilding, 'GetCurrent', false, 'CFixedPoint')

---
-- @since 1.4
-- @return CFixedPoint
hoi3.f(CProvinceBuilding, 'GetMax', false, 'CFixedPoint')