require('hoi3.api.CTechnology')

module("hoi3.api", package.seeall)

CNullTechnology = CTechnology:subclass('hoi3.CNullTechnology')

-- singleton behavior
CNullTechnology.new = function(theClass, ...)
	if CNullTechnology.instance == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize(...)
  		CNullTechnology.instance = instance
  	end
  	
  	return CNullTechnology.instance
end