require('hoi3')

module("hoi3.api", package.seeall)

CLaw = hoi3.MultitonObject:subclass('hoi3.CLaw')

function CLaw:initialize(key)
	hoi3.assertNonStatic(self)
	
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

---
-- @since 1.3
-- @return string
hoi3.f(CLaw, 'GetKey', false, hoi3.TYPE_STRING)

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
