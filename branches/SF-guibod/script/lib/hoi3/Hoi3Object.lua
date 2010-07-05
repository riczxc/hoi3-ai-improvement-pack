require('middleclass')

module( "hoi3", package.seeall)

Hoi3Object = middleclass.class('hoi3.Hoi3Object')

function Hoi3Object.registerInstance(i)
	Hoi3Object.instances = Hoi3Object.instances or {}
	Hoi3Object.instances[#Hoi3Object.instances+1] = i
end

function Hoi3Object:initialize(...)
	super.initialize(self, ...)
	
	Hoi3Object.registerInstance(self)
end

function Hoi3Object.assertReturnTypeAndReturn(returnValue, typeAsString)
	-- special case, transform a table (table) into iterator (func, table)
	-- this is a workaround in order to avoid support for multiple result
	-- caching as well as caching function references...
	-- An HOI3 iterator is not an array (ipairs) or dictionnary (pairs) but a true list (next)
	if hoi3.Randomizer.isIteratorTypeString(typeAsString) then
		hoi3.assertReturnType(returnValue, hoi3.TYPE_TABLE.."<"..hoi3.Randomizer.getIteratorTypeFromString(typeAsString)..">")
		return next, returnValue, nil
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