require('hoi3.Hoi3Object')

CAIAgentObject = Hoi3Object:subclass('hoi3.CAISubscriber')

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
function CAIEspionageMinisterObject:GetOwnerAI()
	Hoi3Object.throwNotYetImplemented()
end