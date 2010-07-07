require('hoi3')

module("hoi3.api", package.seeall)

CProvinceBuilding = hoi3.Hoi3Object:subclass('hoi3.api.CProvinceBuilding')

---
-- @since 1.4
-- @return CFixedPoint
hoi3.f(CProvinceBuilding, 'GetCurrent', 'CFixedPoint')

---
-- @since 1.4
-- @return CFixedPoint
hoi3.f(CProvinceBuilding, 'GetMax', 'CFixedPoint')

function CProvinceBuilding.random()
	return CProvinceBuilding()
end