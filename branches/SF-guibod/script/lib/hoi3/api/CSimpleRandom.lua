require('hoi3.Hoi3Object')

CSimpleRandomObject = Hoi3Object:subclass('hoi3.CSimpleRandomObject')

---
-- @since 1.3
-- @return CFixedPoint
function CSimpleRandomObject:GetFixedPoint(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandomObject:GetInteger(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CSimpleRandomObject:GetNumber(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param number seed
-- @return void
function CSimpleRandomObject:Seed(seed)
	Hoi3Object.assertParameterType(1, seed, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

