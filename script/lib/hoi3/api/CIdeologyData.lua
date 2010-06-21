require('hoi3.Hoi3Object')

CIdeologyData = Hoi3Object:subclass('hoi3.CIdeologyData')

---
-- @since 1.3
-- @return unknown
function CIdeologyData:CalculateTotalSum(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CIdeology ideology
-- @return CFixedPoint
function CIdeologyData:GetValue(ideology)
	Hoi3Object.assertParameterType(1, ideology, 'CIdeology')
	
	Hoi3Object.throwNotYetImplemented()
end