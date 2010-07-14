require('hoi3')

module("hoi3.api", package.seeall)

CVariables = hoi3.Hoi3Object:subclass('hoi3.api.CVariables')

function CVariables:initialize()
end

---
-- @since 2.0
-- @return unknown 
hoi3.f(CVariables, 'GetVariable', hoi3.TYPE_UNKNOWN)