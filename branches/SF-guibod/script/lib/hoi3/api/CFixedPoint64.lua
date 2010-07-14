require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint64 = hoi3.Hoi3Object:subclass('hoi3.api.CFixedPoint64')

-- Constructor signature
-- information only, that will be used by documentation generator.
CFixedPoint64.constructorSignature = {hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPoint64
function CFixedPoint64:initialize(value)
	hoi3.assertNonStatic(self)
	if value ~= nil then
		hoi3.assertParameterType(1, value, hoi3.TYPE_NUMBER)
	end

	self._value = value or 0
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'Get', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetImpl()
	return self._value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'GetRounded', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetRoundedImpl()
  	return math.floor(self._value + 0.5)
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'GetTruncated', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetTruncatedImpl()
	return math.floor(self._value)
end

function CFixedPoint64.random()
	return CFixedPoint64(math.random()*100)
end

function CFixedPoint:__tostring()
	return tostring(self._value)
end

function CFixedPoint64:__eq(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value == value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__add(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value + value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__sub(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value - value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__mul(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value * value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__div(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value / value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__lt(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value < value._value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint64:__le(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint64,value) then
		return self._value <= value._value
	end
	hoi3.error("Operator not implemented !")
end