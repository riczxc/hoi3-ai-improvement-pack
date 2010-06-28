require('hoi3')

CBuilding = hoi3.MultitonObject:subclass('hoi3.CBuilding')

---
-- @since 1.3
-- @param number index
-- @param string name
-- @return string 
function CBuilding:initialize(index, name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, index, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(2, name, hoi3.TYPE_STRING)
	
	self.index = index
	self.name = name
end

---
-- @since 1.3
-- @return string 
hoi3.f(CBuilding, 'GetName', false, hoi3.TYPE_STRING)

function CBuilding:GetNameImpl()
	return self.name
end

---
-- @since 1.3
-- @return number
hoi3.f(CBuilding, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CBuilding:GetIndexImpl()
	return self.index
end

function CBuilding.random()
	return randomTableMember(CBuilding:getInstances())
end