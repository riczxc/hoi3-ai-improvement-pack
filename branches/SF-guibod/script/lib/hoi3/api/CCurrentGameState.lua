require('hoi3')

module("hoi3.api", package.seeall)

CCurrentGameState = hoi3.AbstractObject:subclass('hoi3.CCurrentGameState')

---
-- Returns a random integer (?) value from 1 to 100 
-- @since 1.3
-- @return number 
function CCurrentGameState.GetAIRand()
	math.randomseed(os.time())
	return math.random(100)
end

---
-- @since 1.3
-- @return table<CCountry> 
function CCurrentGameState.GetCountries()
	--TODO: get infos from CCountryDatabase
	
	return CCurrentGameState.loadResultOrImplOrRandom(
		CCurrentGameState
		'table<CCountry>',
		'GetCountries'
	)
end

---
-- @since 1.3
-- @return CDate
function CCurrentGameState.GetCurrentDate()
	return CCurrentGameState:loadResultOrImplOrRandom(
		'CDate',
		'GetCurrentDate'
	)
end

---
-- @since 1.3
-- @param string faction
-- @return CFaction
function CCurrentGameState.GetFaction(faction)
	hoi3.assertParameterType(1, faction, 'string')
	
	return CCurrentGameState:loadResultOrImplOrRandom(
		'CFaction',
		'GetFaction',
		faction
	)
end

function CCurrentGameState.GetFactionImpl(faction)
	hoi3.assertParameterType(1, faction, 'string')
	
	for i,k in ipairs(CCurrentGameState.GetFactions()) do
		if k.GetName() == faction then
			return k
		end
	end
end

---
-- @since 1.3
-- @return table<CFaction>
function CCurrentGameState.GetFactions()
	return CCurrentGameState:loadResultOrImplOrRandom(
		'table<CFaction>',
		'GetFactions',
		faction
	)
end

function CCurrentGameState.GetFactionsImpl()
	return {
		CFaction('axis'),
		CFaction('allies'),
		CFaction('comintern')
	}
end

---
-- @since 1.3
-- @return unknown
function CCurrentGameState.GetInstance()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag
function CCurrentGameState.GetPlayer()
	return CCurrentGameState:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetPlayer'
	)
end

---
-- @since 1.3
-- @param number provinceId
-- @return CProvince
function CCurrentGameState.GetProvince(provinceId)
	hoi3.assertParameterType(1, provinceId, 'number')

	return CCurrentGameState:loadResultOrImplOrRandom(
		'CProvince',
		'GetProvince',
		provinceId
	)
end

---
-- @since 1.4
-- @param string flagName
-- @return bool
function CCurrentGameState.IsGlobalFlagSet(flagName)
	hoi3.assertParameterType(1, flagName, 'string')

	hoi3.throwNotYetImplemented()
end