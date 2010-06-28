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

	self.actor = actor
	self.ally = ally
	self.target = target
end

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCallAllyAction, 'GetVersus', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCallAllyAction, 'SetVersus', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)