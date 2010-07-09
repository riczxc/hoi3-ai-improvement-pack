require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CAllianceAction = CDiplomaticAction:subclass('hoi3.api.CAllianceAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CAllianceAction.constructorSignature = {'CCountryTag', 'CCountryTag'}

---
-- @since 1.3
-- @return CAllianceAction
function CAllianceAction:initialize(tag,  ally)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, ally, 'CCountryTag')
	
	self.tag = tag
	self.ally = ally
end

function CAllianceAction:desc()
	return tostring(self.tag).." is now "..tostring(self.ally).. " ally."
end