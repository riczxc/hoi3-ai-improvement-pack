require('hoi3')

module("hoi3.api", package.seeall)

SubUnitList = hoi3.api.CList:subclass('hoi3.SubUnitList')

---
-- @since 1.2
-- @param 
-- @return void
-- Most usage are static call with SubUnitList instance as first parameter : instance call, not a static method
hoi3.f(SubUnitList, 'Append', false, 'SubUnit')