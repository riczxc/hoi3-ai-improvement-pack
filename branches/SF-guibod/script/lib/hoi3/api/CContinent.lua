require('hoi3.Hoi3Object')

CContinent = Hoi3Object:subclass('hoi3.CContinent')

---
-- @since 1.3
-- @return unknown 
function CContinent:GetName()
	return self:loadResultOrFakeOrRandom(
		'string',
		'GetName'
	)
end

---
-- @since 1.3
-- @return string
function CContinent:GetTag()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'GetTag'
	)
end
