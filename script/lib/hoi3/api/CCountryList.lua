require('hoi3.CList')

module("hoi3.api", package.seeall)

CCountryList = hoi3.CList:subclass('hoi3.api.CCountryList')

---
-- @since 1.3
-- @param unknown
-- @return bool
hoi3.f(CCountryList, 'IsEnemy', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)