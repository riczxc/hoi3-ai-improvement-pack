require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CDebtAction = CDiplomaticAction:subclass('hoi3.api.CDebtAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CDebtAction.constructorSignature = {'CCountryTag','CCountryTag' }

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag debtor
-- @return CDebtAction
function CDebtAction:initialize(tag, debtor)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, debtor, 'CCountryTag')

	self.tag = tag
	self.debtor = debtor
end

function CDebtAction:desc()
	return tostring(self.tag).." now allows "..tostring(self.debtor).. " debt."
end