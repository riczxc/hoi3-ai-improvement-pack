require('hoi3.api.CDiplomaticAction')

CDebtActionObject = CDiplomaticActionObject:subclass('hoi3.CDebtActionObject')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag debtor
-- @return CDebtActionObject
function CDebtAction(actor, debtor)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, debtor, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end