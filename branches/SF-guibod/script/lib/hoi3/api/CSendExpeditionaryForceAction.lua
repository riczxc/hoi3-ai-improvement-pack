require('hoi3.api.CDiplomaticAction')

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
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceAction:GetUnit(...)	
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceAction:GetTag(...)	
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CSendExpeditionaryForceAction
function CSendExpeditionaryForceAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end