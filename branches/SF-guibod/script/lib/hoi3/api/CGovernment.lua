require('hoi3')

module("hoi3.api", package.seeall)

CGovernment = hoi3.Hoi3Object:subclass('hoi3.CGovernment')

---
-- @since 1.3
-- @return bool
hoi3.f(CGovernment, 'IsValid', hoi3.TYPE_BOOLEAN)