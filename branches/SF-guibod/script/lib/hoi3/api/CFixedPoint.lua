require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint = hoi3.Hoi3Object:subclass('hoi3.api.CFixedPoint')

-- Constructor signature
-- information only, that will be used by documentation generator.
CFixedPoint.constructorSignature = {hoi3.TYPE_NUMBER}

--[[
TODO implement this :
.def( constructor<>() )
        .def( constructor<float>() )
        .def( "Get", &CFixedPoint::Get )
        .def( "GetTruncated", &CFixedPoint::GetTruncated )
        .def( const_self + const_self )
        .def( const_self - const_self )
        .def( const_self * const_self )
        .def( const_self / const_self )
        .def( const_self == const_self )
        .def( const_self < const_self )
        .def( const_self <= const_self )
        .def( const_self + float() )
        .def( const_self - float() )
        .def( const_self * float() )
        .def( const_self / float() )
        .def( const_self == float() )
        .def( const_self < float() )
        .def( const_self <= float() )
        .def( float() + const_self )
        .def( float() - const_self )
        .def( float() * const_self )
        .def( float() / const_self )
        .def( float() == const_self )
        .def( float() < const_self )
        .def( float() <= const_self )
        .def( tostring(const_self) ),
]]

---
-- @since 1.3
-- @param number
-- @return CFixedPoint
function CFixedPoint:initialize(value)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, value, hoi3.TYPE_NUMBER)

	self.value = value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint, 'Get', hoi3.TYPE_NUMBER)

function CFixedPoint:GetImpl()
	return self.value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint, 'GetTruncated', hoi3.TYPE_NUMBER)

function CFixedPoint:GetTruncatedImpl()
	return math.floor(self.value)
end


function CFixedPoint.random()
	return CFixedPoint(math.random()*100)
end