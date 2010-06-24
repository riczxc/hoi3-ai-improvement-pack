require('hoi3')

module("hoi3.api", package.seeall)

CUnitList = hoi3.Hoi3Object:subclass('hoi3.CUnitList')

---
-- @since 1.4
-- @param CSubUnitDefinition  pType
-- @return number
function CUnitList:GetCount(pType)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, pType, 'CSubUnitDefinition')
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalAmountOfArmies()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalAmountOfDivisions()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfPlanes()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfRegiments()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfShips()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfTransports()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfWarShips()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CUnitList:GetTotalStrength()
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownReturnType()
end
