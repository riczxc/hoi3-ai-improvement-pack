require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructSingleUnitCommand = CCommand:subclass('hoi3.CConstructSingleUnitCommand')

---
-- @since 1.3
-- @return CCancelUnitConstructionCommand 
hoi3.f(CConstructSingleUnitCommand, 'Clone', false, 'CConstructSingleUnitCommand')