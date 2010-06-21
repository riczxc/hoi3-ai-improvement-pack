require('hoi3.Hoi3Object')

CIdeologyDataObject = Hoi3Object:subclass('hoi3.CIdeologyDataObject')

---
-- @since 1.3
-- @return unknown
function CIdeologyDataObject:CalculateTotalSum(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CIdeology ideology
-- @return CFixedPoint
function CIdeologyDataObject:GetValue(ideology)
	Hoi3Object.assertParameterType(1, ideology, 'CIdeology')
	
	Hoi3Object.throwNotYetImplemented()
end