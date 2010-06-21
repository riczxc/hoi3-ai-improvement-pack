require('hoi3.Hoi3Object')

CSimpleRandom = Hoi3Object:subclass('hoi3.CSimpleRandom')

---
-- @since 1.3
-- @return CFixedPoint
function CSimpleRandom:GetFixedPoint(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandom:GetInteger(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandom:GetNumber(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param number seed
-- @return void
function CSimpleRandom:Seed(seed)
	Hoi3Object.assertParameterType(1, seed, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

