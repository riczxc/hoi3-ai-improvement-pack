require('hoi3')

module("hoi3.api", package.seeall)

CSimpleRandom = hoi3.Hoi3Object:subclass('hoi3.CSimpleRandom')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CSimpleRandom, 'GetFixedPoint', false, 'GetFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CSimpleRandom, 'GetInteger', false, hoi3.TYPE_NUMBER)
---
-- @since 1.3
-- @return number
hoi3.f(CSimpleRandom, 'GetNumber', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number seed
-- @return void
hoi3.f(CSimpleRandom, 'Seed', false, hoi3.TYPE_VOID, hoi3.TYPE_NUMBER)

function CSimpleRandom.SeedImpl(seed)
	--TODO: find a workaround to provide non persitant values
	self:clearResult()
end

