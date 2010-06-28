require('hoi3.api.CAISubscriber')

module("hoi3.api", package.seeall)

CAIAgent = CAISubscriber:subclass('hoi3.CAIAgent')

---
-- @param CCountryTag countryTag
function CAIAgent:initalize(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')

	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return CCountryTag 
hoi3.f(CAIAgent, 'GetCountryTag', false, 'CCountryTag')

function CAIAgent:GetCountryTagImpl()
	return self.countryTag
end

---
-- @since 1.3
-- @return CCountry
hoi3.f(CAIAgent, 'GetCountry', false, 'CCountry')

function CAIAgent:GetCountryImpl()
	return CCountry(self.countryTag)
end
  
---
-- @since 1.3
-- @return CAI
hoi3.f(CAIAgent, 'GetOwnerAI', false, 'CAI')

function CAIAgent:GetOwnerAIImpl()
	return CAI(self.countryTag)
end