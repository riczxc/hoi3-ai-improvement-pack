require('hoi3')

module("hoi3.api", package.seeall)

CPersonality = hoi3.MultitonObject:subclass('hoi3.api.CPersonality')

function CPersonality:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 2.0
-- @return CString
hoi3.f(CPersonality, 'GetKey', 'CString')

function CPersonality:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 2.0
-- @return number
hoi3.f(CPersonality, 'GetIndex', hoi3.TYPE_NUMBER)

function CPersonality:GetIndexImpl()
	return self:getIndexInDictionnary(CPersonality:getInstances())
end

function CPersonality.random()
	return hoi3.randomTableMember(CPersonality:getInstances())
end