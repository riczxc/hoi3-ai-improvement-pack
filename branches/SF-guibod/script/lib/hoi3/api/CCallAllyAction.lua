require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CCallAllyAction = CDiplomaticAction:subclass('hoi3.CCallAllyAction')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag ally
-- @param CCountryTag target
-- @return CCallAllyAction
function CCallAllyAction:initialize(actor, ally, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, ally, 'CCountryTag')
	hoi3.assertParameterType(3, target, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyAction:GetVersus(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyAction:SetVersus(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end