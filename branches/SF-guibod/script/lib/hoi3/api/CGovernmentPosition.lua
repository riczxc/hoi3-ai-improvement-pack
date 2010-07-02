require('hoi3')

module("hoi3.api", package.seeall)

CGovernmentPosition = hoi3.MultitonObject:subclass('hoi3.CGovernmentPosition')

---
-- @since 1.3
-- @param string key
-- @return string 
function CGovernmentPosition:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

-- A random CGovernmentPosition is a random EXISTING tag !
function CGovernmentPosition.random()
	return hoi3.randomTableMember(CGovernmentPosition:getInstances())
end