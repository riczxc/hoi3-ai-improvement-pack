require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CLaw = Hoi3Object:subclass('hoi3.CLaw')

---
-- @since 1.3
-- @return CLawGroup
function CLaw:GetGroup()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLaw:GetIndex()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return string
function CLaw:GetKey()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CLaw:IsValid()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CLaw:ValidFor(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end
