require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = middleclass.class('hoi3.Hoi3Object')

function Hoi3Object:initialize(...)
	super.initialize(self, ...)
end

function Hoi3Object.getConstructorSignature(instanceOrClass)
	if middleclass.instanceOf(hoi3.Object,instanceOrClass) then
		instanceOrClass = instanceOrClass.class
	end
	
	return instanceOrClass.constructorSignature
end

function Hoi3Object.getConstants(instanceOrClass)
	local t = {}
	local bInherited = bInherited or false
	
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