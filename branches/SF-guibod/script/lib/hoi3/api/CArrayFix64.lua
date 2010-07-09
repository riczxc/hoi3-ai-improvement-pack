require('hoi3')

module("hoi3.api", package.seeall)

CArrayFix64 = hoi3.Hoi3Object:subclass('hoi3.api.CArrayFix64')

-- Constructor signature
-- information only, that will be used by documentation generator.
CArrayFix64.constructorSignature = {hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param number size
-- @return CArrayFix64
function CArrayFix64:initialize(size)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, size, hoi3.TYPE_NUMBER)
	
	self.array = {}
	for i = 0, size do
		self.array[i] = CFixedPoint(0)
	end
end

---
-- @since 1.3
-- @param number index
-- @return CFixedPoint 
hoi3.f(CArrayFix64, 'GetAt', 'CFixedPoint', hoi3.TYPE_NUMBER)

function CArrayFix64:GetAtImpl(index)
	--TODO�maybe restore out of bound exceptions
	return self.array[index] or CFixedPoint(0)
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
hoi3.f(CArrayFix64, 'SetAt', hoi3.TYPE_VOID, hoi3.TYPE_NUMBER, 'CFixedPoint')

function CArrayFix64:SetAtImpl(index, value)
	self.array[index] = value
end

---
-- @return CArrayFix64
function CArrayFix64.random()
	math.randomseed( os.time() )
	
	local size = math.random(10)
	local array = CArrayFix64(size)
	
	for i = 0, size do
		array:SetAt(i,CFixedPoint.random())
	end
	
	return array
end
