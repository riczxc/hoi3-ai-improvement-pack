require('hoi3')

module("hoi3.api", package.seeall)

CIdeology = hoi3.Hoi3Object:subclass('hoi3.CIdeology')

---
-- @since 1.3
-- @return CIdeologyGroup
function CIdeology:GetGroup()
	hoi3.assertNonStatic(self)
	
	return CIdeology:loadResultOrImplOrRandom(
		'CIdeologyGroup',
		'GetGroup'
	)
end