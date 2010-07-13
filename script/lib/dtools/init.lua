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

local enabled = true

-- initial set of stub methods (if devtools are disabled)
function loadConfig() end
function log() end
function setLogContext() end
function debug() end
function info() end
function warn() end
function error() end
function fatal() end
function harvest() end

-- Wrapper function that file both a simple file and the log manager
--
-- Usefull to trap an error before to PI fallback to a standard code
function wrap(f, ...)
	if enabled then
		local retOK, ret = pcall(f, ...)
		if retOK == false then
			--Write the error to a file
			local f = io.open(os.date("logs/%Y%m%d-fatal.log"), "a")
			f:write( "Error triggered while calling "..tostring(f).."\n")
			f:write( ret .. "\n")
			f:write( _G['debug'].traceback() .. "\n\n")
			f:close()

			--attempt to call log
			pcall(fatal, ret )

			--Throw the error as it should and let PI manage our error
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
function wrapFunction(strFname, strLogGroup )
	if enabled then
		if _G[strFname] ~= nil and type(_G[strFname]) == "function" then
			if strLogGroup == nil then
				strLogGroup = "ROOT"
			end

			--copy function
			_G["DtoolsWrapped"..strFname], _G[strFname] = _G[strFname], function(...)
				require('dtools')
				-- we attempt to use 1st parameter as
				-- an object supporting getTag() or getCountryTag()
				-- If not, we really don't care.
				dtools.setLogContext(select(1, ...),strLogGroup)
				dtools.wrap(_G["DtoolsWrapped"..strFname], ...) 
			end
			
			if _G["DtoolsWrapped"..strFname] == nil or
				_G[strFname] == nil or 
				type(_G["DtoolsWrapped"..strFname]) ~= "function" or
				type(_G[strFname]) == nil then
				dtools.error("Function "..strFname.." failed to be wrapped to DtoolsWrapped"..strFname)
			end
			
			dtools.info("Function "..strFname.." ("..tostring(_G[strFname])..") wrapped to DtoolsWrapped"..strFname.." ("..tostring(_G["DtoolsWrapped"..strFname])..")")
		else
			dtools.error("Function "..strFname.." failed to be wrapped to DtoolsWrapped"..strFname)
		end
	end
end

-- devtools log functions can be easily disabled without commenting out all calls
--
-- To disable all log functionalities, please replace "if true then" by "if false then"
--
-- if false then
if enabled then
	_lastLogCategory = nil
	_lastLogCountry = nil

	-- Main log method.
	-- category is not mandatory. it may fallback too ROOT or use static context
	-- ministerCountryOrTag is a non mandatory information may be filtered
	--                      accepting either CCountryTag, CCountry or string
	function log(level, message, ministerCountryOrTag, category)
		message = message or ""
		category = category or _curLogCategory
		ministerCountryOrTag = ministerCountryOrTag or _curLogCountry

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
			--No country set a 3 blank character string
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
		
		require('dtools.log4lua')
		dtools.log4lua.getLogger(category):log(level, message, nil, countryString)
	end

	function loadConfig(file)
		require('dtools.log4lua')
		dtools.log4lua.loadConfig(file)
	end
	
	function setLogContext(ministerCountryOrTag, category)
		_curLogCategory = category
		_curLogCountry = ministerCountryOrTag
	end

	-- Convinience shortcut methods
	function debug(message, ministerCountryOrTag, category)
		log('DEBUG', message, ministerCountryOrTag, category)
	end

	function info(message, ministerCountryOrTag, category)
		log('INFO', message, ministerCountryOrTag, category)
	end

	function warn(message, ministerCountryOrTag, category)
		log('WARN', message, ministerCountryOrTag, category)
	end

	function error(message, ministerCountryOrTag, category)
		log('ERROR', message, ministerCountryOrTag, category)
	end

	function fatal(message, ministerCountryOrTag, category)
		log('FATAL', message, ministerCountryOrTag, category)
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
	function harvest(t, data, commit)
		local Harvester = require("dtools.harvester")
		Harvester.harvest(t, data, commit)
	end
end

-- Extend table class to support has_value
-- A function which shows compareable behaviour to php's in_array.
function in_table ( e, t )
 	for _,v in pairs(t) do
		if (v==e) then return true end
	end
	return false
end

-- Replace HOI3 limited log functions
if _G['Utils'] and _G['Utils'].LUA_DEBUGOUT ~= nil then
	_G['Utils'].LUA_DEBUGOUT = function (s)
		require('dtools')
		dtools.debug(s)
	end
end
