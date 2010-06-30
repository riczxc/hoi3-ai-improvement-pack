require('hoi3')

module("hoi3.api", package.seeall)

CContinent = hoi3.MultitonObject:subclass('hoi3.CContinent')

---
--
function CContinent:initialize(tag, name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, hoi3.TYPE_STRING)
	
	self.tag = tag
end 

---
-- @since 1.3
-- @return string 
hoi3.f(CContinent, 'GetName', false, hoi3.TYPE_STRING)

---
-- @since 1.3
-- @return string
hoi3.f(CContinent, 'GetTag', false, hoi3.TYPE_STRING)

function CContinent:GetTagImpl()
	return self.tag
end

function CContinent.random()
	return hoi3.randomTableMember(CContinent:getInstances())
end