require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint = hoi3.Hoi3Object:subclass('hoi3.api.CFixedPoint')

-- Constructor signature
-- information only, that will be used by documentation generator.
CFixedPoint.constructorSignature = {hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param number
-- @return CFixedPoint
function CFixedPoint:initialize(value)
	hoi3.assertNonStatic(self)
	if value ~= nil then
		hoi3.assertParameterType(1, value, hoi3.TYPE_NUMBER)
	end

	self._value = value or 0
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint, 'Get', hoi3.TYPE_NUMBER)

function CFixedPoint:GetImpl()
	return self._value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint, 'GetTruncated', hoi3.TYPE_NUMBER)

function CFixedPoint:GetTruncatedImpl()
	return math.floor(self._value)
end


function CFixedPoint.random()
	return CFixedPoint(math.random()*100)
end

function CFixedPoint.userdataToInstance(myClass, userdata, parent)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	local myInstance = CFixedPoint:new(userdata:Get())
	myInstance.__userdata = userdata
	return myInstance
end

function CFixedPoint:__tostring()
	return tostring(self._value)
end

function CFixedPoint:__eq(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value == value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value == value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__add(value)
	if  type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value + value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value + value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__sub(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value - value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value - value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__mul(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value * value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value * value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__div(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value / value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value / value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__lt(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value < value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value < value
	end
	hoi3.error("Operator not implemented !")
end

function CFixedPoint:__le(value)
	if type(value) == hoi3.TYPE_TABLE and
		middleclass.instanceOf(CFixedPoint,value) then
		return self._value <= value._value
	elseif type(value) == hoi3.TYPE_NUMBER then
		return self._value <= value
	end
	hoi3.error("Operator not implemented !")
end