require('hoi3')

module("hoi3.api", package.seeall)

CCommand = hoi3.Hoi3Object:subclass('hoi3.api.CCommand')

---
-- @since 1.3
-- @return bool 
hoi3.f(CCommand, 'IsValid', hoi3.RAND_BOOL_VLIKELY)