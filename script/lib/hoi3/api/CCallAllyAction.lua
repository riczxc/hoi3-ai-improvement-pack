require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CCallAllyAction = CDiplomaticAction:subclass('hoi3.api.CCallAllyAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CCallAllyAction.constructorSignature = {'CCountryTag','CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag ally
-- @param CCountryTag target
-- @return CCallAllyAction
function CCallAllyAction:initialize(tag, ally, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, ally, 'CCountryTag')
	hoi3.assertParameterType(3, target, 'CCountryTag')

	self.tag = tag
	self.ally = ally
	self.target = target
	self.isLimited = false
end

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCallAllyAction, 'GetVersus', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCallAllyAction, 'SetVersus', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown 
hoi3.fs(CCallAllyAction, 'Create', hoi3.TYPE_UNKNOWN)

function CCallAllyAction:desc()
	local str
	if self.isLimited then str = "limited " end
	return tostring(self.tag).." calls "..tostring(self.ally).. " to "..str.."war against "..tostring(self.target).."."
end