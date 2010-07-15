require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = middleclass.class('hoi3.Hoi3Object')

function Hoi3Object:initialize(...)
	super.initialize(self, ...)
end

function Hoi3Object.getConstructorSignature(instanceOrClass, bInherited)
	local bInherited = bInherited or false
	
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	if bInherited and instanceOrClass.superclass ~= nil 
		and instanceOrClass.superclass.__classDict ~= nil
		and instanceOrClass.superclass.getConstructorSignature then
		return instanceOrClass.constructorSignature or instanceOrClass.superclass:getConstructorSignature(true)
	else
		return instanceOrClass.constructorSignature
	end
end

function Hoi3Object.getMathMetamethods(instanceOrClass)
	local t = {}
	
	-- if we have an instance, get its class
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	-- a class have a __classDict, if nothing, not a class object.
	if instanceOrClass.__classDict ~= nil then
		for k, v in pairs(instanceOrClass.__classDict) do				
			if (type(v) == hoi3.TYPE_FUNCTION) and 
				string.find(k,"^__%l+$") ~= nil then
				
				local s = {}
				s["__eq"] = "=="
				s["__add"] = "+"
				s["__sub"] = "-"
				s["__mul"] = "*"
				s["__div"] = "/"
				s["__lt"] = "<"
				s["__le"] = "<="
				s["__pow"] = "^"
				s["__unm"] = "unitary minus"
				
				if s[k] ~= nil then
					table.insert(t, s[k])
				end
			end
		end
	end
	
	return t
end

function Hoi3Object.getSpecialMetamethods(instanceOrClass)
	local t = {}
	
	-- if we have an instance, get its class
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	-- a class have a __classDict, if nothing, not a class object.
	if instanceOrClass.__classDict ~= nil then
		for k, v in pairs(instanceOrClass.__classDict) do				
			if (type(v) == hoi3.TYPE_FUNCTION) and 
				string.find(k,"^__%l+$") ~= nil then
				
				local s = {}
				s["__index"] = "'prototype' inheritance"
				s["__newindex "] = "property assignment"
				s["__mode"] = "weak references"
				s["__call"] = "callable through "..tostring(instanceOrClass.name).."()"
				s["__metatable"] = "hidden metatable"
				s["__tostring"] = "supports tostring() operator"
				s["__gc"] = "userdata finalizer code"
				
				if s[k] ~= nil then
					table.insert(t, s[k])
				end
			end
		end
	end
	
	return t
end

function Hoi3Object.getConstants(instanceOrClass)
	local t = {}
	
	-- if we have an instance, get its class
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	-- a class have a __classDict, if nothing, not a class object.
	if instanceOrClass.__classDict ~= nil then
		for k, v in pairs(instanceOrClass.__classDict) do				
			if (type(v) == hoi3.TYPE_NUMBER or 
				type(v) == hoi3.TYPE_STRING) and 
				string.find(k,"^[A-Z_]+$") ~= nil then
				t[k] = v
			end
		end
	end
	
	return t
end

function Hoi3Object.getProperties(instanceOrClass)
	-- if we have an instance, get its class
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	-- a class have a __classDict, if nothing, not a class object.
	if instanceOrClass.__classDict ~= nil and 
		instanceOrClass.__classDict.properties ~= nil then
		return instanceOrClass.__classDict.properties
	end
	return {}
end

function Hoi3Object.getApiFunctions(instanceOrClass, bInherited)
	local t = {}
	local bInherited = bInherited or false
	
	-- if we have an instance, get its class
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	-- a class have a __classDict, if nothing, not a class object.
	if instanceOrClass.__classDict ~= nil then
		if bInherited and instanceOrClass.superclass ~= nil 
			and instanceOrClass.superclass.__classDict ~= nil
			and instanceOrClass.superclass.getApiFunctions then
			t = instanceOrClass.superclass:getApiFunctions(true)
		end
		
		for k, v in pairs(instanceOrClass.__classDict) do
			if type(v) == hoi3.TYPE_TABLE and 
				middleclass.instanceOf(hoi3.FunctionObject, v) then
				t[k] = v
			end
		end
	end
	return t
end

function Hoi3Object:clearResults()
	self.__result = {}
end

function Hoi3Object.assertReturnTypeAndReturn(returnValue, typeAsString)
	-- special case, transform a table (table) into iterator (func, table)
	-- this is a workaround in order to avoid support for multiple result
	-- caching as well as caching function references...
	-- An HOI3 iterator is not an array (ipairs) or dictionnary (pairs) but a true list (next)
	if hoi3.Randomizer.isIteratorTypeString(typeAsString) then
		hoi3.assertReturnType(returnValue, hoi3.TYPE_TABLE.."<"..hoi3.Randomizer.getIteratorTypeFromString(typeAsString)..">")
		return hoi3.hoi3iterator(returnValue)
	else
		hoi3.assertReturnType(returnValue, typeAsString)
		return returnValue
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

function Hoi3Object.userdataToInstance(myClass, userdata, parent)
	if userdata == nil then
		dtools.warn("Expected CContinent userdata but got nil !?")
		return
	end
	
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	local myInstance = myClass:new()
	myInstance.__userdata = userdata
	return myInstance
end

function Hoi3Object:runRealApiAndSave()
	hoi3.assertNonStatic(self)
	hoi3.assert(self.__userdata ~= nil, "Object not binded yet ! Please use object:bind(userdata).")
	
	if self.__runningRealApiAndSave then 
		-- Already running (nested loop)
		dtools.debug("Already run or running save real api for "..tostring(self.class).." instnace "..tostring(self)..".")
	
		return
	end
	dtools.debug("Starting to run and save real api for "..tostring(self.class).." instnace "..tostring(self)..".")
	self.__runningRealApiAndSave = true
	for n, m in pairs(self:getApiFunctions()) do
		m:runAndSave(self.__userdata,self)
	end
end