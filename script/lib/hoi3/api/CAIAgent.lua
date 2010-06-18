require('hoi3.api.CAISubscriber')

CAIAgentObject = CAISubscriberObject:subclass('hoi3.CAIAgentObject')

---
-- @since 1.3
-- @return CCountryTag 
function CAIAgentObject:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountry
function CAIAgentObject:GetCountry()
	Hoi3Object.throwNotYetImplemented()
end
  
---
-- @since 1.3
-- @return CAI
function CAIAgentObject:GetOwnerAI()
	Hoi3Object.throwNotYetImplemented()
end