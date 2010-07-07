require('hoi3')

module("hoi3.api", package.seeall)

SubUnitList = hoi3.api.CList:subclass('hoi3.api.SubUnitList')

function SubUnitList:initialize()
	self.list = {}
end

---
-- @since 1.2
-- @param 
-- @return void
-- Most usage are static call with SubUnitList instance as first parameter : instance call, not a static method
hoi3.f(SubUnitList, 'Append', hoi3.TYPE_VOID, 'CSubUnitDefinition')

function SubUnitList:Append(subunit)
	table.insert(self.list, subunit)
end
