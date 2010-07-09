require('hoi3')

module("hoi3.api", package.seeall)

CFixedPoint64 = hoi3.Hoi3Object:subclass('hoi3.api.CFixedPoint64')

-- Constructor signature
-- information only, that will be used by documentation generator.
CFixedPoint64.constructorSignature = {hoi3.TYPE_NUMBER}

--[[
TODO�implement this :
.def( const_self + const_self )
      .def( constructor<>() )
        .def( constructor<float>() )
        .def( "Get", &CFixedPoint6464::Get )
        .def( "GetTruncated", &CFixedPoint6464::GetTruncated )
        .def( "GetRounded", &CFixedPoint6464::GetRounded )
        .def( const_self + const_self )
        .def( const_self - const_self )
        .def( const_self * const_self )
        .def( const_self / const_self )
        .def( const_self == const_self )
        .def( const_self < const_self )
        .def( const_self <= const_self )
        .def( tostring(const_self) ),
]]

---
-- @since 1.3
-- @param CCountryTag actor
-- @return CFixedPoint64
function CFixedPoint64:initialize(value)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, value, hoi3.TYPE_NUMBER)

	self.value = value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'Get', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetImpl()
	return self.value
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'GetRounded', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetRoundedImpl()
  	return math.floor(self.value + 0.5)
end

---
-- @since 1.3
-- @return number
hoi3.f(CFixedPoint64, 'GetTruncated', hoi3.TYPE_NUMBER)

function CFixedPoint64:GetTruncatedImpl()
	return math.floor(self.value)
end

function CFixedPoint64.random()
	return CFixedPoint64(math.random()*100)
end