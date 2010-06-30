require('middleclass')

module( "hoi3", package.seeall)

FunctionObject = middleclass.Object:subclass('hoi3.FunctionObject')

function f(class, name, static, ret, ...)
	return FunctionObject(class, name, static, ret, ...)
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
	self.param = {...}
	
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

function FunctionObject:__call(s, ...)
	hoi3.assertNonStatic(self)
	
	if self.ret == hoi3.TYPE_UNKNOWN then
		hoi3.throwUnknownSignature()
	end
	
	local myparams = {...}
	local ret
	local isnestedapicall = false
	if FunctionObject.isRunningApiCall == true then
		isnestedapicall = true
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
		myparams = {s, ...}
	else
		hoi3.assertNonStatic(s)
	end
	
	-- Assert real function call parameter
	for i, v in ipairs(self.param) do
		if myparams[i] == hoi3.TYPE_UNKNOWN then
			hoi3.throwUnknownSignature()
		end
		hoi3.assertParameterType(i, myparams[i], v)
	end
	
	if self.static == true then
		ret1, ret2, ret3 = self.myclass.loadResultOrImplOrRandom(
			self.myclass, self, s, ...
		)
	else
		ret1, ret2, ret3 = s:loadResultOrImplOrRandom(self, ...)
	end
	
	if not(isnestedapicall) then
		FunctionObject.isRunningApiCall = false
		FunctionObject.numApiCalls = FunctionObject.numApiCalls + 1 
	end
	
	return ret1, ret2, ret3
end