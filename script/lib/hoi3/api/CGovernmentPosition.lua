require('hoi3')

module("hoi3.api", package.seeall)

CGovernmentPosition = hoi3.MultitonObject:subclass('hoi3.api.CGovernmentPosition')

function CGovernmentPosition:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 2.0
-- @return unknown
hoi3.f(CGovernmentPosition, 'IsChangeable', hoi3.TYPE_BOOLEAN)

---
-- @since 2.0
-- @return number
hoi3.f(CGovernmentPosition, 'GetIndex', hoi3.TYPE_NUMBER)

function CGovernmentPosition:GetIndexImpl()
	return self:getIndexInDictionnary(CGovernmentPosition:getInstances())
end

---
-- @since 2.0
-- @return string
hoi3.f(CGovernmentPosition, 'GetKey', 'CString')

function CGovernmentPosition:GetKeyImpl()
	return CString(self.key)
end

function CGovernmentPosition.random()
	return hoi3.randomTableMember(CGovernmentPosition:getInstances())
end
