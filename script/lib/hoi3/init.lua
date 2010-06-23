--[[
	HOI3 fake API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a fake game instance.

	All values returned fully random atm. 
]]

module( "hoi3", package.seeall)

TYPE_NUMBER 	= 'number'
TYPE_BOOLEAN 	= 'boolean'
TYPE_STRING 	= 'string'
TYPE_TABLE	 	= 'table'
TYPE_FUNCTION 	= 'function'
TYPE_THREAD 	= 'thread'
TYPE_USERDATA 	= 'userdata'

function testType(value, typeAsString)
	local t = type(value)
	
	if typeAsString:sub(0,6) == TYPE_TABLE.."<" then
		if(t~=TYPE_TABLE) then return false end
		local myType = typeAsString:sub(0,-2):sub(7)
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
		return instanceOf(_G[typeAsString], value)
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

function throwNotYetImplemented()
	error("Unsupported API feature. Not yet implemented in HOI3 fake API.")
end

function throwUnknownSignature()
	error("Unknown API signature. Not implemented in HOI3 fake API.")
end

function throwUnknownReturnType()
	error("Unknown API return type. Not implemented in HOI3 fake API.")
end

function throwNoRandomizerSupport(typeAsString)
	if typeAsString == nil then
		typeAsString = "[no type specified]"
	end
	error("Missing randomizer support for "..typeAsString..". Not implemented in HOI3 fake API.")
end

function testAll()
	require("lunit")
	require("hoi3.tests.unit")
	require("hoi3.tests.type")
	require("hoi3.tests.save")
	require("hoi3.tests.multiton")
	require("hoi3.tests.abstract")
	require("hoi3.tests.fixedpoint")
	
	lunit.main()
end