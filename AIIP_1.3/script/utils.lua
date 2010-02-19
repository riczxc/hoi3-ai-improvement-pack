-- Enable dtools extension
require('devtools')

---------------------------------
-- Utils
-- general utility functions
---------------------------------

local P = {}
Utils = P

-- Deprecated
-- since we use log4lua
function P.LUA_DEBUGOUT(s)
	dtools.debug(s)
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
