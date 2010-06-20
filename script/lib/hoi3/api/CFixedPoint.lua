require('hoi3.Hoi3Object')

CFixedPointObject = Hoi3Object:subclass('hoi3.CFixedPointObject')

---
-- @since 1.3
-- @return number
function CFixedPointObject:Get()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFixedPointObject:GetTruncated()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CFixedPointObject:GetRounded()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPointObject
function CFixedPoint(val)
	Hoi3Object.assertParameterType(1, val, 'number')

	Hoi3Object.throwNotYetImplemented()
end