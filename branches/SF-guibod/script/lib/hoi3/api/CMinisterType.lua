require('hoi3')

module("hoi3.api", package.seeall)

CMinisterType = hoi3.MultitonObject:subclass('hoi3.api.CMinisterType')

function CMinisterType:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 2.0
-- @return unknown
hoi3.f(CMinisterType, 'GetDecay', hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @return number
hoi3.f(CMinisterType, 'GetIndex', hoi3.TYPE_NUMBER)

function CMinisterType:GetIndexImpl()
	return self:getIndexInDictionnary(CMinisterType:getInstances())
end

---
-- @since 2.0
-- @return string
hoi3.f(CMinisterType, 'GetKey', 'CString')

function CMinisterType:GetKeyImpl()
	return CString(self.key)
end

function CMinisterType.random()
	return hoi3.randomTableMember(CMinisterType:getInstances())
end
