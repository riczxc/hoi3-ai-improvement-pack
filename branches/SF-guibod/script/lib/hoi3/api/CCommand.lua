require('hoi3')

module("hoi3.api", package.seeall)

CCommand = hoi3.Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @return bool 
hoi3.f(CCommand, 'isValid', false, hoi3.TYPE_BOOLEAN)