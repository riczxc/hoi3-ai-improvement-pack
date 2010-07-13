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

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CAllianceAction, 'Create', hoi3.TYPE_UNKNOWN)

function CAllianceAction:desc()
	return tostring(self.tag).." is now "..tostring(self.ally).. " ally."
end