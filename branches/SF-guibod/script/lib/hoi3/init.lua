--[[
	HOI3 Impl API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a Impl game instance.

	All values returned fully random atm. 
]]

module( "hoi3", package.seeall)

TYPE_UNKNOWN 	= 'unknown'
TYPE_VOID	 	= 'void'
TYPE_NIL	 	= 'nil'
TYPE_NUMBER 	= 'number'
TYPE_BOOLEAN 	= 'boolean'
TYPE_STRING 	= 'string'
TYPE_TABLE	 	= 'table'
TYPE_FUNCTION 	= 'function'
TYPE_THREAD 	= 'thread'
TYPE_USERDATA 	= 'userdata'
TYPE_ITERATOR 	= 'iterator'

require("hoi3.Hoi3Object")
require("hoi3.AbstractObject")
require("hoi3.MultitonObject")
require("hoi3.SingletonObject")
require("hoi3.FunctionObject")
require("hoi3.Randomizer")
require("middleclass")
Object = middleclass.Object

---
-- hoi3.testType is able to test Object:subclass() existence
-- but subclasses MUST be defined in hoi3.api module.
function testType(value, typeAsString)
	local t = type(value)
	
	if Randomizer.isTableTypeString(typeAsString) or
		Randomizer.isIteratorTypeString(typeAsString) then
		if(t~=TYPE_TABLE) then return false end
		local myType = Randomizer.getTableTypeFromString(typeAsString)
		for i,v in pairs(value) do
			if not testType(v, myType) then
				return false
			end
		end
		return true
	elseif typeAsString == TYPE_TABLE or 
		typeAsString == TYPE_NUMBER or 
		typeAsString==TYPE_STRING or 
		typeAsString==TYPE_BOOLEAN then
		return t==typeAsString
	elseif typeAsString == TYPE_ITERATOR then
		return t==TYPE_FUNCTION or 
			(t==TYPE_TABLE and type(getmetatable(t).__call)==TYPE_FUNCTION )
	elseif t == TYPE_TABLE then
		-- Where to find class definition ?
		-- inside hoi3 package objects
		if hoi3[typeAsString] then
			return middleclass.instanceOf(hoi3[typeAsString], value)
		else
 			-- must be a hoi3.api package member
			require('hoi3.api')
			
			return middleclass.instanceOf(hoi3.api[typeAsString], value)
		end
	else
		--thread, userdata, nil or function
		return false
	end
end

function assertParameterType(index, parameterValue, typeAsString)
	local foundtype = type(parameterValue)
	if foundtype == hoi3.TYPE_TABLE and 
		middleclass.instanceOf(hoi3.Object, parameterValue) then
		foundtype = tostring(parameterValue.class)
	end
	assert(
		testType(parameterValue, typeAsString),
		"passed argument #"..index.." is not type "..typeAsString..", "..foundtype.." found."
	)
end

function assertReturnType(returnValue, typeAsString)
	local foundtype = type(returnValue)
	if foundtype == hoi3.TYPE_TABLE and 
		middleclass.instanceOf(hoi3.Object, returnValue) then
		foundtype = tostring(returnValue.class)
	end
	assert(
		testType(returnValue, typeAsString),
		"returned value is not type "..typeAsString..", "..foundtype.." found."
	)
end

function assertNonStatic(self)
	assert(self~=nil and 
		type(self)==TYPE_TABLE and 
		middleclass.instanceOf(middleclass.Object, self), 
		"Non-static method cannot be referenced from a static context.")
end

function throwNotYetImplemented()
	error("Unsupported API feature. Not yet implemented in HOI3 Impl API.")
end

function throwUnknownSignature()
	error("Unknown API signature. Not implemented in HOI3 Impl API.")
end

function throwUnknownReturnType()
	error("Unknown API return type. Not implemented in HOI3 Impl API.")
end

function throwDataNotFound(t, k)
	error("Data not found ! Cannot find "..tostring(t).." using `"..k.."` as key.")
end

function throwNoRandomizerSupport(typeAsString)
	if typeAsString == nil then
		typeAsString = "[no type specified]"
	end
	error("Missing randomizer support for "..typeAsString..". Not implemented in HOI3 Impl API.")
end

function randomIteratorMember(iterator, invariant, index)
	return randomTableMember(invariant)
end

function randomTableMember(table)
	if type(table) ~= TYPE_TABLE then return nil end
	
	-- Lua can't be trusted for counting dict members for some reason
	-- hence #table won't work
	local size = 0
	for _,_ in pairs(table) do
		size = size + 1
	end
	if size == 0 then return nil end
	
	Randomizer.seed()
	local j = math.random(size)
	local i = 1
	for _, v in pairs(table) do
		if i == j then
			return v
		end
		i = i + 1
	end
end

function countIteratorMember(iterator, invariant, index)
	return countTableMember(invariant)
end

function countTableMember(t)
	local i = 0
	for k,v in pairs(t) do
		i = i + 1
	end
	return i
end

function fromIndexTableMember(table, index)
	if type(table) ~= TYPE_TABLE then return nil end
	if type(index) ~= TYPE_NUMBER then return nil end

	for i, v in ipairs(table) do
		if i == index then
			return v
		end
	end
end

---
-- A keyless iterator factory
-- 
function hoi3iterator(t)
  local i = {}
  for k, v in pairs(t) do
  	i[v] = v
  end 
  
  return next, i, nil
end

