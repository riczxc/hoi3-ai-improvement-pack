require('hoi3')

module("hoi3.api", package.seeall)

CArrayFloat = hoi3.Hoi3Object:subclass('hoi3.api.CArrayFloat')

-- Constructor signature
-- information only, that will be used by documentation generator.
CArrayFloat.constructorSignature = {hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param number size
-- @return CArrayFloat
function CArrayFloat:initialize(size)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, size, hoi3.TYPE_NUMBER)
	
	self.array = {}
	for i = 0, size do
		self.array[i] = 0
	end
end

---
-- @since 1.3
-- @param number index
-- @return CFixedPoint 
hoi3.f(CArrayFloat, 'GetAt', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CArrayFloat:GetAtImpl(index)
	return self.array[index] or 0
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
hoi3.f(CArrayFloat, 'SetAt', hoi3.TYPE_VOID, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CArrayFloat:SetAtImpl(index, value)
	self.array[index] = value
end

---
-- @return CArrayFloat
function CArrayFloat.random()
	math.randomseed( os.time() )
	
	local size = math.random(10)
	local array = CArrayFloat(size)
	
	for i = 0, size do
		array:SetAt(i,math.random())
	end
	
	return array
end