require('hoi3.api.CDiplomaticAction')

CSendExpeditionaryForceActionObject = CDiplomaticActionObject:subclass('hoi3.CSendExpeditionaryForceAction')

--[[
	FIXME: there is a function CSendExpeditionaryForceAction as well
	as static properties for CSendExpeditionaryForceAction object ?!

	There something i don't understand with lua :) 
]]
CSendExpeditionaryForceActionObject.TAKE = 1
CSendExpeditionaryForceActionObject.SEND = 1

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceActionObject:GetClaimType(...)	
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceActionObject:GetUnit(...)	
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 2.0
-- @return unknown
function CSendExpeditionaryForceActionObject:GetTag(...)	
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CSendExpeditionaryForceActionObject
function CSendExpeditionaryForceAction(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end