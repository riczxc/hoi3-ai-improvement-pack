require('hoi3')

module("hoi3.api", package.seeall)

CLawGroup = hoi3.MultitonObject:subclass('hoi3.CLawGroup')

function CLawGroup:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return number
hoi3.f(CLawGroup, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CLawGroup:GetIndexImpl()
	return self:getIndexInDictionnary(CLawGroup:getInstances())
end

---
-- @since 1.3
-- @return CString
hoi3.f(CLawGroup, 'GetKey', false, 'CString')

function CLawGroup:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return bool
hoi3.f(CLawGroup, 'IsValid', false, hoi3.TYPE_BOOLEAN)

function CLawGroup.random()
	return hoi3.randomTableMember(CLawGroup:getInstances())
end