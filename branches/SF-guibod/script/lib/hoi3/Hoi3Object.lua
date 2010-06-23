require('middleclass')

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
	or fallback to function name+"Fake"suffix
	or use return hint in order to provide a randomized value
	or throw a notimplemented error
]]
Hoi3Object.loadResultOrFakeOrRandom  = function(self, returnTypeAsString, methodName, ...)
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
			returnTypeAsString
		)
	end
	
	-- No real method result, we'll have to compute value
	-- (either by fake method or randomized result)
	-- and to cheat it as real function result.
	local computedValue
	
	-- Try fake method is exists
	local fFakeReference = self[methodName.."Fake"]
	if fFakeReference ~= nil  then
		assert(type(fFakeReference) == hoi3.TYPE_FUNCTION, "Unable to recover value. Function name refers to a non function reference.")
		
		computedValue = fFakeReference(...)
	end
	
	-- No fake method result ?
	-- Create a randomized result (depending on expected return type)
	if computedValue == nil then
		-- May throw a specific exception "no randomizer"
		computedValue = Hoi3Object.computeRandomizedValue(returnTypeAsString)
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
			returnTypeAsString
		)
	end
	
	Hoi3Object.throwNoYetImplemented()	
end

---
-- Compute random value for a given type
-- this method returns "nil" instead of throwing exception
Hoi3Object.computeRandomizedValue = function(returnTypeAsString)
	--TODO: support random hint, such as table size, % true/false, random(min/max)...
	math.randomseed( os.time() )
	
	if returnTypeAsString == hoi3.TYPE_FUNCTION or
		returnTypeAsString == hoi3.TYPE_THREAD or
		returnTypeAsString == hoi3.TYPE_USERDATA then
		-- Throw an error, we don't handle such special datatypes !
		error("Failed to randomize special datatype. function, thread and userdata type are not handled")   
	elseif returnTypeAsString == hoi3.TYPE_NIL then
		return nil
	elseif returnTypeAsString == hoi3.TYPE_STRING then
		-- return a human readable string of 10 caracters
		local conso = {"b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","y","z","_"}
		local vocal = {"a","e","i","o","u"}
		local value = ""
		local length = 10
			
		for i = 0, length, 2 do
			value = value .. conso[ math.random(#conso)]
			value = value .. vocal[ math.random(#vocal)]
		end
		
		return value		
	elseif returnTypeAsString == hoi3.TYPE_NUMBER then
		return math.random(0,100)
	elseif returnTypeAsString == hoi3.TYPE_BOOLEAN then
		if math.random(2) == 1 then 
			return true 
		else 
			return false 
		end
	elseif returnTypeAsString:sub(0,6) == hoi3.TYPE_TABLE.."<" then
		local myType = returnTypeAsString:sub(0,-2):sub(7)
		local myTable = {}
		local myValue
		for i = 0, math.random(10) do
			myValue = Hoi3Object.computeRandomizedValue(myType)
			print(myValue)
			table.insert(myTable,Hoi3Object.computeRandomizedValue(myType))
		end
		return myTable
	else
		-- try to delegate to object reference
		if _G[returnTypeAsString] and _G[returnTypeAsString].random
			and type(_G[returnTypeAsString].random) == hoi3.TYPE_FUNCTION then
			return _G[returnTypeAsString].random()
		end
	end
	
	hoi3.throwNoRandomizerSupport(returnTypeAsString)
end
