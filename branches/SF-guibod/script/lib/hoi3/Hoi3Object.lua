require('middleclass')

Hoi3Object = class('hoi3.Hoi3Object')

function Hoi3Object.assertParameterType(index, parameterValue, typeAsString)
	local t = type(parameterValue)
	
	if typeAsString == 'table' or typeAsString == 'number' or typeAsString=='string' or typeAsString=='boolean' then
		assert(t==typeAsString, "passed argument #"..index.." is not primitive type "..typeAsString..".")
	elseif t == 'table' then
		assert(instanceOf(_G[typeAsString], parameterValue), "passed argument #"..index.." is not "..typeAsString..".")
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

function Hoi3Object.hashArgs(...)
	local hash = ""
	local args = {...}
	
	for i,k in ipairs(args) do
		hash = hash .. " #" .. i .. "=" .. tostring(k)
	end
	
	return hash
end

--[[
	Easy way to define constant result for the same call 
	signature on the same instance of the same object.
]]
Hoi3Object.resultTable = {}

Hoi3Object.saveResult = function(self, value, method, ...)
	assert(type(method)=="function", "Unable to save value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...)
	if Hoi3Object.resultTable[self] == nil then
		Hoi3Object.resultTable[self] = {}
	end
	if Hoi3Object.resultTable[self][method] == nil then
		Hoi3Object.resultTable[self][method] = {}
	end
	Hoi3Object.resultTable[self][method][hash] = value
end

-- Intends to be used in a HOI3 (needs to renamed fake LUA object to something else tough)
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "FRA")
-- FakeCAI:runAndSaveResult(CAI.CanDeclareWar,"GER", "ENG")
-- FakeCAI:serialize()
Hoi3Object.runAndSaveResult = function(self, method, value, ...)
	Hoi3Object.saveResult(self, method(...), method, ...)
end

Hoi3Object.hasResult = function(self, method, ...)
	local hash = Hoi3Object.hashArgs(...) 	
	return
		Hoi3Object.resultTable[self] ~= nil and
		Hoi3Object.resultTable[self][method] ~= nil and
		Hoi3Object.resultTable[self][method][hash] ~= nil
end

Hoi3Object.loadResult = function(self, method, ...)
	assert(type(method)=="function", "Unable to recover value. Unknown function or method.")
	
	local hash = Hoi3Object.hashArgs(...) 	
	assert(Hoi3Object.resultTable[self] ~= nil, "Unable to recover value. Unknown object reference.")
	assert(Hoi3Object.resultTable[self][method] ~= nil, "Unable to recover value. Unknown function or method.")
	assert(Hoi3Object.resultTable[self][method][hash] ~= nil, "Unable to recover value. Unknown signature.")
	
	return Hoi3Object.resultTable[self][method][hash]
end

--[[
	If a result is defined, get it
	or fallback to function name+"Fake"suffix
]]
Hoi3Object.loadResultOrFake  = function(self, methodName, ...)
	local fReference = self[methodName]
	if fReference ~= nil  then
		assert(type(fReference) == "function", "Unable to recover value. Function name refers to a non function reference.")
		
		if self:hasResult(fReference, ...) then
			return self:loadResult(fReference, ...)
		end
	end
	
	local fReference = self[methodName.."Fake"]
	if fReference ~= nil  then
		assert(type(fReference) == "function", "Unable to recover value. Function name refers to a non function reference.")
		
		if self:hasResult(fReference, ...) then
			return self:loadResult(fReference, ...)
		end
	end
	
	-- Not implemented !
	Hoi3Object.throwNotYetImplemented()	
end
