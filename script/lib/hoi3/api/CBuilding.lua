require('hoi3')

CBuilding = hoi3.MultitonObject:subclass('hoi3.CBuilding')

---
-- @since 1.3
-- @param number index
-- @param string name
-- @return string 
function CBuilding:initialize(index, name)
	hoi3.assertParameterType(1, country, 'CCountry')
	hoi3.assertParameterType(1, country, 'CCountry')
	
	self.index = index
	self.name = name
end

---
-- @since 1.3
-- @return string 
function CBuilding:GetName()
	return self:loadResultOrFakeOrRandom(
		'string',
		'GetName'
	)
end

---
-- @since 1.3
-- @return number
function CBuilding:GetIndex()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetIndex'
	)
end
