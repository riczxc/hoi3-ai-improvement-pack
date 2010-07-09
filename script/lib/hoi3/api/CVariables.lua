require('hoi3')

module("hoi3.api", package.seeall)

CVariables = hoi3.MultitonObject:subclass('hoi3.api.CVariables')

---
-- @since 2.0
-- @return unknown 
hoi3.f(CVariables, 'GetVariable', hoi3.TYPE_UNKNOWN)