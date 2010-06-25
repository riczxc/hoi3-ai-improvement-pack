require('hoi3')

module("hoi3.api", package.seeall)

CCurrentGameState = hoi3.AbstractObject:subclass('hoi3.CCurrentGameState')

---
-- Returns a random integer (?) value from 1 to 100 
-- @since 1.3
-- @return number 
function CCurrentGameState.GetAIRand()
	local r = hoi3.Randomizer(hoi3.TYPE_NUMBER)
	r.min = 1
	r.max = 100
	
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		r,
		'GetAIRand'
	)
end

---
-- @since 1.3
-- @static
-- @return table<CCountry> 
function CCurrentGameState.GetCountries()
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState
		'table<CCountry>',
		'GetCountries'
	)
end

function CCurrentGameState.GetCountriesImpl()
	require("hoi3.conf")
	return hoi3.conf.countryDatabase()
end

---
-- @since 1.3
-- @static
-- @return CDate
function CCurrentGameState.GetCurrentDate()
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		'CDate',
		'GetCurrentDate'
	)
end

---
-- @since 1.3
-- @static
-- @param string faction
-- @return CFaction
function CCurrentGameState.GetFaction(faction)
	hoi3.assertParameterType(1, faction, hoi3.TYPE_STRING)
	
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		'CFaction',
		'GetFaction',
		faction
	)
end

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
function CCurrentGameState.GetFactions()
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		'table<CFaction>',
		'GetFactions',
		faction
	)
end

function CCurrentGameState.GetFactionsImpl()
	require("hoi3.conf")
	return hoi3.conf.factionDatabase()
end

---
-- @since 1.3
-- @return unknown
function CCurrentGameState.GetInstance()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @static
-- @return CCountryTag
function CCurrentGameState.GetPlayer()
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		'CCountryTag',
		'GetPlayer'
	)
end

---
-- @since 1.3
-- @static
-- @param number provinceId
-- @return CProvince
function CCurrentGameState.GetProvince(provinceId)
	hoi3.assertParameterType(1, provinceId, hoi3.TYPE_NUMBER)

	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState,
		'CProvince',
		'GetProvince',
		provinceId
	)
end

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
function CCurrentGameState.IsGlobalFlagSet(flagName)
	hoi3.assertParameterType(1, flagName, hoi3.TYPE_STRING)

	return CCurrentGameState:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsGlobalFlagSet',
		flagName
	)
end