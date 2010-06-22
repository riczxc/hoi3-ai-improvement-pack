require('hoi3.MultitonObject')

CAISubscriber = MultitonObject:subclass('hoi3.CAISubscriber')

---
-- @since 1.3
-- @return unknown 
function CAISubscriber:WantTicks(...)
	Hoi3Object.throwUnknownSignature()
end