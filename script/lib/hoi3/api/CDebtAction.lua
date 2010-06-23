require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CDebtAction = CDiplomaticAction:subclass('hoi3.CDebtAction')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag debtor
-- @return CDebtAction
function CDebtAction:initialize(actor, debtor)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, debtor, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end