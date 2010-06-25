require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = class('hoi3.Hoi3Object')

--[[
	Easy way to define constant result for the same call 
	signature on the same instance of the same object.
]]

function Hoi3Object.assertReturnTypeAndReturn(returnValue, typeAsString)
	hoi3.assertReturnType(returnValue, typeAsString)
	return returnValue
end

---
-- Transform parameters list to a string (hashable)
-- @param ...
-- @return string
-- @static
function Hoi3Object.hashArgs(...)
	local hash = ""
	local args = {...}
	
	for i,k in ipairs(args) do
		hash = hash .. " #" .. i .. "=" .. tostring(k)
	end
	
	return hash
end

-- @static
Hoi3Object.resultTable = {}

---
-- Save a value for a object instance (or object definition for static method),
-- method, and parameters.
Hoi3Object.saveResult = function(self, value, method, ...)
	assert(type(method)==hoi3.TYPE_FUNCTION, "Unable to save value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...)
	if Hoi3Object.resultTable[self] == nil then
		Hoi3Object.resultTable[self] = {}
	end
	if Hoi3Object.resultTable[self][method] == nil then
		Hoi3Object.resultTable[self][method] = {}
	end
	
	--dtools.debug("Result cached for "..tostring(self.class).."."..tostring(method).."("..hash..")")
	Hoi3Object.resultTable[self][method][hash] = value
end

-- Intends to be used in a HOI3 (needs to renamed fake LUA object to something else tough)
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "FRA")
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "ENG")
-- FakeCAI:serialize()
Hoi3Object.runAndSaveResult = function(self, method, value, ...)
	Hoi3Object.saveResult(self, method(...), method, ...)
end

---
-- Test cached result existance for object instance, method and parameter
-- @return bool
Hoi3Object.hasResult = function(self, method, ...)
	local hash = Hoi3Object.hashArgs(...) 	
	return
		Hoi3Object.resultTable[self] ~= nil and
		Hoi3Object.resultTable[self][method] ~= nil and
		Hoi3Object.resultTable[self][method][hash] ~= nil
end

Hoi3Object.loadResult = function(self, method, ...)
	assert(type(method)==hoi3.TYPE_FUNCTION, "Unable to recover value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...) 	
	assert(Hoi3Object.resultTable[self] ~= nil, "Unable to recover value. Unknown object reference.")
	assert(Hoi3Object.resultTable[self][method] ~= nil, "Unable to recover value. Unknown function or method.")
	assert(Hoi3Object.resultTable[self][method][hash] ~= nil, "Unable to recover value. Unknown signature.")
	
	return Hoi3Object.resultTable[self][method][hash]
end

--[[
	If a result is defined, get it
	or fallback to function name+"Impl"suffix
	or use return hint in order to provide a randomized value
	or throw a notimplemented error
]]
Hoi3Object.loadResultOrImplOrRandom  = function(self, expectedType, methodName, ...)
	-- expectedType can be either a string
	-- or a more complex Randomizer object instance
	if type(expectedType) == hoi3.TYPE_STRING then
		expectedType = hoi3.Randomizer:new(expectedType)
	end
	
	-- Real method
	local fReference = self[methodName]
	if fReference == nil or
		type(fReference) ~= hoi3.TYPE_FUNCTION then
		error("Unable to recover value. Function name refers to a non function reference.")
	end
	
	-- If cached result, return cached result...	
	if self:hasResult(fReference, ...) then
		return Hoi3Object.assertReturnTypeAndReturn(
			self:loadResult(fReference, ...),
			expectedType:__tostring()
		)
	end
	
	-- No real method result, we'll have to compute value
	-- (either by Impl method or randomized result)
	-- and to cheat it as real function result.
	local computedValue
	
	-- Try Impl method is exists
	local fImplReference = self[methodName.."Impl"]
	if fImplReference ~= nil  then
		assert(type(fImplReference) == hoi3.TYPE_FUNCTION, "Unable to recover value. Function name refers to a non-function reference.")
		computedValue = fImplReference(...)
	else-- No Impl method result ?
		-- Create a randomized result (depending on expected return type)
		-- May throw a specific exception "no randomizer"
		computedValue = expectedType:compute(def)
	end
	
	if computedValue ~= nil then
		-- Now cache results as if it was the original function/method result
		local hash = Hoi3Object.hashArgs(...)
		if Hoi3Object.resultTable[self] == nil then
			Hoi3Object.resultTable[self] = {}
		end
		if Hoi3Object.resultTable[self][fReference] == nil then
			Hoi3Object.resultTable[self][fReference] = {}
		end
		Hoi3Object.resultTable[self][fReference][hash] = computedValue
		
		-- And return (with a test on returned value type)
		return Hoi3Object.assertReturnTypeAndReturn(
			Hoi3Object.resultTable[self][fReference][hash],
			expectedType:__tostring()
		)
	else
		return nil
	end 
end

--- 
-- Find object index in a dictionnary
-- @param table dict
-- @return number (or nil if not in table)
function Hoi3Object.getIndexInDictionnary(dict)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, dict, hoi3.TYPE_TABLE)
	
	for i, v in dict do
		if v == self then
			return i
		end
	end
end

