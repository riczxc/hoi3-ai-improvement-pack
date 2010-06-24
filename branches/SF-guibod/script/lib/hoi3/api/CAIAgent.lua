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
function CAIAgent:GetCountryTag()
	hoi3.assertNonStatic(self)
	return self.countryTag
end

---
-- @since 1.3
-- @return CCountry
function CAIAgent:GetCountry()
	hoi3.assertNonStatic(self)
	-- returns current instance
	return CCountry(self.countryTag)
end
  
---
-- @since 1.3
-- @return CAI
function CAIAgent:GetOwnerAI()
	hoi3.assertNonStatic(self)
	-- returns current instance
	return CAI(self.countryTag)
end