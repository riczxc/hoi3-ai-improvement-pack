require('middleclass')

Hoi3Object = class('hoi3.Hoi3Object')

function Hoi3Object:genRandomNumber()

end

function Hoi3Object.assertParameterType(index, parameterValue, typeAsString)
	local t = type(parameterValue)
	
	if typeAsString == 'table' or typeAsString == 'number' or typeAsString=='string' or typeAsString=='boolean' then
		assert(t==typeAsString, "passed argument #"..index.." is not primitive type "..typeAsString..".")
	elseif t == 'table' then
		assert(instanceOf(parameter, _G[t2]), "passed argument #"..index.." is not "..typeAsString..".")
	else
		--thread, userdata, nil or function
		assert(false, "passed argument is not "..typeAsString..".")
	end
end

function Hoi3Object.throwNotYetImplemented()
	assert(false, "Unsupported API feature. Not yet implemented in HOI3 fake API.")
end

function Hoi3Object.throwUnknownSignature()
	assert(false, "Unknown API signature. Not implemented in HOI3 fake API.")
end

function Hoi3Object.throwUnknownReturnType()
	assert(false, "Unknown API return type. Not implemented in HOI3 fake API.")
end
