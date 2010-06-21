require('hoi3.Hoi3Object')

CArrayFix = Hoi3Object:subclass('hoi3.CArrayFix')

---
-- @since 1.3
-- @param number size
-- @return CArrayFix
function CArrayFix:initialize(size)
	Hoi3Object.assertParameterType(1, size, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CFixedPoint 
function CArrayFix:GetAt(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @param CFixedPoint value
-- @return void
function CArrayFix:SetAt(index, value)
	Hoi3Object.assertParameterType(1, index, 'number')
	Hoi3Object.assertParameterType(2, value, 'CFixedPoint')
	
	Hoi3Object.throwNotYetImplemented()
end
