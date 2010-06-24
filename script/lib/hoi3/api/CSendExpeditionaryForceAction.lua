require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CSendExpeditionaryForceAction = CDiplomaticAction:subclass('hoi3.CSendExpeditionaryForceAction')

--[[
	FIXME: there is a function CSendExpeditionaryForceAction as well
	as static properties for CSendExpeditionaryForceAction  ?!

	There something i don't understand with lua :) 
]]
CSendExpeditionaryForceAction.TAKE = 1
CSendExpeditionaryForceAction.SEND = 1

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceAction:GetClaimType(...)	
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceAction:GetUnit(...)	
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceAction:GetTag(...)	
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CSendExpeditionaryForceAction
function CSendExpeditionaryForceAction:initialize(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end