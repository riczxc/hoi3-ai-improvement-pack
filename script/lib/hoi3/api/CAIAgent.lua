require('hoi3.api.CAISubscriber')

CAIAgent = CAISubscriber:subclass('hoi3.CAIAgent')

---
-- @since 1.3
-- @return CCountryTag 
function CAIAgent:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountry
function CAIAgent:GetCountry()
	Hoi3Object.throwNotYetImplemented()
end
  
---
-- @since 1.3
-- @return CAI
function CAIAgent:GetOwnerAI()
	Hoi3Object.throwNotYetImplemented()
end