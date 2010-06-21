require('hoi3.AbstractObject')

CCurrentGameState = AbstractObject:subclass('hoi3.CCurrentGameState')

---
-- @since 1.3
-- @return number 
function CCurrentGameState.GetAIRand()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountry> 
function CCurrentGameState.GetCountries()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CDate
function CCurrentGameState.GetCurrentDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param string faction
-- @return CFaction
function CCurrentGameState.GetFaction(faction)
	Hoi3Object.assertParameterType(1, faction, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CFaction>
function CCurrentGameState.GetFactions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CCurrentGameState.GetInstance()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag
function CCurrentGameState.GetPlayer()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number provinceId
-- @return CProvince
function CCurrentGameState.GetProvince(provinceId)
	Hoi3Object.assertParameterType(1, provinceId, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
function CCurrentGameState.IsGlobalFlagSet(flagName)
	Hoi3Object.assertParameterType(1, flagName, 'string')

	Hoi3Object.throwNotYetImplemented()
end