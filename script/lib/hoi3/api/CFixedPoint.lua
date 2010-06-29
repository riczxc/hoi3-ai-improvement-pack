require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint = hoi3.Hoi3Object:subclass('hoi3.CFixedPoint')

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPoint
function CFixedPoint:initialize(val)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, val, hoi3.TYPE_NUMBER)

	self.value = val
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountryTag, 'Get', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CCountryTag, 'GetTruncated', false, hoi3.TYPE_NUMBER)

function CFixedPoint:GetTruncatedImpl()
	return math.floor(self.value)
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountryTag, 'GetRounded', false, hoi3.TYPE_NUMBER)

function CFixedPoint:GetRoundedImpl()
  	return math.floor(self.value + 0.5)
end


function CFixedPoint.random()
	return CFixedPoint(math.random()*100)
end