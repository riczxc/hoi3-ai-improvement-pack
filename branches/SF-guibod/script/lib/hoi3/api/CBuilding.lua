require('hoi3')

CBuilding = hoi3.MultitonObject:subclass('hoi3.api.CBuilding')

---
-- @since 1.3
-- @param number index
-- @param string name
-- @return string 
function CBuilding:initialize(name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, name, hoi3.TYPE_STRING)
	
	self.name = name
end

---
-- @since 1.3
-- @return string 
hoi3.f(CBuilding, 'GetName', hoi3.TYPE_STRING)

function CBuilding:GetNameImpl()
	return self.name
end

---
-- @since 1.3
-- @return number
hoi3.f(CBuilding, 'GetIndex', hoi3.TYPE_NUMBER)

function CBuilding:GetIndexImpl()
	return self:getIndexInDictionnary(CBuilding:getInstances())
end

function CBuilding.random()
	return hoi3.randomTableMember(CBuilding:getInstances())
end