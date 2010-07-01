require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CStartResearchCommand = CCommand:subclass('hoi3.CStartResearchCommand')

---
-- @since 1.3
-- @param CCountryTag  country
-- @param CTechnology  techno
-- @return CStartResearchCommand
function CStartResearchCommand:initialize(tag, techno)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, techno, 'CTechnology')

	self.tag = tag
	self.techno = techno
end

function CStartResearchCommand:desc()
	return tostring(self.techno).." research started by "..tostring(self.tag).."."
end