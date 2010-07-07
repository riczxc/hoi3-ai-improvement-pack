require('hoi3')

module("hoi3.api", package.seeall)

CFlags = hoi3.Hoi3Object:subclass('hoi3.api.CFlags')

---
-- @since 1.3
-- @param string key
-- @return bool
hoi3.f(CFlags, 'IsFlagSet', hoi3.TYPE_BOOLEAN, hoi3.TYPE_STRING)
