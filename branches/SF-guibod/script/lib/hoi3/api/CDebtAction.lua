require('hoi3.api.CDiplomaticAction')

CDebtAction = CDiplomaticAction:subclass('hoi3.CDebtAction')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag debtor
-- @return CDebtAction
function CDebtAction:initialize(actor, debtor)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, debtor, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end