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
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,class), "First parameter function must be a valid hoi3.Hoi3Object.")
	assertParameterType(2, name, hoi3.TYPE_STRING)
	assertParameterType(3, static, hoi3.TYPE_BOOLEAN)
	--hoi3.assert(ret, "No return value set for "..tostring(class).."."..name.."()")
	
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
	self.runs = 0
	self.druns = {}
	
	self.realruns = 0
	self.realtime = 0
	
	if self.ret == hoi3.TYPE_UNKNOWN or
		self.ret == hoi3.TYPE_VOID or
		(self.ret ~= nil and self.ret.type ~= nil and self.ret.type == hoi3.TYPE_VOID) then
		self.doSave = false
	else
		self.doSave = true
	end
		
	-- informations
	self.contructorSignature = nil
	
	-- self reference in parent object
	self.myclass[name] = self
end

function FunctionObject:reset()
	self.runs = 0
	self.druns = {}
end

function FunctionObject:__tostring()
	return self:returnTypeAsString().." "..self.myclass.name.."."..self:signatureAsString() 
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

function FunctionObject:returnTypeAsString(bWiki)
	local bWiki = bWiki or false
	local str = ""
	if self.static then
		str = str .. "static "
	end
	
	if self.ret ~= nil and self.ret.getStringDescriptor ~= nil then
		str = str .. self.ret:getStringDescriptor(bWiki)
	else
		str = str .. tostring(self.ret)
	end
	return str
end

function FunctionObject:signatureAsString(bWiki)
	local bWiki = bWiki or false
	local str
	if bWiki then
		str = "`"..self.name.."`("
	else
		str = self.name.."("
	end
	for i,v in ipairs(self.args) do
		if bWiki and hoi3.api[tostring(v)] ~= nil and hoi3.api[tostring(v)].__classDict ~= nil then
			v = "[#".. tostring(v).." " .. tostring(v).."]"
		end
		str = str .. tostring(v)
		
		if i ~= #self.args then
			str = str .. ", "
		end
	end
	str = str .. ")"
	
	return str
end

function FunctionObject:canRun()
	if self.ret == hoi3.TYPE_UNKNOWN then 
		return false
	end
	
	for i,v in ipairs(self.args) do
		if v == hoi3.TYPE_UNKNOWN then
			return false
		end
	end
	return true
end

function FunctionObject:canSave()
	if not self.doSave then 
		return false
	end
	
	return self:canRun()
end

-- This boolean static property serves to define
-- whereas we are running a nested API call or not
FunctionObject.isRunningApiCall = false
-- This static property is incremented each time
-- a non-nested api call is triggered.
FunctionObject.numApiCalls = 0

function FunctionObject:_checkArgs(instanceOrFirstParameter, ...)
	hoi3.assertNonStatic(self)
	
	-- if this function is static, 1st parameter is
	-- not caller object self instance reference. 
	-- We put the 1st parameter in ... list 
	-- and use class reference as  loadResultOrImplOrRandom
	-- parameter.
	-- Long story short, parameter reordering.
	
	local args = {...}
	if self.static == true then
		args = {instanceOrFirstParameter, ...}
		instanceOrClass = self.myclass
	else
		if not middleclass.instanceOf(self.myclass,instanceOrFirstParameter) then
			local foundtype = type(instanceOrClass)
			if foundtype == hoi3.TYPE_TABLE then 
				if middleclass.instanceOf(hoi3.Object, instanceOrClass) then
					foundtype = tostring(instanceOrClass.class)
				end
			end
			hoi3.error("A non-static API call ("..tostring(self)..
				") did not received a "..(self.myclass.name)..
				" instance as first parameter. "..foundtype.." found")
		end
		instanceOrClass = instanceOrFirstParameter
	end
	
	-- Assert real function call arguments
	for i, v in ipairs(self.args) do
		if args[i] == hoi3.TYPE_UNKNOWN then
			hoi3.throwUnknownSignature()
		end
		hoi3.assertParameterType(i, args[i], v)
	end
	
	-- Compute hash key for current parameters
	local hash = self._hashArgs(args)
	
	--optimization
	if self.myclass == instanceOrClass then
		return instanceOrClass, args, hash, false
	end
	
	local isInstance = middleclass.instanceOf(self.myclass, instanceOrClass)
	local isSubclass = middleclass.subclassOf(hoi3.Object, instanceOrClass)
	
	-- test and be verbose !
	if not (isInstance or isSubclass) then
		local foundtype = type(instanceOrClass)
		if foundtype == hoi3.TYPE_TABLE then 
			if middleclass.instanceOf(hoi3.Object, instanceOrClass) then
				foundtype = tostring(instanceOrClass.class)
			end
		end
		hoi3.error(tostring(self).." first parameter is not "..tostring(self.myclass).." instance or class reference, "..foundtype.." found.")
	end
	
	return instanceOrClass, args, hash, isInstance
end

function FunctionObject:__call(instanceOrFirstParameter, ...)
	hoi3.assertNonStatic(self)
	
	if self.ret == hoi3.TYPE_UNKNOWN then
		hoi3.throwUnknownReturnType()
	end
	
	-- Count top level calls
	local isNestedApiCall = false
	if FunctionObject.isRunningApiCall == true then
		isNestedApiCall = true
	else
		FunctionObject.isRunningApiCall = true
	end

	-- Handle (non-)static context with proper tests.	
	local instanceOrClass, args, hash, isInstance = self:_checkArgs(instanceOrFirstParameter, ...)
	
	-- Now get return value
	local ret = {} -- return value return multiple result, we store them as a table, and then unpack() it
	
	if isInstance and
		instanceOrClass.__result ~= nil and
		instanceOrClass.__result[self] ~= nil and
		instanceOrClass.__result[self][hash] ~= nil then
		ret = {
			Hoi3Object.assertReturnTypeAndReturn(
				instanceOrClass.__result[self][hash],
				self.ret:__tostring()
			)
		}
	else
		local computedValue
		
		-- No cached method result, we'll have to compute value
		-- (either by Impl method or randomized result)
		-- and to cheat it as real function result.

		-- Try Impl method is exists ( real method this time, not a FunctionObject)
		if self:hasImpl() then
			if self.static then 
				computedValue = self:runImpl(unpack(args))
			else
				computedValue = self:runImpl(instanceOrClass,unpack(args))
			end
		else
			-- No Impl method result ?
			-- Create a randomized result (depending on expected return type)
			-- May throw a specific exception "no randomizer"
			computedValue = self.ret:compute()
		end
		
		if computedValue ~= nil then
			if self:canSave() then
				-- Now cache results as if it was the original function/method result
				instanceOrClass.__result = instanceOrClass.__result or {}
				instanceOrClass.__result[self] = instanceOrClass.__result[self] or {}
				instanceOrClass.__result[self][hash] = computedValue  
			end
			
			-- And return (with a test on returned value type)
			ret = {
				Hoi3Object.assertReturnTypeAndReturn(
					computedValue,
					self.ret:__tostring()
				)
			}
		end
	end
	
	-- Count top level calls
	if not(isNestedApiCall) then
		FunctionObject.isRunningApiCall = false
		FunctionObject.numApiCalls = FunctionObject.numApiCalls + 1 
		self.runs = (self.runs + 1) or 1 
		self.druns[hash] = self.druns[hash] or 0
		self.druns[hash] = self.druns[hash] + 1
	end
	
	return unpack(ret)
end



-- Save/Load support
function FunctionObject:hasResult(instanceOrFirstParameter, ...)
	hoi3.assertNonStatic(self)
	
		-- Handle (non-)static context with proper tests.	
	local instanceOrClass, args, hash, isInstance = self:_checkArgs(instanceOrFirstParameter, ...)
	
	return isInstance and
		instanceOrClass.__result ~= nil and
		instanceOrClass.__result[self] ~= nil and
		instanceOrClass.__result[self][hash] ~= nil
end

---
-- Transform parameters list to a string (hashable)
-- @param ...
-- @return string
-- @static
function FunctionObject._hashArgs(args)
	--TODO, make something better than that...
	local args = args or {}
	local hash = "--"
	
	for i,k in ipairs(args) do
		hash = hash .. " #" .. i .. "=" .. tostring(k)
	end
	
	return hash
end

---
-- Save a value for a object instance (or object definition for static method),
-- method, and parameters.
function FunctionObject:save(value, instanceOrFirstParameter, ...)
	hoi3.assertNonStatic(self)
	
	-- Don't save if not allowed to
	if not self:canSave() then return end
	
	local instanceOrClass, args, hash, isInstance = self:_checkArgs(instanceOrFirstParameter, ...)
	
	if not isInstance then
		hoi3.error("Static method save support is unavailable.")
	end
	
	-- No nil, force tables
	instanceOrClass.__result = instanceOrClass.__result or {}
	instanceOrClass.__result[self] = instanceOrClass.__result[self] or {}
	instanceOrClass.__result[self][hash] = value
end

---
-- One heavy piece of code to cast expected return to usable fake API objects
--
function FunctionObject:ApiReturnToFakeApiReturn(val1, val2, val3)
	-- Now that we have a result what to do ?
	if self.ret.type == hoi3.TYPE_VOID or 
		self.ret.type == hoi3.TYPE_NIL then
		return
	elseif self.ret.type == hoi3.TYPE_NUMBER or
		self.ret.type == hoi3.TYPE_BOOLEAN or
		self.ret.type == hoi3.TYPE_STRING then
		-- scalar value, quite straight forward to handle
		return val1
		
	elseif self.ret.type == hoi3.TYPE_ITERATOR or
		self.ret.type == hoi3.TYPE_TABLE then
		-- table values
		
		-- special case, arg 2 is the good value if iterator
		if self.ret.type == hoi3.TYPE_ITERATOR then
			val1 = val2
		end 
		
		-- Iterator seems to return nul values instead of empty array ?!
		if val1 == nil then return {} end
		
		-- Valid value ?
		assert(type(val1) == hoi3.TYPE_TABLE,"failed to run ApiReturnToFakeApiReturn, expected table but got "..tostring(type(val1)))
		
		-- 
		local myRet = {}
		
		-- we should now scan the tables
		for i,v in ipairs(val1) do
			if self.ret.subtype.type ==  hoi3.TYPE_NUMBER or
				self.ret.subtype.type == hoi3.TYPE_BOOLEAN or
				self.ret.subtype.type == hoi3.TYPE_STRING then
				myRet[i] = v
			else
				hoi3.assert(hoi3.api[self.ret.subtype.type]~=nil, "failed to run ApiReturnToFakeApiReturn, expected userdata but unable to find class for "..self.ret.subtype.type)
				--may won't work because of forced numeric index :(
				myRet[i] = hoi3.api[self.ret.subtype.type]:userdataToInstance(v)
			end
		end
		return myRet
	else		
		-- must be USERDATA !
		hoi3.assert(hoi3.api[self.ret.type]~=nil, "failed to run ApiReturnToFakeApiReturn, expected userdata but unable to find class for "..tostring(self.ret.type))
		dtools.debug("ApiReturnToFakeApiReturn pass to userdataToInstance() "..self.ret.type)
		return hoi3.api[self.ret.type]:userdataToInstance(val1)
	end
end

function FunctionObject:runAndSave(userdata, instance)
	hoi3.assertNonStatic(self)
	dtools.debug("Run and save real function "..tostring(self:signatureAsString()).." for instnace "..tostring(instance)..".")
	
	if not self:canSave() then
		dtools.info(tostring(self).." ignored by runAndSave() because of void return type or explicitly cache free.")
	elseif not self:canRun() then
		dtools.warn(tostring(self).." ignored by runAndSave() because of unknown return type or parameter.")
	else
		if userdata[self.name] == nil or type(userdata[self.name]) ~= hoi3.TYPE_FUNCTION then
			dtools.warn(tostring(self).." does not exists in real API !")
		else
			-- prepare all parameters combinations as a table of table
			local arg_combination = {{}}
			if #self.args > 0 then
				-- there are parameters
				dtools.warn(tostring(self).." not (yet) supported because of multiple parameters !")
				return
			end
			
			for i, myargs in ipairs(arg_combination) do
				local mytime = os.clock()
				
				--for i, args in ipairs(arg_combination) do
				local ret, value, value2, value3 = pcall(userdata[self.name],userdata,unpack(myargs))
				if ret == false then
					dtools.error(tostring(self).." failed to run ! "..tostring(value))
				else
					--value is pure API result
					local fakeApiValue = self:ApiReturnToFakeApiReturn(value)
					-- if the fakeApiValue is another Hoi3object, then call runRealApiAndSave
					if type(fakeApiValue) == hoi3.TYPE_TABLE and 
						middleclass.instanceOf(hoi3.Hoi3Object,fakeApiValue) then
						-- runRealApiAndSave supports something to avoid recursive loops
						fakeApiValue:runRealApiAndSave()
					end
					
					-- Save transformed userdata to Hoi3Object instance
					self:save(fakeApiValue,instance)
										
					self.realruns = self.realruns + 1
					self.realtime = self.realtime + os.clock() - mytime
				end
			end
		end 
	end
end