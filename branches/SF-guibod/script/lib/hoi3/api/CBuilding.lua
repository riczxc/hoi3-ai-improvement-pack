require('hoi3.Hoi3Object')

CBuilding = Hoi3Object:subclass('hoi3.CBuilding')

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
