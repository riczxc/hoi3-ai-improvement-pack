require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CGuaranteeAction = CDiplomaticAction:subclass('hoi3.api.CGuaranteeAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag guarantee
-- @return CGuaranteeAction
function CGuaranteeAction:initialize(tag, guarantee)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, guarantee, 'CCountryTag')

	self.tag = tag
	self.guarantee = guarantee
end

function CGuaranteeAction:desc()
	return tostring(self.tag).." guarantees "..tostring(self.ally).. "."
end