require('hoi3')

module("hoi3.api", package.seeall)

CLaw = hoi3.MultitonObject:subclass('hoi3.api.CLaw')

function CLaw:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return CLawGroup
hoi3.f(CLaw, 'GetGroup', 'CLawGroup')

---
-- @since 1.3
-- @return number
hoi3.f(CLaw, 'GetIndex', hoi3.TYPE_NUMBER)

function CLaw:GetIndexImpl()
	return self:getIndexInDictionnary(CLaw:getInstances())
end

---
-- @since 1.3
-- @return string
hoi3.f(CLaw, 'GetKey', 'CString')

function CLaw:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return bool
hoi3.f(CLaw, 'IsValid', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CLaw, 'ValidFor', hoi3.TYPE_BOOLEAN, 'CCountryTag')

function CLaw.random()
	return hoi3.randomTableMember(CLaw:getInstances())
end
