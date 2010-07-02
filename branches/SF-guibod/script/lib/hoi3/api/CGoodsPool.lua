require('hoi3')

module("hoi3.api", package.seeall)

CGoodsPool = hoi3.AbstractObject:subclass('hoi3.CGoodsPool')

CGoodsPool._MONEY_ = 1
CGoodsPool._METAL_ = 2
CGoodsPool._ENERGY_ = 3
CGoodsPool._RARE_MATERIALS_ = 4
CGoodsPool._CRUDE_OIL_ = 5
CGoodsPool._SUPPLIES_ = 6
CGoodsPool._FUEL_ = 7

CGoodsPool._GC_NUMOF_ = 7

function CGoodsPool:initialize(...)
	hoi3.assertNonStatic(self)
	local args = {...}
	assert(#args == CGoodsPool._GC_NUMOF_, "CGoodsPool needs "..CGoodsPool._GC_NUMOF_.." arguments")
	for i=1,CGoodsPool._GC_NUMOF_ do
		hoi3.assertParameterType(i, args[i], hoi3.TYPE_NUMBER)
	end
	
	self.goods = args
end

---
-- @since 1.3
-- @param number goodtype
-- @return CFixedPoint
hoi3.f(CGoodsPool, 'Get', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

function CGoodsPool:GetImpl(type)
	assert(type > 0 and type <= CGoodsPool._GC_NUMOF_, "unknown good type")
	return CFixedPoint(self.goods[type])
end

---
-- @since 2.0
-- @param number goodtype
-- @return number
hoi3.f(CGoodsPool, 'GetFloat', false, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CGoodsPool:GetFloatImpl(type)
	assert(type > 0 and type <= CGoodsPool._GC_NUMOF_, "unknown good type")
	return self.goods[type]
end

function CGoodsPool.random()
	local r = hoi3.RAND_PERC
	local args = {}
	for i=1,CGoodsPool._GC_NUMOF_ do
		args[i] = r:compute()
	end
	
	return CGoodsPool(unpack(args))
end