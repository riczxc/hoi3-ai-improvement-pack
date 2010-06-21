require('hoi3.Hoi3Object')

CUnitListObject = Hoi3Object:subclass('hoi3.CUnitList')

---
-- @since 1.4
-- @param CSubUnitDefinition  pType
-- @return number
function CUnitListObject:GetCount(pType)
	Hoi3Object.assertParameterType(1, pType, 'CSubUnitDefinition')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalAmountOfArmies()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalAmountOfDivisions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalNumOfPlanes()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalNumOfRegiments()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalNumOfShips()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalNumOfTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return number
function CUnitListObject:GetTotalNumOfWarShips()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CUnitListObject:GetTotalStrength()
	Hoi3Object.throwUnknownReturnType()
end
