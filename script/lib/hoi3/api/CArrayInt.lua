require('hoi3')

module("hoi3.api", package.seeall)

CArrayInt = hoi3.Hoi3Object:subclass('hoi3.api.CArrayInt')

-- Constructor signature
-- information only, that will be used by documentation generator.
CArrayInt.constructorSignature = {hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param number size
-- @return CArrayInt
function CArrayInt:initialize(size)
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
hoi3.f(CArrayInt, 'GetAt', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CArrayInt:GetAtImpl(index)
	return self.array[index] or 0
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
hoi3.f(CArrayInt, 'SetAt', hoi3.TYPE_VOID, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

function CArrayInt:SetAtImpl(index, value)
	self.array[index] = value
end

---
-- @return CArrayInt
function CArrayInt.random()
	math.randomseed( os.time() )
	
	local size = math.random(10)
	local array = CArrayInt(size)
	
	for i = 0, size do
		array:SetAt(i,math.random())
	end
	
	return array
end