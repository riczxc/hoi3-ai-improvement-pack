require('hoi3.Hoi3Object')

CUnitList = Hoi3Object:subclass('hoi3.CUnitList')

---
-- @since 1.4
-- @param CSubUnitDefinition  pType
-- @return number
function CUnitList:GetCount(pType)
	Hoi3Object.assertParameterType(1, pType, 'CSubUnitDefinition')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalAmountOfArmies()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalAmountOfDivisions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfPlanes()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfRegiments()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfShips()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitList:GetTotalNumOfWarShips()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CUnitList:GetTotalStrength()
	Hoi3Object.throwUnknownReturnType()
end
