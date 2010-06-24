require('hoi3')

module("hoi3.api", package.seeall)

CCountryTag = hoi3.Hoi3Object:subclass('hoi3.CCountryTag')

---
-- @since 1.3
-- @param string tag
-- @return CCountry 
function CCountryTag:initialize(tag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, hoi3.TYPE_STRING)
	assert(string.len(tag)==3, "A country tag must be 3 character long.")
	
	self.tag = tag
end

---
-- @since 1.3
-- @return CCountry 
function CCountryTag:GetCountry()
	hoi3.assertNonStatic(self)
	
	return CCountry(self)
end

---
-- @since 1.3
-- @return number 
function CCountryTag:GetIndex()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountryTag:GetTag()
	hoi3.assertNonStatic(self)
	return self
end

---
-- @since 1.3
-- @return bool 
function CCountryTag:IsReal()
	hoi3.assertNonStatic(self)
	return CCountryTag:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsReal'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountryTag:IsValid()
	hoi3.assertNonStatic(self)
	return CCountryTag:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsValid'
	)
end