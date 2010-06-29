require('hoi3')

module("hoi3.api", package.seeall)

CLaw = hoi3.MultitonObject:subclass('hoi3.CLaw')

function CLaw:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return CLawGroup
hoi3.f(CLaw, 'GetGroup', false, 'CLawGroup')

---
-- @since 1.3
-- @return number
hoi3.f(CLaw, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CLaw:GetIndexImpl()
	return self:getIndexInDictionnary(CLaw:getInstances())
end

---
-- @since 1.3
-- @return string
hoi3.f(CLaw, 'GetKey', false, 'CString')

function CLaw:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return bool
hoi3.f(CLaw, 'IsValid', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CLaw, 'ValidFor', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

function CLaw.random()
	return randomTableMember(CLaw:getInstances())
end
