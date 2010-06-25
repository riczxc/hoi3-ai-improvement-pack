require('hoi3')

module("hoi3.api", package.seeall)

CLaw = hoi3.Hoi3Object:subclass('hoi3.CLaw')

function CLaw:initialize(key)
	hoi3.assertNonStatic(self)
	
	self.key = key
end

---
-- @since 1.3
-- @return CLawGroup
function CLaw:GetGroup()
	hoi3.assertNonStatic(self)
	
	return CIdeologyData:loadResultOrImplOrRandom(
		'CLawGroup',
		'GetGroup'
	)
end

---
-- @since 1.3
-- @return number
function CLaw:GetIndex()
	hoi3.assertNonStatic(self)
	
	return CIdeologyData:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetIndex'
	)
end

---
-- @since 1.3
-- @return string
function CLaw:GetKey()
	hoi3.assertNonStatic(self)
	
	return CIdeologyData:loadResultOrImplOrRandom(
		hoi3.TYPE_STRING,
		'GetKey'
	)
end

---
-- @since 1.3
-- @return string
function CLaw:GetKeyImpl()
	hoi3.assertNonStatic(self)
	
	return self.key
end

---
-- @since 1.3
-- @return bool
function CLaw:IsValid()
	hoi3.assertNonStatic(self)
	
	return CIdeologyData:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsValid'
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CLaw:ValidFor(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')

	return CIdeologyData:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'ValidFor',
		countryTag
	)
end
