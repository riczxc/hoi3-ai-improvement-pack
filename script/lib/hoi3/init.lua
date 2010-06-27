--[[
	HOI3 Impl API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a Impl game instance.

	All values returned fully random atm. 
]]

module( "hoi3", package.seeall)

require("hoi3.Hoi3Object")
require("hoi3.AbstractObject")
require("hoi3.MultitonObject")
require("hoi3.SingletonObject")
require("hoi3.Randomizer")

TYPE_NIL	 	= 'nil'
TYPE_NUMBER 	= 'number'
TYPE_BOOLEAN 	= 'boolean'
TYPE_STRING 	= 'string'
TYPE_TABLE	 	= 'table'
TYPE_FUNCTION 	= 'function'
TYPE_THREAD 	= 'thread'
TYPE_USERDATA 	= 'userdata'

---
-- hoi3.testType is able to test Object:subclass() existence
-- but subclasses MUST be defined in hoi3.api module.
function testType(value, typeAsString)
	local t = type(value)
	
	if Randomizer.isIteratorTypeString(typeAsString) then
		if(t~=TYPE_TABLE) then return false end
		local myType = Randomizer.getIteratorTypeFromString(typeAsString)
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
	elseif t == TYPE_TABLE then
		-- Where to find class definition ?
		
		-- inside hoi3 package objects
		if hoi3[typeAsString] then
			return instanceOf(hoi3[typeAsString], value)
		else
			-- must be a hoi3.api package member
			require('hoi3.api')
			
			return instanceOf(hoi3.api[typeAsString], value)
		end
	else
		--thread, userdata, nil or function
		return false
	end
end

function assertParameterType(index, parameterValue, typeAsString)
	assert(
		testType(parameterValue, typeAsString),
		"passed argument #"..index.." is not type "..typeAsString..", "..type(parameterValue).." found."
	)
end

function assertReturnType(returnValue, typeAsString)
	assert(
		testType(returnValue, typeAsString),
		"returned value is not type "..typeAsString..", "..type(returnValue).." found."
	)
end

function assertNonStatic(self)
	assert(self~=nil and 
		type(self)==TYPE_TABLE and 
		instanceOf(hoi3.Hoi3Object, self), 
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

function throwDataNotFound()
	error("Data not found exception.")
end

function throwNoRandomizerSupport(typeAsString)
	if typeAsString == nil then
		typeAsString = "[no type specified]"
	end
	error("Missing randomizer support for "..typeAsString..". Not implemented in HOI3 Impl API.")
end

function testAll()
	require("lunit")
	require("hoi3.tests.unit")
	require("hoi3.tests.type")
	require("hoi3.tests.save")
	require("hoi3.tests.multiton")
	require("hoi3.tests.abstract")
	require("hoi3.tests.fixedpoint")
	require("hoi3.tests.random")
	require("hoi3.tests.cdate")
	
	lunit.main()
end

function randomTableMember(table)
	if type(table) ~= TYPE_TABLE then return nil end
	
	math.randomseed(os.time)
	local j = math.random(#table)
	for i, v in pairs(table) do
		if i == j then
			return v
		end
	end
end
