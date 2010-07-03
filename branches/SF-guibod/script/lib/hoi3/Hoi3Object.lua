require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = middleclass.class('hoi3.Hoi3Object')

Hoi3Object.resultTable = {}

function Hoi3Object.assertReturnTypeAndReturn(returnValue, typeAsString)
	-- special case, transform a table (table) into iterator (func, table)
	-- this is a workaround in order to avoid support for multiple result
	-- caching as well as caching function references...
	-- An HOI3 iterator is not an array (ipairs) or dictionnary (pairs) but a true list (next)
	if hoi3.Randomizer.isIteratorTypeString(typeAsString) then
		hoi3.assertReturnType(returnValue, hoi3.TYPE_TABLE.."<"..hoi3.Randomizer.getIteratorTypeFromString(typeAsString)..">")
		return next, returnValue, nil
	else
		hoi3.assertReturnType(returnValue, typeAsString)
		return returnValue
	end
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

Hoi3Object.clearResult = function(self)
	 Hoi3Object.resultTable[self] = nil
end

---
-- @param MiddleClass class or instance
-- @return string
function Hoi3Object.getInstanceOrClassDescriptor(instanceOrClass)
	local isInstance = middleclass.instanceOf(hoi3.Hoi3Object, instanceOrClass)
	local isSubclass = middleclass.subclassOf(hoi3.Hoi3Object, instanceOrClass)
	
	assert(isInstance or isSubclass, "Unknown object or class.")
	
	return instanceOrClass
end

---
-- @param FunctionObject
-- @return string
function Hoi3Object.getMethodDescriptor(method)
	assert(middleclass.instanceOf(hoi3.FunctionObject, method), "Unable to recover value. Unknown function or method.")
	return method
end

---
-- Save a value for a object instance (or object definition for static method),
-- method, and parameters.
Hoi3Object.saveResult = function(instanceOrClass, value, method, ...)
	local c = Hoi3Object.getInstanceOrClassDescriptor(instanceOrClass)
	local m = Hoi3Object.getMethodDescriptor(method)
	local hash = Hoi3Object.hashArgs(...)
	
	-- No nil, force tables
	Hoi3Object.resultTable[c] = Hoi3Object.resultTable[c] or {}
	Hoi3Object.resultTable[c][m] = Hoi3Object.resultTable[c][m] or {}
		
	--dtools.debug("Result cached for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(value))
	Hoi3Object.resultTable[c][m][hash] = value
end

-- Intends to be used in a HOI3 (needs to renamed fake LUA object to something else tough)
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "FRA")
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "ENG")
-- FakeCAI:serialize()
Hoi3Object.runAndSaveResult = function (instanceOrClass, method, value, ...)
	Hoi3Object.saveResult(instanceOrClass, method(...), method, ...)
end

---
-- Test cached result existance for object instance, method and parameter
-- @return bool
Hoi3Object.hasResult = function(instanceOrClass, method, ...)
	local c = Hoi3Object.getInstanceOrClassDescriptor(instanceOrClass)
	local m = Hoi3Object.getMethodDescriptor(method)
	local hash = Hoi3Object.hashArgs(...)
	 
	return
		Hoi3Object.resultTable[c] ~= nil and
		Hoi3Object.resultTable[c][m] ~= nil and
		Hoi3Object.resultTable[c][m][hash] ~= nil
end

Hoi3Object.loadResult = function(instanceOrClass, method, ...)
	local c = Hoi3Object.getInstanceOrClassDescriptor(instanceOrClass)
	local m = Hoi3Object.getMethodDescriptor(method)
	local hash = Hoi3Object.hashArgs(...)
	
	assert(Hoi3Object.resultTable[c] ~= nil, "Unable to recover value. Unknown object reference.")
	assert(Hoi3Object.resultTable[c][m] ~= nil, "Unable to recover value. Unknown function or method.")
	assert(Hoi3Object.resultTable[c][m][hash] ~= nil, "Unable to recover value. Unknown signature.")
	
	--dtools.debug("Result loaded for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(Hoi3Object.resultTable[self][method][hash]))
	return Hoi3Object.resultTable[c][m][hash]
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
	
	-- No cached method result, we'll have to compute value
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
		self:saveResult(computedValue, fObj, ...)
		
		-- And return (with a test on returned value type)
		return Hoi3Object.assertReturnTypeAndReturn(
			computedValue,
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
function Hoi3Object:getIndexInDictionnary(dict)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, dict, hoi3.TYPE_TABLE)
	
	local i = 1
	for k, v in pairs(dict) do
		if v == self then
			return i
		end
		i = i + 1
	end
end