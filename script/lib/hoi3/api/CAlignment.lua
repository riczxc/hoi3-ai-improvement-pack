require('hoi3')

module("hoi3.api", package.seeall)

CAlignment = hoi3.Hoi3Object:subclass('hoi3.CAlignment')

---
-- @since 1.3
-- @param CIdeologyGroup ideologyGroup
-- @return number 
function CAlignment:GetLastDrift(ideologyGroup)
	hoi3.assertParameterType(1, ideologyGroup, 'CIdeologyGroup')
	
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
	hoi3.throwUnknownReturnType()
end