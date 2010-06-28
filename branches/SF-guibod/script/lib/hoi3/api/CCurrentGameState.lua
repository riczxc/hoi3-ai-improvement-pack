require('hoi3')

module("hoi3.api", package.seeall)

CCurrentGameState = hoi3.AbstractObject:subclass('hoi3.CCurrentGameState')

local r1to100 = hoi3.Randomizer(hoi3.TYPE_NUMBER)
r1to100.min = 1
r1to100.max = 100

---
-- Returns a random integer (?) value from 1 to 100 
-- @static
-- @since 1.3
-- @return number 
hoi3.f(CCurrentGameState, 'GetAIRand', true, r1to100)

---
-- @since 1.3
-- @static
-- @return table<CCountry> 
hoi3.f(CCurrentGameState, 'GetCountries', true, 'table<CCountry>')

function CCurrentGameState.GetCountriesImpl()
	require("hoi3.conf")
	return hoi3.conf.countryDatabase()
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
	hoi3.assertParameterType(1, faction, hoi3.TYPE_STRING)
	
	-- create instance for all factions
	hoi3.conf.factionDatabase()
	return CFaction:getInstance(faction)
end

---
-- @since 1.3
-- @static
-- @return table<CFaction>
hoi3.f(CCurrentGameState, 'GetFactions', true, 'table<CFaction>')

function CCurrentGameState.GetFactionsImpl()
	require("hoi3.conf")
	return hoi3.conf.factionDatabase()
end

---
-- @since 1.3
-- @static
-- @return unknown
function CCurrentGameState.GetInstance()
	hoi3.throwUnknownReturnType()
end

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
	hoi3.assertParameterType(1, provinceId, hoi3.TYPE_NUMBER)
	
	-- create instance for all factions
	hoi3.conf.provinceDatabase()
	return CProvince:getInstance(provinceId)
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
hoi3.f(CCurrentGameState, 'IsGlobalFlagSet', true, hoi3.TYPE_BOOLEAN, hoi3.TYPE_STRING)