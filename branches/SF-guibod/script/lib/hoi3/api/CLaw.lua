require('hoi3.Hoi3Object')

CLawObject = Hoi3Object:subclass('hoi3.CLawObject')

---
-- @since 1.3
-- @return CLawGroup
function CLawObject:GetGroup()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawObject:GetIndex()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return string
function CLawObject:GetKey()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CLawObject:IsValid()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CLawObject:ValidFor(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end
