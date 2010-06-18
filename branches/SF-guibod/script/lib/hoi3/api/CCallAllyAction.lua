require('hoi3.api.CDiplomaticAction')

CCallAllyActionObject = CDiplomaticActionObject:subclass('hoi3.CCallAllyActionObject')

---
-- @since 1.3
-- @return unknown
function CCallAllyActionObject:Create(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyActionObject:GetVersus(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CCallAllyActionObject:SetVersus(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag ally
-- @param CCountryTag target
-- @return CCallAllyActionObject
function CCallAllyAction(actor, ally, target)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, ally, 'CCountryTag')
	Hoi3Object.assertParameterType(3, target, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end