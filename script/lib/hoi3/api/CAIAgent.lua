require('hoi3.Hoi3Object')

CAIAgent = Hoi3Object:subclass('hoi3.CAISubscriber')

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