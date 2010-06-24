require('hoi3')

CBuilding = hoi3.MultitonObject:subclass('hoi3.CBuilding')

---
-- @since 1.3
-- @param number index
-- @param string name
-- @return string 
function CBuilding:initialize(index, name)
	hoi3.assertParameterType(1, index, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(2, name, hoi3.TYPE_STRING)
	
	self.index = index
	self.name = name
end

---
-- @since 1.3
-- @return string 
function CBuilding:GetName()
	hoi3.assertNonStatic(self)
	return self.name
end

---
-- @since 1.3
-- @return number
function CBuilding:GetIndex()
	hoi3.assertNonStatic(self)
	return self.index
end
