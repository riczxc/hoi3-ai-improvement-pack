require('hoi3.Hoi3Object')

CLaw = Hoi3Object:subclass('hoi3.CLaw')

---
-- @since 1.3
-- @return CLawGroup
function CLaw:GetGroup()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLaw:GetIndex()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return string
function CLaw:GetKey()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CLaw:IsValid()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CLaw:ValidFor(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end
