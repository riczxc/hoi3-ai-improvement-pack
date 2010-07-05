require('middleclass')

module( "hoi3", package.seeall)

FunctionObject = middleclass.Object:subclass('hoi3.FunctionObject')

function f(class, name, ret, ...)
	return FunctionObject(class, name, false, ret, ...)
end

function fs(class, name, ret, ...)
	return FunctionObject(class, name, true, ret, ...)
end

function FunctionObject:initialize(class, name, static, ret, ...)
	assert(middleclass.subclassOf(hoi3.Object,class), "First parameter function must be a valid middleclass.Object.")
	assertParameterType(2, name, hoi3.TYPE_STRING)
	assertParameterType(3, static, hoi3.TYPE_BOOLEAN)
	
	self.myclass= class
	self.static = static
	self.name = name

	if type(ret) == hoi3.TYPE_STRING
		and ret ~= hoi3.TYPE_UNKNOWN then
		self.ret = hoi3.Randomizer:new(ret)
	else
		self.ret = ret
	end
	self.args = {...}
	self.result = {}
	
	-- self reference in parent object
	self.myclass[name] = self
end

function FunctionObject:__tostring()
	--TODO, more details (ret/params values)
	return self.myclass.name.."."..self.name.."()"
end

function FunctionObject:hasImpl()
	hoi3.assertNonStatic(self)
	if self.myclass ~= nil and
		self.myclass[self.name.."Impl"] ~= nil and
		type(self.myclass[self.name.."Impl"]) == hoi3.TYPE_FUNCTION then
		return true
	end
	return false
end

function FunctionObject:runImpl(...)
	hoi3.assertNonStatic(self)
	if self:hasImpl() then
		return self.myclass[self.name.."Impl"](...)
	end
end

-- This boolean static property serves to define
-- whereas we are running a nested API call or not
FunctionObject.isRunningApiCall = false
-- This static property is incremented each time
-- a non-nested api call is triggered.
FunctionObject.numApiCalls = 0

function FunctionObject:__call(instanceOrFirstParameter, ...)
	hoi3.assertNonStatic(self)
	
	if self.ret == hoi3.TYPE_UNKNOWN then
		hoi3.throwUnknownSignature()
	end
	
	local args = {...}
	local instanceOrClass
	local ret1, ret2, ret3
	local isNestedApiCall = false
	if FunctionObject.isRunningApiCall == true then
		isNestedApiCall = true
	else
		FunctionObject.isRunningApiCall = true
	end
	
	-- if this function is static, 1st parameter is
	-- not caller object self instance reference. 
	-- We put the 1st parameter in ... list 
	-- and use class reference as  loadResultOrImplOrRandom
	-- parameter.
	-- Long story short, parameter reordering.
	if self.static == true then
		args = {instanceOrFirstParameter, ...}
		instanceOrClass = self.myclass
	else
		hoi3.assertNonStatic(instanceOrFirstParameter)
		instanceOrClass = instanceOrFirstParameter
	end

	-- Assert real function call arguments
	for i, v in ipairs(self.args) do
		if args[i] == hoi3.TYPE_UNKNOWN then
			hoi3.throwUnknownSignature()
		end
		hoi3.assertParameterType(i, args[i], v)
	end
	
	ret1, ret2, ret3 = self:loadResultOrImplOrRandom(instanceOrClass, ...)
	
	if not(isNestedApiCall) then
		FunctionObject.isRunningApiCall = false
		FunctionObject.numApiCalls = FunctionObject.numApiCalls + 1 
	end
	
	return ret1, ret2, ret3
end



-- Save/Load support

---
-- @return void
function FunctionObject:clearResult()
	 hoi3.assertNonStatic(self)
	 
	 self.result = {}
end

---
-- Transform parameters list to a string (hashable)
-- @param ...
-- @return string
-- @static
function FunctionObject.hashArgs(...)
	local hash = ""
	local args = {...}
	
	for i,k in ipairs(args) do
		hash = hash .. " #" .. i .. "=" .. tostring(k)
	end
	
	return hash
end


---
-- @param MiddleClass class or instance
-- @return string
function FunctionObject.getInstanceOrClassDescriptor(instanceOrClass)
	local isInstance = middleclass.instanceOf(hoi3.Hoi3Object, instanceOrClass)
	local isSubclass = middleclass.subclassOf(hoi3.Hoi3Object, instanceOrClass)
	assert(isInstance or isSubclass, "Unknown object or class.")
	
	return instanceOrClass
end

---
-- Save a value for a object instance (or object definition for static method),
-- method, and parameters.
function FunctionObject:save(instanceOrClass, value, ...)
	hoi3.assertNonStatic(self)
	
	local c = FunctionObject.getInstanceOrClassDescriptor(instanceOrClass)
	local h = FunctionObject.hashArgs(...)
	
	-- No nil, force tables
	self.result = self.result or {}
	self.result[c] = self.result[c] or {}
		
	--dtools.debug("Result cached for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(value))
	self.result[c][h] = value
end

-- Intends to be used in a HOI3 (needs to renamed fake LUA object to something else tough)
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "FRA")
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "ENG")
-- FakeCAI:serialize()
function FunctionObject:runAndSave(instanceOrClass, ...)
	self:saveResult(instanceOrClass, self(...), ...)
end

---
-- Test cached result existance for object instance, method and parameter
-- @return bool
function FunctionObject:hasResult(instanceOrClass, ...)
	hoi3.assertNonStatic(self)
	
	local c = FunctionObject.getInstanceOrClassDescriptor(instanceOrClass)
	local h = FunctionObject.hashArgs(...)
	 
	return
		self.result[c] ~= nil and
		self.result[c][h] ~= nil
end

function FunctionObject:load(instanceOrClass, ...)
	hoi3.assertNonStatic(self)
	
	local c = FunctionObject.getInstanceOrClassDescriptor(instanceOrClass)
	local h = FunctionObject.hashArgs(...)
	
	assert(self.result[c] ~= nil, "Unable to recover value. Unknown object reference.")
	assert(self.result[c][h] ~= nil, "Unable to recover value. Unknown signature.")
	
	--dtools.debug("Result loaded for "..tostring(self).."."..tostring(method).."("..hash..") = "..tostring(Hoi3Object.resultTable[self][method][hash]))
	return self.result[c][h]
end

--[[
	If a result is defined, get it
	or fallback to function name+"Impl"suffix
	or use return hint in order to provide a randomized value
	or throw a notimplemented error
]]
function FunctionObject:loadResultOrImplOrRandom(instanceOrClass, ...)
	local c = FunctionObject.getInstanceOrClassDescriptor(instanceOrClass)
	
	-- If cached result, return cached result...	
	if self:hasResult(instanceOrClass, ...) then
		return Hoi3Object.assertReturnTypeAndReturn(
			self:load(c, ...),
			self.ret:__tostring()
		)
	end
	
	-- No cached method result, we'll have to compute value
	-- (either by Impl method or randomized result)
	-- and to cheat it as real function result.
	local computedValue
	
	-- Try Impl method is exists ( real method this time, not a FunctionObject)
	if self:hasImpl() then
		if self.static then 
			computedValue = self:runImpl(...)
		else
			computedValue = self:runImpl(c,...)
		end
	else
		-- No Impl method result ?
		-- Create a randomized result (depending on expected return type)
		-- May throw a specific exception "no randomizer"
		computedValue = self.ret:compute(def)
	end
	
	if computedValue ~= nil then
		-- Now cache results as if it was the original function/method result
		self:save(c, computedValue, ...)
		
		-- And return (with a test on returned value type)
		return Hoi3Object.assertReturnTypeAndReturn(
			computedValue,
			self.ret:__tostring()
		)
	else
		return nil
	end 
end