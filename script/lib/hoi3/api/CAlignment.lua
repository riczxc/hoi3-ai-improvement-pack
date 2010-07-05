require('hoi3')

module("hoi3.api", package.seeall)

CAlignment = hoi3.Hoi3Object:subclass('hoi3.CAlignment')

---
-- @since 1.3
-- @param CIdeologyGroup ideologyGroup
-- @return number 
hoi3.f(CAITechMinister, 'GetLastDrift', hoi3.TYPE_NUMBER, 'CIdeologyGroup')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAITechMinister, 'GetDistanceFrom', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)