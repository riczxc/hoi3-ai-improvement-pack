require('hoi3')

module("hoi3.api", package.seeall)

CAction = hoi3.Hoi3Object:subclass('hoi3.CAction')

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CAction, 'Create', hoi3.TYPE_UNKNOWN)