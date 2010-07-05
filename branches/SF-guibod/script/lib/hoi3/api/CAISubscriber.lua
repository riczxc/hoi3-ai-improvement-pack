require('hoi3')

module("hoi3.api", package.seeall)

CAISubscriber = hoi3.MultitonObject:subclass('hoi3.CAISubscriber')

---
-- @since 1.3
-- @param unknown
-- @return unknown 
hoi3.f(CAISubscriber, 'WantTicks', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)