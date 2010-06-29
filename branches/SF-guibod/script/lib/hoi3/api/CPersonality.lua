require('hoi3')

module("hoi3.api", package.seeall)

CPersonality = hoi3.MultitonObject:subclass('hoi3.CPersonality')

function CPersonality:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 2.0
-- @return CString
hoi3.f(CPersonality, 'GetKey', false, 'CString')

function CLaw:GetKeyImpl()
	return self.key
end

---
-- @since 2.0
-- @return number
hoi3.f(CPersonality, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CPersonality:GetIndexImpl()
	return self:getIndexInDictionnary(CPersonality:getInstances())
end

function CPersonality.random()
	return randomTableMember(CPersonality:getInstances())
end