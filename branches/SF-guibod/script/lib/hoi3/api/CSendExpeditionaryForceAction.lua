require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CSendExpeditionaryForceAction = CDiplomaticAction:subclass('hoi3.api.CSendExpeditionaryForceAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
CSendExpeditionaryForceAction.constructorSignature = {'CCountryTag','CCountryTag'}

CSendExpeditionaryForceAction.TAKE = 1
CSendExpeditionaryForceAction.SEND = 1

---
-- @since 1.3
-- @param CCountryTag ,
-- @param CCountryTag target
-- @return CSendExpeditionaryForceAction
function CSendExpeditionaryForceAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CSendExpeditionaryForceAction, 'GetClaimType', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CSendExpeditionaryForceAction, 'GetUnit', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CSendExpeditionaryForceAction, 'GetTag', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)


function CSendExpeditionaryForceAction:desc()
	return tostring(self.tag).." sends expeditionnary to "..tostring(self.target).. "."
end
