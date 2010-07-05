require('hoi3')

module("hoi3.api", package.seeall)

CIdeologyData = hoi3.Hoi3Object:subclass('hoi3.CIdeologyData')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CIdeologyData, 'CalculateTotalSum', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)
---
-- @since 1.3
-- @param CIdeology ideology
-- @return CFixedPoint
hoi3.f(CIdeologyData, 'GetValue', 'CFixedPoint', 'CIdeology')

function CIdeologyData.random()
	return CIdeologyData()
end