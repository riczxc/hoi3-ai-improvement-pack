require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint = hoi3.Hoi3Object:subclass('hoi3.CFixedPoint')

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPoint
function CFixedPoint:initialize(val)
	hoi3.assertParameterType(1, val, 'number')

	self.value = val
end

---
-- @since 1.3
-- @return number
function CFixedPoint:Get()
	return self.value
end

---
-- @since 1.3
-- @return number
function CFixedPoint:GetTruncated()
	return math.floor(self.value)
end

---
-- @since 1.3
-- @return number
function CFixedPoint:GetRounded()
  	return math.floor(self.value + 0.5)
end


function CFixedPoint.random()
	return CFixedPoint(math.random()*100)
end