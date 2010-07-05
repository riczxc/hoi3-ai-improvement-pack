require('hoi3')

module("hoi3.api", package.seeall)

CIdeology = hoi3.MultitonObject:subclass('hoi3.CIdeology')

function CIdeology:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)

	self.key = key
end

---
-- @since 1.3
-- @return CIdeologyGroup
hoi3.f(CIdeology, 'GetGroup', 'CIdeologyGroup')

-- A random CIdeology is a random EXISTING tag !
function CIdeology.random()
	return hoi3.randomTableMember(CIdeology:getInstances())
end