require('hoi3')

module("hoi3.api", package.seeall)

CFlags = hoi3.Hoi3Object:subclass('hoi3.CFlags')

---
-- @since 1.3
-- @param string key
-- @return bool
hoi3.f(CFlags, 'IsFlagSet', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_STRING)
