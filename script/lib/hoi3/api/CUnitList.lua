require('hoi3')

module("hoi3.api", package.seeall)

CUnitList = hoi3.Hoi3Object:subclass('hoi3.CUnitList')

---
-- @since 1.4
-- @param CSubUnitDefinition  pType
-- @return number
hoi3.f(CUnitList, 'GetCount', false, hoi3.TYPE_NUMBER, 'CSubUnitDefinition')

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalAmountOfArmies', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalAmountOfDivisions', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfPlanes', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfRegiments', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfShips', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfTransports', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfWarShips', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return unknown
hoi3.f(CUnitList, 'GetTotalStrength', false, hoi3.TYPE_UNKNOWN)
