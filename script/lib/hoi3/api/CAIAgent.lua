require('hoi3.api.CAISubscriber')

CAIAgent = CAISubscriber:subclass('hoi3.CAIAgent')

---
-- @param CCountryTag countryTag
function CAIAgent:initalize(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return CCountryTag 
function CAIAgent:GetCountryTag()
	return self.countryTag
end

---
-- @since 1.3
-- @return CCountry
function CAIAgent:GetCountry()
	-- returns current instance
	return CCountry:new(self.countryTag)
end
  
---
-- @since 1.3
-- @return CAI
function CAIAgent:GetOwnerAI()
	-- returns current instance
	return CAI:new(self.countryTag)
end