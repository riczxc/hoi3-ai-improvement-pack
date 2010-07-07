require('hoi3')

module("hoi3.api", package.seeall)

CCurrentGameState = hoi3.AbstractObject:subclass('hoi3.api.CCurrentGameState')

---
-- Returns a random integer (?) value from 1 to 100 
-- @static
-- @since 1.3
-- @return number 
hoi3.fs(CCurrentGameState, 'GetAIRand', hoi3.RAND_PERC)

---
-- @since 1.3
-- @static
-- @return iterator<CCountry> 
hoi3.fs(CCurrentGameState, 'GetCountries', 'iterator<CCountry>')

function CCurrentGameState.GetCountriesImpl()
	return CCountry:getInstances()
end

---
-- @since 1.3
-- @static
-- @return CDate
hoi3.fs(CCurrentGameState, 'GetCurrentDate', 'CDate')

---
-- @since 1.3
-- @static
-- @param string faction
-- @return CFaction
hoi3.fs(CCurrentGameState, 'GetFaction', 'CFaction')

function CCurrentGameState.GetFactionImpl(faction)
	return CFaction:getInstance(faction)
end

---
-- @since 1.3
-- @static
-- @return iterator<CFaction>
hoi3.fs(CCurrentGameState, 'GetFactions', 'iterator<CFaction>')

function CCurrentGameState.GetFactionsImpl()
	return CFaction:getInstances()
end

---
-- @since 1.3
-- @static
-- @return unknown
hoi3.fs(CCurrentGameState, 'GetInstance', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @static
-- @return CCountryTag
hoi3.fs(CCurrentGameState, 'GetPlayer', 'CCountryTag')

---
-- @since 1.3
-- @static
-- @param number provinceId
-- @return CProvince
hoi3.fs(CCurrentGameState, 'GetProvince', 'CProvince', hoi3.TYPE_NUMBER)

function CCurrentGameState.GetProvinceImpl(provinceId)
	return CProvince:getInstance(provinceId)
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
hoi3.fs(CCurrentGameState, 'IsGlobalFlagSet', hoi3.RAND_BOOL_UNLIKELY, hoi3.TYPE_STRING)