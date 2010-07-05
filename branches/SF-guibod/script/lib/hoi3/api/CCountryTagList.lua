require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CCountryTagList = CList:subclass('hoi3.CCountryTagList')

---
-- @since 1.3
-- @param unknown
-- @return bool
hoi3.f(CCountryTagList, 'IsEnemy', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)