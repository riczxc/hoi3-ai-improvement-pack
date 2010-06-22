require('hoi3.Hoi3Object')

CCommand = Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @return bool 
function CCommand:isValid()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'isValid'
	)
end