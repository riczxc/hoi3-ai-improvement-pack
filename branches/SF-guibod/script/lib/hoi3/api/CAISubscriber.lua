require('hoi3.Hoi3Object')

CAISubscriberObject = Hoi3Object:subclass('hoi3.CAISubscriberObject')

---
-- @since 1.3
-- @return unknown 
function CAISubscriberObject:WantTicks(...)
	Hoi3Object.throwUnknownSignature()
end