require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CCountryList = CList:subclass('hoi3.CCountryList')

---
-- @since 1.3
-- @param unknown
-- @return bool
hoi3.f(CCountryList, 'IsEnemy', false, hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)