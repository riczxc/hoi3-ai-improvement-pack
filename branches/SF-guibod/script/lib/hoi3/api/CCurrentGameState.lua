require('hoi3.Hoi3Object')

CCurrentGameStateObject = Hoi3Object:subclass('hoi3.CCurrentGameStateObject')

---
-- @since 1.3
-- @return number 
function CCurrentGameStateObject.GetAIRand()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountry> 
function CCurrentGameStateObject.GetCountries()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CDate
function CCurrentGameStateObject.GetCurrentDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param string faction
-- @return CFaction
function CCurrentGameStateObject.GetFaction(faction)
	Hoi3Object.assertParameterType(1, faction, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CFaction>
function CCurrentGameStateObject.GetFactions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CCurrentGameStateObject.GetInstance()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag
function CCurrentGameStateObject.GetPlayer()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number provinceId
-- @return CProvince
function CCurrentGameStateObject.GetProvince(provinceId)
	Hoi3Object.assertParameterType(1, provinceId, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
function CCurrentGameStateObject.IsGlobalFlagSet(flagName)
	Hoi3Object.assertParameterType(1, flagName, 'string')

	Hoi3Object.throwNotYetImplemented()
end

-- CCurrentGameState has static methods and properties
-- we need to declare a CCurrentGameState table
CCurrentGameState = CCurrentGameStateObject