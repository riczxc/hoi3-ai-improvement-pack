require('hoi3.api.CDiplomaticAction')

CCallAllyAction = CDiplomaticAction:subclass('hoi3.CCallAllyAction')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag ally
-- @param CCountryTag target
-- @return CCallAllyAction
function CCallAllyAction:initialize(actor, ally, target)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, ally, 'CCountryTag')
	Hoi3Object.assertParameterType(3, target, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyAction:GetVersus(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyAction:SetVersus(...)
	Hoi3Object.throwUnknownSignature()
end