require('hoi3')

module("hoi3.api", package.seeall)

CLawGroup = hoi3.MultitonObject:subclass('hoi3.api.CLawGroup')

function CLawGroup:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return number
hoi3.f(CLawGroup, 'GetIndex', hoi3.TYPE_NUMBER)

function CLawGroup:GetIndexImpl()
	return self:getIndexInDictionnary(CLawGroup:getInstances())
end

---
-- @since 1.3
-- @return CString
hoi3.f(CLawGroup, 'GetKey', 'CString')

function CLawGroup:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 1.3
-- @return bool
hoi3.f(CLawGroup, 'IsValid', hoi3.TYPE_BOOLEAN)

function CLawGroup.random()
	return hoi3.randomTableMember(CLawGroup:getInstances())
end