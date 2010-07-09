require('hoi3.api.CCountryTag')

module("hoi3.api", package.seeall)

CNullTag = CCountryTag:subclass('hoi3.api.CNullTag')

-- Constructor signature
-- information only, that will be used by documentation generator.
CNullTag.constructorSignature = {}

-- singleton behavior
CNullTag.new = function(theClass, ...)
	if CNullTag.instance == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize()
  		CNullTag.instance = instance
  	end
  	
  	return CNullTag.instance
end

function CNullTag:initialize()
	
end

function CNullTag:__tostring()
	return ""
end