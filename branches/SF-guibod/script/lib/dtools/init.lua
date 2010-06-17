--[[
    Copyright (C) 2010 Guillaume Boddaert

	Permission is hereby granted, free of charge, to any person
	obtaining a copy of this software and associated documentation
	files (the "Software"), to deal in the Software without
	restriction, including without limitation the rights to use,
	copy, modify, merge, publish, distribute, sublicense, and/or
	sell copies of the Software, and to permit persons to whom the
	Software is furnished to do so, subject to the following
	conditions:

	The above copyright notice and this permission notice shall be
	included in all copies or substantial portions of the Software.

	THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
	EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
	OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
	NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
	HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
	WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
	FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE
	OR OTHER DEALINGS IN THE SOFTWARE.
--]]

--- HOI3 dtools package<br>
--
--
-- @author Guibod <guibod@users.sf.net>
-- @release $Date$ $Rev$

module("dtools", package.seeall)

-- Class definition
local devtools = {}
devtools.__index = devtools
devtools.enabled = true

local _module = devtools

-- initial set of stub methods (if devtools are disabled)
function _module.loadConfig() end
function _module.log() end
function _module.setLogContext() end
function _module.debug() end
function _module.info() end
function _module.warn() end
function _module.error() end
function _module.fatal() end
function _module.harvest() end

-- Wrapper function that file both a simple file and the log manager
--
-- Usefull to trap an error before to PI fallback to a standard code
function _module.wrap(f, ...)
	if devtools.enabled then
		local retOK, ret = pcall(f, ...)
		if retOK == false then
			--Write the error to a file
			local f = io.open(os.date("logs/%Y%m%d-fatal.log"), "a")
			f:write( ret .. "' \n")
			f:write( debug.traceback() .. "' \n\n")
			f:close()

			--attempt to call log
			pcall(_module.fatal, ret )

			--Throw the error as it should and let PI manage our error
			error(ret)
		end
		return ret
	else
		return f(...)
	end
end

-- Renames a function with "DtoolsWrapped" prefix
-- Creates a new function named as previous one
-- that relies uses dtools.wrap() on renamed function
function _module.wrapFunction(strFname, strLogGroup )
	if devtools.enabled then
		local f = _G[strFname]
		if f ~= nil and type(f) == "function" then
			if strLogGroup == nil then
				strLogGroup = "ROOT"
			end
		
			--copy function
			_G["DtoolsWrapped"..strFname] = f
			
			--change function source
			f = function(...)
				-- we attempt to use 1st parameter as
				-- an object supporting getTag() or getCountryTag()
				-- If not, we really don't care.
				dtools.setLogContext(select(1, ...),strLogGroup)
				_G[strFname] = dtools.wrap(_G["DtoolsWrapped"..strFname], ...) 
			end
		end
	end
end

-- devtools log functions can be easily disabled without commenting out all calls
--
-- To disable all log functionalities, please replace "if true then" by "if false then"
--
-- if false then
if devtools.enabled then
	_module.Log4Lua = require('log4lua.logger')

	_module._lastLogCategory = nil
	_module._lastLogCountry = nil

	-- Log specific content
	--
	-- A simple log framework based on Log4Lua.
	-- Log are categorized by minister : diplo, intel, politics and production
	-- Another fallback/main category is available for other stuff (ROOT)
	--
	-- Basic usage :
	-- > Utils.info("Non-Agression pact signed with ITA.", "GER", "DIPLO")
	--
	-- Log system is able to remember log context
	-- > Utils.setLogContext("GER", "DIPLO")
	-- > Utils.info("Non-Agression pact signed with ITA.")
	-- > Utils.info("Rejected trade from POR")
	-- > Utils.setLogContext(nil, nil)
	-- > Utils.info("No context for this one")
	--
	-- AIIP minister tick functions define the current Log Context
	--
	-- * Utils.debug(message [, ministerCountryOrTag][, category])
	-- * Utils.info (message [, ministerCountryOrTag][, category])
	-- * Utils.warn (message [, ministerCountryOrTag][, category])
	-- * Utils.error(message [, ministerCountryOrTag][, category])
	-- * Utils.fatal(message [, ministerCountryOrTag][, category])

	-- a static filter for logging system
	-- (from semicolon separated value from environnement variable HOI3_DEVTOOLS_FILTERTAG)
	--
	-- Will only display Germany and USA minister logs. This feature affect all categories !
	-- Add nil to the table to enable log entry attached to no particular country

	local filterTag = {}
	if os.getenv("HOI3_DEVTOOLS_FILTERTAG") then
		filterTag = os.getenv("HOI3_DEVTOOLS_FILTERTAG").split(";")

		_module.Log4Lua.getLogger():log(_module.Log4Lua.INFO, "Filtering out tags (from env HOI3_DEVTOOLS_FILTERTAG)")
		_module.Log4Lua.getLogger():log(_module.Log4Lua.INFO, filterTag)
	end

	function _module.loadConfig(file)
		_module.Log4Lua.loadConfig(file)
	end

	-- Main log method.
	-- category is not mandatory. it may fallback too ROOT or use static context
	-- ministerCountryOrTag is a non mandatory information may be filtered
	--                      accepting either CCountryTag, CCountry or string
	function _module.log(level, message, ministerCountryOrTag, category)
		message = message or ""
		category = category or _module._curLogCategory
		ministerCountryOrTag = ministerCountryOrTag or _module._curLogCountry

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


		_module.Log4Lua.getLogger(category):log(level, message, nil, countryString)
	end

	function _module.setLogContext(ministerCountryOrTag, category)
		_module._curLogCategory = category
		_module._curLogCountry = ministerCountryOrTag
	end

	-- Convinience shortcut methods
	function _module.debug(message, ministerCountryOrTag, category)
		_module.log(_module.Log4Lua.DEBUG, message, ministerCountryOrTag, category)
	end

	function _module.info(message, ministerCountryOrTag, category)
		_module.log(_module.Log4Lua.INFO, message, ministerCountryOrTag, category)
	end

	function _module.warn(message, ministerCountryOrTag, category)
		_module.log(_module.Log4Lua.WARN, message, ministerCountryOrTag, category)
	end

	function _module.error(message, ministerCountryOrTag, category)
		_module.log(_module.Log4Lua.ERROR, message, ministerCountryOrTag, category)
	end

	function _module.fatal(message, ministerCountryOrTag, category)
		_module.log(_module.Log4Lua.FATAL, message, ministerCountryOrTag, category)
	end
end

-- Helper functions

-- Extend string class to support Python like split
string.split = function (sSeparator, nMax, bRegexp)
	assert(sSeparator ~= '')
	assert(nMax == nil or nMax >= 1)

	local aRecord = {}

	if self:len() > 0 then
		local bPlain = not bRegexp
		nMax = nMax or -1

		local nField=1 nStart=1
		local nFirst,nLast = self:find(sSeparator, nStart, bPlain)
		while nFirst and nMax ~= 0 do
			aRecord[nField] = self:sub(nStart, nFirst-1)
			nField = nField+1
			nStart = nLast+1
			nFirst,nLast = self:find(sSeparator, nStart, bPlain)
			nMax = nMax-1
		end
		aRecord[nField] = self:sub(nStart)
	end

	return aRecord
end
-- End of log functions

-- devtools harvest functions can be easily disabled without commenting out all calls
--
-- To disable all harvest functionalities, please replace "if true then" by "if false then"
--
-- if false then
if false then
	function _module.harvest(t, data, commit)
		local Harvester = require("dtools.harvester")
		Harvester.harvest(t, data, commit)
	end
end

-- Extend table class to support has_value
-- A function which shows compareable behaviour to php's in_array.
function _module.in_table ( e, t )
 	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

-- Replace HOI3 limited log functions
if Utils and Utils.LUA_DEBUGOUT ~= nil then
	Utils.LUA_DEBUGOUT = function (s)
		local dtools = require('dtools')
		dtools.debug(s)
	end
end

return _module
