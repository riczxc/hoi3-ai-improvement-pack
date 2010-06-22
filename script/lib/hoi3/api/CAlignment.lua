require('hoi3.Hoi3Object')

CAlignment = Hoi3Object:subclass('hoi3.CAlignment')

---
-- @since 1.3
-- @param CIdeologyGroup ideologyGroup
-- @return number 
function CAlignment:GetLastDrift(ideologyGroup)
	Hoi3Object.assertParameterType(1, ideologyGroup, 'CIdeologyGroup')
	
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetLastDrift',
		ideologyGroup
	)
end

---
-- @since 1.3
-- @return unknown
function CAlignment:GetDistanceFrom()
	Hoi3Object.throwUnknownReturnType()
end