require('hoi3.CList')

module("hoi3.api", package.seeall)

SubUnitList = hoi3.CList:subclass('hoi3.api.SubUnitList')

-- Constructor signature
-- information only, that will be used by documentation generator.
SubUnitList.constructorSignature = {}

function SubUnitList:initialize()
	self.list = {}
end

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(SubUnitList, 'GetSize', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(SubUnitList, 'IsEmpty', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.fs(SubUnitList, 'RemoveAll', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.2
-- @param 
-- @return void
-- Most usage are static call with SubUnitList instance as first parameter : instance call, not a static method
hoi3.f(SubUnitList, 'Append', hoi3.TYPE_VOID, 'CSubUnitDefinition')

function SubUnitList:Append(subunit)
	table.insert(self.list, subunit)
end

