require('hoi3')

module("hoi3.api", package.seeall)

CProvinceBuilding = hoi3.Hoi3Object:subclass('hoi3.CProvinceBuilding')

---
-- @since 1.4
-- @return CFixedPoint
function CProvinceBuilding:GetCurrent()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CFixedPoint
function CProvinceBuilding:GetMax()
	hoi3.throwNotYetImplemented()
end