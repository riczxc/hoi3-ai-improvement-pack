require('hoi3')

module("hoi3.api", package.seeall)

CUnitList = hoi3.Hoi3Object:subclass('hoi3.CUnitList')

---
-- @since 1.4
-- @param CSubUnitDefinition  pType
-- @return number
hoi3.f(CUnitList, 'GetCount', hoi3.TYPE_NUMBER, 'CSubUnitDefinition')

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalAmountOfArmies', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalAmountOfDivisions', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfPlanes', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfRegiments', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfShips', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfTransports', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return number
hoi3.f(CUnitList, 'GetTotalNumOfWarShips', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return unknown
hoi3.f(CUnitList, 'GetTotalStrength', hoi3.TYPE_UNKNOWN)
