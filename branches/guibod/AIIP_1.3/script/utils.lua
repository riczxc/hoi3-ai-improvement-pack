---------------------------------
-- Utils
-- general utility functions
---------------------------------

local P = {}
Utils = P

-----------------------------------------------------------------------------
-- Log specific content
--
-- A simple log framework based on Log4Lua.
-- Log are categorized by minister : diplo, intel, politics and production
-- Another fallback/main category is available for other stuff (ROOT)
--
-- Basic usage :
-- > Utils.info("Non-Agression pact signed with ITA.", "GER", "DIPLO")
--
-- Log system remembers last used category, you can omit it for the second occurence in log
-- > Utils.info("Non-Agression pact signed with ITA.", "GER", "DIPLO")
-- > Utils.info("Rejected trade from POR", "GER")
-- Or explicitely reset it
-- > Utils.setLogCat("DIPLO")
-- > Utils.info("Non-Agression pact signed with ITA.", "GER")
-- > Utils.info("Rejected trade from POR", "GER")
--
-- * Utils.debug(message [, category])
-- * Utils.info (message [, category])
-- * Utils.warn (message [, category])
-- * Utils.error(message [, category])
-- * Utils.fatal(message [, category])
-----------------------------------------------------------------------------
-- provide an easy way to disable logging (release)
if true then
	local Log4Lua = require('log4lua.logger')

	-- @see http://www.hscale.org/display/LUA/Log4LUA
	local logConf = {
	--	CATEG = { level = Log4Lua.CONST,	files = { ... } [, pattern = "log4lua format pattern"][, datepattern = "log rotation date pattern"] },
		ROOT  = { level = Log4Lua.INFO,	files = { "AIIP-%s.log" }},
		DIPLO = { level = Log4Lua.INFO, 	files = { "AIIP-%s.log", "DIPLO-%s.log" }},
		INTEL = { level = Log4Lua.INFO, 	files = { "AIIP-%s.log", "INTEL-%s.log" }},
		POLIT = { level = Log4Lua.INFO, 	files = { "AIIP-%s.log", "POLIT-%s.log" }},
		PROD  = { level = Log4Lua.INFO, 	files = { "AIIP-%s.log", "PROD-%s.log" }},
		-- Suggested DEVEL log category for a particular function you are working on
		DEVEL = { level = Log4Lua.DEBUG, 	files = { "DEVEL-%s.log" }}
	}

	Log4Lua.configureLoggers(logConf)

	-- Main log method.
	-- category is not mandatory. it may fallback too ROOT or use static context
	-- ministerCountryOrTag is a non mandatory information to be filtered
	--                      accepting either CCountryTag, CCountry or string
	function P.log(level, message, category)
		if category ~= nil then
			P.setLogCat(category)
		else
			P._lastLogCat = category
		end
		Log4Lua.getLogger(category):log(level, message)
	end

	function P.setLogCat(category)
		P._lastLogCat = category
	end

	-- Convinience shortcut methods
	function P.debug(message, category)
		P.log(Log4Lua.DEBUG, message, category)
	end

	function P.info(message, category)
		P.log(Log4Lua.INFO, message, category)
	end

	function P.warn(message, category)
		P.log(Log4Lua.WARN, message, category)
	end

	function P.error(message, category)
		P.log(Log4Lua.ERROR, message, category)
	end

	function P.fatal(message, category)
		P.log(Log4Lua.FATAL, message, category)
	end
else
	--If logging disabled, then create stub functions
	function P.log() end
	function P.setLogCat() end
	function P.debug() end
	function P.info() end
	function P.warn() end
	function P.error() end
	function P.fatal() end
end

-- Deprecated
-- since we use log4lua
function P.LUA_DEBUGOUT(s)
	P.debug(s)
end

-----------------------------------------------------------------------------
-- calls specified function in country specific AI module if it exists
--
-- tag: country tag to load library for
-- funName: name of function to call if exists
-- currentScore - current score, returned if no module found
-- rest of args are passed to resolved funName and currentScore appended.
-----------------------------------------------------------------------------
function P.CallScoredCountryAI(tag, funName, currentScore, ...)
	local funRef = P.HasCountryAIFunction(tag, funName)
	if funRef then
		return funRef(currentScore, ...)
	end
	return currentScore
end

function P.CallCountryAI(tag, funName, ...)
	local funRef = P.HasCountryAIFunction(tag, funName)
	if funRef then
		return funRef(...)
	end
end

-- returns function ref if one exists, otherwise null
function P.HasCountryAIFunction(tag, funName)
	local countryModule = _G['AI_' .. tostring(tag)]
	if countryModule then
		local funRef = countryModule[funName]
		return funRef
	end
	return nil
end

-- returns list of files in a directory matching pattern
function P.ScanDir(dirname, pattern )
	local callit = os.tmpname()
	os.execute("dir /A-D /B "..dirname .. " >"..callit)
	local f = io.open(callit,"r")
	local rv = f:read("*all")
	f:close()
	os.remove(callit)

	tabby = {}
	local from  = 1
	local delim_from, delim_to = string.find( rv, "\n", from  )
	while delim_from do
		local subs = string.sub( rv, from , delim_from-1 )
		if string.match(subs, pattern) then
			table.insert( tabby, subs )
		end
		from  = delim_to + 1
		delim_from, delim_to = string.find( rv, "\n", from  )
	end
	return tabby
end

-- addition
function P.CallScoredCustomAI(funName, currentScore, ...)
 	local funRef = P.HasCustomAIFunction(funName)
	if funRef then
		return funRef(currentScore, ...)
	end
	return currentScore

end

function P.HasCustomAIFunction(funName)
	local customModule = _G['Custom_AI']
	if customModule then
		local funRef = customModule[funName]
		return funRef
	end
	return nil
end

return Utils
