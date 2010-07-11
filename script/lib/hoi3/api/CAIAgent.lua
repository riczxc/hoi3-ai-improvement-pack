require('hoi3.api.CAISubscriber')

module("hoi3.api", package.seeall)

CAIAgent = CAISubscriber:subclass('hoi3.api.CAIAgent')

---
-- @param CCountryTag countryTag
function CAIAgent:initialize(tag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	self.tag = tag
end

---
-- @since 1.3
-- @return CCountryTag 
hoi3.f(CAIAgent, 'GetCountryTag', 'CCountryTag')

function CAIAgent:GetCountryTagImpl()
	return self.tag
end

---
-- @since 1.3
-- @return CCountry
hoi3.f(CAIAgent, 'GetCountry', 'CCountry')

function CAIAgent:GetCountryImpl()
	return CCountry(self.tag)
end