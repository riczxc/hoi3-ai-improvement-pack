require('hoi3.Hoi3Object')

CFixedPoint = Hoi3Object:subclass('hoi3.CFixedPoint')

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPoint
function CFixedPoint:initialize(val)
	Hoi3Object.assertParameterType(1, val, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFixedPoint:Get()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFixedPoint:GetTruncated()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFixedPoint:GetRounded()
	Hoi3Object.throwNotYetImplemented()
end

