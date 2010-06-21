require('hoi3.Hoi3Object')

CAISubscriber = Hoi3Object:subclass('hoi3.CAISubscriber')

---
-- @since 1.3
-- @return unknown 
function CAISubscriber:WantTicks(...)
	Hoi3Object.throwUnknownSignature()
end