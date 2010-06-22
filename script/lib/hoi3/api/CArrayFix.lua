require('hoi3.Hoi3Object')

CArrayFix = Hoi3Object:subclass('hoi3.CArrayFix')

---
-- @since 1.3
-- @param number size
-- @return CArrayFix
function CArrayFix:initialize(size)
	Hoi3Object.assertParameterType(1, size, 'number')
	
	CArrayFix.array = {}
	for i = 0, size do
		table.insert(CArrayFix.array, CFixedPoint())
	end
end

---
-- @since 1.3
-- @param number index
-- @return CFixedPoint 
function CArrayFix:GetAt(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	if index < #CArrayFix.array and 
		CArrayFix.array[index] ~= nil then
		return CArrayFix.array[index]
	else
		error("Out of bound.")
	end
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
function CArrayFix:SetAt(index, value)
	Hoi3Object.assertParameterType(1, index, 'number')
	Hoi3Object.assertParameterType(2, value, 'CFixedPoint')
	
	if index < #CArrayFix.array then
		CArrayFix.array[index] = value
	else
		error("Out of bound.")
	end
end

---
-- @return CArrayFix
function CArrayFix.random()
	math.randomseed( os.time() )
	
	local size = math.random(10)
	local array = CArrayFix(size)
	
	for i = 0, size do
		array:SetAt(i,CFixedPoint.random())
	end
	
	return array
end
