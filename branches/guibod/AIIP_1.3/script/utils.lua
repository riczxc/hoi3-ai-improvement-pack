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
-- > Utils.info("Rejected trade from POR")
-- Or explicitely reset it
-- > Utils.setLogContext("GER", "DIPLO")
-- > Utils.info("Non-Agression pact signed with ITA.")
-- > Utils.info("Rejected trade from POR")
--
-- AIIP minister tick functions define the current Log Context
--
-- * Utils.debug(message [, ministerCountryOrTag][, category])
-- * Utils.info (message [, ministerCountryOrTag][, category])
-- * Utils.warn (message [, ministerCountryOrTag][, category])
-- * Utils.error(message [, ministerCountryOrTag][, category])
-- * Utils.fatal(message [, ministerCountryOrTag][, category])
-----------------------------------------------------------------------------
-- provide an easy way to disable logging (release)
if true then
	local Log4Lua = require('log4lua.logger')

	-- a static filter for logging
	--
	-- local filterTag = {"GER","USA"}
	-- Will only display Germany and USA minister logs. This feature affect all categories !
	-- Add nil to the table to enable log entry attached to no particular country

	local filterTag = {}

	-- @see http://www.hscale.org/display/LUA/Log4LUA
	local logConf = {
	--	CATEG = { level = Log4Lua.CONST,	files = { ... } [, pattern = "log4lua format pattern"][, datepattern = "log rotation date pattern"] },
		ROOT  = { level = Log4Lua.WARN,		files = { "AIIP-%s.log" }},
		DIPLO = { level = Log4Lua.WARN, 	files = { "AIIP-%s.log", "DIPLO-%s.log" }},
		INTEL = { level = Log4Lua.WARN, 	files = { "AIIP-%s.log", "INTEL-%s.log" }},
		POLIT = { level = Log4Lua.WARN, 	files = { "AIIP-%s.log", "POLIT-%s.log" }},
		PROD  = { level = Log4Lua.WARN, 	files = { "AIIP-%s.log", "PROD-%s.log" }},
		-- Suggested DEVEL log category for a particular function you are working on
		DEVEL = { level = Log4Lua.DEBUG, 	files = { "DEVEL-%s.log" }}
	}

	Log4Lua.configureLoggers(logConf)

	-- Main log method.
	-- category is not mandatory. it may fallback too ROOT or use static context
	-- ministerCountryOrTag is a non mandatory information may be filtered
	--                      accepting either CCountryTag, CCountry or string
	function P.log(level, message, ministerCountryOrTag, category)

		if category ~= nil then
			P._lastLogCategory = category
		else
			category = P._lastLogCategory
		end

		if ministerCountryOrTag ~= nil then
			P._lastLogCountry = ministerCountryOrTag
		else
			ministerCountryOrTag = P._lastLogCountry
		end

		--Test ministerCountryOrTag around a bit to determine either
		countryString = nil
		if type(ministerCountryOrTag) == "string" then
			--Use string as is
			countryString = ministerCountryOrTag
		elseif type(ministerCountryOrTag) == "userdata" and type(ministerCountryOrTag.GetCountryTag) == "function" then
			--Most likely CCountry or any CAIAgent class
			countryString = tostring(ministerCountryOrTag:GetCountryTag())
		elseif type(ministerCountryOrTag) == "userdata" and type(ministerCountryOrTag.GetTag) == "function" then
			--Most likely CCountryTag
			countryString = tostring(ministerCountryOrTag)
		else
			--No country set a 3 blank character string
			countryString = "   "
		end

		-- Country filter routine
		if type(filterTag) == "table" and #filterTag > 0 then
			local in_array = false


			for _,v in pairs(filterTag) do
				if (v==countryString) then in_array = true end
			end

			if not in_array then
				--string was filtered out
				return
			end
		end


		Log4Lua.getLogger(category):log(level, countryString.." "..message)
	end

	function P.setLogContext(ministerCountryOrTag, category)
		P._lastLogCategory = category
		P._lastLogCountry = ministerCountryOrTag
	end

	-- Convinience shortcut methods
	function P.debug(message, ministerCountryOrTag, category)
		P.log(Log4Lua.DEBUG, message, ministerCountryOrTag, category)
	end

	function P.info(message, ministerCountryOrTag, category)
		P.log(Log4Lua.INFO, message, ministerCountryOrTag, category)
	end

	function P.warn(message, ministerCountryOrTag, category)
		P.log(Log4Lua.WARN, message, ministerCountryOrTag, category)
	end

	function P.error(message, ministerCountryOrTag, category)
		P.log(Log4Lua.ERROR, message, ministerCountryOrTag, category)
	end

	function P.fatal(message, ministerCountryOrTag, category)
		P.log(Log4Lua.FATAL, message, ministerCountryOrTag, category)
	end
else
	--If logging disabled, then create stub functions
	function P.log() end
	function P.setLogContext() end
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

-- Wrappr function that file both a simple file and the log manager
--
-- Usefull to trap an error before to PI fallback to a standard code
function P.wrap(f, ...)
	local retOK, ret = pcall(f, ...)
	if retOK == false then
		--Write the error to a file
		local f = io.open(os.date("%Y%m%d%H%M%S").."-fatal.log", "w")
		f:write( ret .. "' \n")
		f:write( debug.traceback() .. "' \n")
		f:close()

		--attempt to call log
		pcall(Log4Lua.getLogger("ROOT").fatal, ret )

		--Throw the error as it should and let PI manage our error
		error(ret)
	end
	return ret
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
