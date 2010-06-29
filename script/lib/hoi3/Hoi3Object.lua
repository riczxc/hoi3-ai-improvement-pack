require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = middleclass.class('hoi3.Hoi3Object')

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

Hoi3Object.clearResult = function(self)
	 Hoi3Object.resultTable[self] = nil
end

---
-- Save a value for a object instance (or object definition for static method),
-- method, and parameters.
Hoi3Object.saveResult = function(self, value, method, ...)
	assert(middleclass.instanceOf(hoi3.Hoi3Object, self)or
		middleclass.subclassOf(hoi3.Hoi3Object, self), "Unable to recover value. Unknown object or class.")
	assert(middleclass.instanceOf(hoi3.FunctionObject, method), "Unable to recover value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...)
	if Hoi3Object.resultTable[self] == nil then
		Hoi3Object.resultTable[self] = {}
	end
	if Hoi3Object.resultTable[self][method] == nil then
		Hoi3Object.resultTable[self][method] = {}
	end
	
	--dtools.debug("Result cached for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(value))
	Hoi3Object.resultTable[self][method][hash] = value
end

-- Intends to be used in a HOI3 (needs to renamed fake LUA object to something else tough)
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "FRA")
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "ENG")
-- FakeCAI:serialize()
function Hoi3Object:runAndSaveResult(method, value, ...)
	Hoi3Object.saveResult(self, method(...), method, ...)
end

---
-- Test cached result existance for object instance, method and parameter
-- @return bool
function Hoi3Object:hasResult(method, ...)
	local hash = Hoi3Object.hashArgs(...)
	 
	return
		Hoi3Object.resultTable[self] ~= nil and
		Hoi3Object.resultTable[self][method] ~= nil and
		Hoi3Object.resultTable[self][method][hash] ~= nil
end

function Hoi3Object:loadResult(method, ...)
	assert(middleclass.instanceOf(hoi3.FunctionObject, method), "Unable to recover value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...) 	
	assert(Hoi3Object.resultTable[self] ~= nil, "Unable to recover value. Unknown object reference.")
	assert(Hoi3Object.resultTable[self][method] ~= nil, "Unable to recover value. Unknown function or method.")
	assert(Hoi3Object.resultTable[self][method][hash] ~= nil, "Unable to recover value. Unknown signature.")
	
	--dtools.debug("Result loaded for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(Hoi3Object.resultTable[self][method][hash]))
	return Hoi3Object.resultTable[self][method][hash]
end

--[[
	If a result is defined, get it
	or fallback to function name+"Impl"suffix
	or use return hint in order to provide a randomized value
	or throw a notimplemented error
]]
Hoi3Object.loadResultOrImplOrRandom  = function(self, fObj, ...)
	assert(
		middleclass.instanceOf(hoi3.FunctionObject, fObj),
		"Unable to recover value. Function name refers to a non function reference (hoi.FunctionObject)."
	)
	
	-- If cached result, return cached result...	
	if self:hasResult(fObj, ...) then
		return Hoi3Object.assertReturnTypeAndReturn(
			self:loadResult(fObj, ...),
			fObj.ret:__tostring()
		)
	end
	
	-- No real method result, we'll have to compute value
	-- (either by Impl method or randomized result)
	-- and to cheat it as real function result.
	local computedValue
	
	-- Try Impl method is exists ( real method this time, not a FunctionObject)
	if fObj:hasImpl() then
		if middleclass.instanceOf(hoi3.Hoi3Object,self) then
			computedValue = fObj:runImpl(self,...)
		else
			computedValue = fObj:runImpl(...)
		end
	else-- No Impl method result ?
		-- Create a randomized result (depending on expected return type)
		-- May throw a specific exception "no randomizer"
		computedValue = fObj.ret:compute(def)
	end
	
	if computedValue ~= nil then
		-- Now cache results as if it was the original function/method result
		local hash = Hoi3Object.hashArgs(...)
		if Hoi3Object.resultTable[self] == nil then
			Hoi3Object.resultTable[self] = {}
		end
		if Hoi3Object.resultTable[self][fObj] == nil then
			Hoi3Object.resultTable[self][fObj] = {}
		end
		Hoi3Object.resultTable[self][fObj][hash] = computedValue
		
		-- And return (with a test on returned value type)
		return Hoi3Object.assertReturnTypeAndReturn(
			Hoi3Object.resultTable[self][fObj][hash],
			fObj.ret:__tostring()
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

