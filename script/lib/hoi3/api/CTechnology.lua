require('hoi3')

module("hoi3.api", package.seeall)

CTechnology = hoi3.MultitonObject:subclass('hoi3.CTechnology')

function CTechnology:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3 
-- @param unknown
-- @return bool
hoi3.f(CTechnology, 'CanResearch', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3 
-- @param unknown
-- @return bool
hoi3.f(CTechnology, 'CanUpgrade', hoi3.TYPE_BOOLEAN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number
hoi3.f(CTechnology, 'GetDifficulty', hoi3.TYPE_NUMBER)
---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'GetEnableUnit', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return CTechnologyFolder
hoi3.f(CTechnology, 'GetFolder', 'CTechnologyFolder')

---
-- @since 1.3
-- @return number
hoi3.f(CTechnology, 'GetIndex', hoi3.TYPE_NUMBER)

function CTechnology:GetIndexImpl()
	return self:getIndexInDictionnary(CTechnology:getInstances())
end

---
-- @since 1.3
-- @return Cstring
hoi3.f(CTechnology, 'GetKey', 'CString')

function CTechnology:GetKeyImpl()
	return self.key
end

---
-- @since 1.3 
-- @param unknown
-- @return unknown
hoi3.f(CTechnology, 'GetOnCompletion', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return iterator<CResearchBonus>
hoi3.f(CTechnology, 'GetResearchBonus', 'iterator<CResearchBonus>')

---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'IsOneLevelOnly', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CTechnology, 'IsValid', hoi3.TYPE_BOOLEAN)

function CTechnology.random()
	return hoi3.randomTableMember(CTechnology:getInstances())
end