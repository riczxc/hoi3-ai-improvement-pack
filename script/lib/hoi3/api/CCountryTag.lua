require('hoi3')

module("hoi3.api", package.seeall)

CCountryTag = hoi3.Hoi3Object:subclass('hoi3.CCountryTag')

---
-- @since 1.3
-- @param string tag
-- @return CCountry 
function CCountryTag:initialize(tag)
	hoi3.assertParameterType(1, tag, 'string')
	assert(string.len(tag)==3, "A country tag must be 3 character long.")
	
	self.tag = tag
end

---
-- @since 1.3
-- @return CCountry 
function CCountryTag:GetCountry()
	return CCountry:new(self.tag)
end

---
-- @since 1.3
-- @return number 
function CCountryTag:GetIndex()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountryTag:GetTag()
	return self.tag
end

---
-- @since 1.3
-- @return bool 
function CCountryTag:IsReal()
	return CCountryTag:loadResultOrFakeOrRandom(
		'boolean',
		'IsReal'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountryTag:IsValid()
	return CCountryTag:loadResultOrFakeOrRandom(
		'boolean',
		'IsValid'
	)
end


function CCountryTag.random()
	local availableTags = {}
end