require('hoi3.MultitonObject')

module("hoi3.api", package.seeall)

CAISubscriber = MultitonObject:subclass('hoi3.CAISubscriber')

---
-- @since 1.3
-- @return unknown 
function CAISubscriber:WantTicks(...)
	hoi3.throwUnknownSignature()
end