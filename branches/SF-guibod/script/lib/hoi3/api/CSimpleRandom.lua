require('hoi3')

module("hoi3.api", package.seeall)

CSimpleRandom = hoi3.Hoi3Object:subclass('hoi3.CSimpleRandom')

---
-- @since 1.3
-- @return CFixedPoint
function CSimpleRandom:GetFixedPoint(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandom:GetInteger(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandom:GetNumber(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param number seed
-- @return void
function CSimpleRandom:Seed(seed)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, seed, hoi3.TYPE_NUMBER)
	
	hoi3.throwNotYetImplemented()
end

