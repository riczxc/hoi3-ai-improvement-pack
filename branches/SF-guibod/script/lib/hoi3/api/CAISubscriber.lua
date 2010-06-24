require('hoi3')

module("hoi3.api", package.seeall)

CAISubscriber = hoi3.MultitonObject:subclass('hoi3.CAISubscriber')

---
-- @since 1.3
-- @return unknown 
function CAISubscriber:WantTicks(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end