require('hoi3')

module("hoi3.api", package.seeall)

CCurrentGameState = hoi3.AbstractObject:subclass('hoi3.CCurrentGameState')

---
-- Returns a random integer (?) value from 1 to 100 
-- @static
-- @since 1.3
-- @return number 
hoi3.f(CCurrentGameState, 'GetAIRand', true, hoi3.RAND_PERC)

---
-- @since 1.3
-- @static
-- @return table<CCountry> 
hoi3.f(CCurrentGameState, 'GetCountries', true, 'table<CCountry>')

function CCurrentGameState.GetCountriesImpl()
	return CCountry:getInstances()
end

---
-- @since 1.3
-- @static
-- @return CDate
hoi3.f(CCurrentGameState, 'GetCurrentDate', true, 'CDate')

---
-- @since 1.3
-- @static
-- @param string faction
-- @return CFaction
hoi3.f(CCurrentGameState, 'GetFaction', true, 'CFaction')

function CCurrentGameState.GetFactionImpl(faction)
	return CFaction:getInstance(faction)
end

---
-- @since 1.3
-- @static
-- @return table<CFaction>
hoi3.f(CCurrentGameState, 'GetFactions', true, 'table<CFaction>')

function CCurrentGameState.GetFactionsImpl()
	return CFaction:getInstances()
end

---
-- @since 1.3
-- @static
-- @return unknown
hoi3.f(CCurrentGameState, 'GetInstance', true, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @static
-- @return CCountryTag
hoi3.f(CCurrentGameState, 'GetPlayer', true, 'CCountryTag')

---
-- @since 1.3
-- @static
-- @param number provinceId
-- @return CProvince
hoi3.f(CCurrentGameState, 'GetProvince', true, 'CProvince', hoi3.TYPE_NUMBER)

function CCurrentGameState.GetProvinceImpl(provinceId)
	return CProvince:getInstance(provinceId)
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
hoi3.f(CCurrentGameState, 'IsGlobalFlagSet', true, hoi3.RAND_BOOL_UNLIKELY, hoi3.TYPE_STRING)