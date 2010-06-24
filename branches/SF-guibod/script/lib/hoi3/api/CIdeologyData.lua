require('hoi3')

module("hoi3.api", package.seeall)

CIdeologyData = hoi3.Hoi3Object:subclass('hoi3.CIdeologyData')

---
-- @since 1.3
-- @return unknown
function CIdeologyData:CalculateTotalSum(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CIdeology ideology
-- @return CFixedPoint
function CIdeologyData:GetValue(ideology)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, ideology, 'CIdeology')
	
	hoi3.throwNotYetImplemented()
end