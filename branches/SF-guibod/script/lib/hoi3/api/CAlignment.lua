require('hoi3')

module("hoi3.api", package.seeall)

CAlignment = hoi3.Hoi3Object:subclass('hoi3.api.CAlignment')

---
-- @since 1.3
-- @param CIdeologyGroup ideologyGroup
-- @return number 
hoi3.f(CAlignment, 'GetLastDrift', hoi3.TYPE_NUMBER, 'CIdeologyGroup')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAlignment, 'GetDistanceFrom', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)