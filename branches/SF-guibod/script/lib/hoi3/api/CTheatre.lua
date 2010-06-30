require('hoi3')

module("hoi3.api", package.seeall)

CTheatre = hoi3.Hoi3Object:subclass('hoi3.CTheatre')

---
-- @since 1.3
-- @return number 
hoi3.f(CTheatre, 'GetPriority', false, hoi3.TYPE_NUMBER)