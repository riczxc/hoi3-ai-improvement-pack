require('hoi3.Hoi3Object')

CArrayFloatObject = Hoi3Object:subclass('hoi3.Hoi3Object')

---
-- @since 1.3
-- @param number index
-- @return CFixedPoint 
function CArrayFloatObject:GetAt(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
function CArrayFloatObject:SetAt(index, value)
	Hoi3Object.assertParameterType(1, index, 'number')
	Hoi3Object.assertParameterType(2, value, 'CFixedPoint')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number size
-- @return CArrayFloatObject
function CArrayFloat(size)
	Hoi3Object.assertParameterType(1, size, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end