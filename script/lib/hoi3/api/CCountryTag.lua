require('hoi3')

module("hoi3.api", package.seeall)

CCountryTag = hoi3.MultitonObject:subclass('hoi3.CCountryTag')

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
hoi3.f(CCountryTag, 'GetCountry', 'CCountry')

function CCountryTag:GetCountryImpl()
	return CCountry(self)
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountryTag, 'GetIndex', hoi3.NUMBER)

function CCountryTag:GetIndexImpl()
	return self:getIndexInDictionnary(CCountryTag:getInstances())
end

---
-- @since 1.3
-- @return CCountryTag 
hoi3.f(CCountryTag, 'GetTag', 'CCountryTag')

function CCountryTag:GetTagImpl()
	return self
end

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountryTag, 'IsReal', hoi3.RAND_BOOL_VLIKELY)

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountryTag, 'IsValid', hoi3.RAND_BOOL_VLIKELY)


function CCountryTag:__tostring()
	return self.tag
end

-- A random CountryTag is a random EXISTING tag !
function CCountryTag.random()
	return hoi3.randomTableMember(CCountryTag:getInstances())
end