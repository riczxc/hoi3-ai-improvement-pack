require('hoi3.api.CCountryTag')

module("hoi3.api", package.seeall)

CNullTag = CCountryTag:subclass('hoi3.api.CNullTag')

-- Constructor signature
-- information only, that will be used by documentation generator.
CNullTag.constructorSignature = {}

---
-- @since 1.3
-- @return CNullTag 
function CNullTag:initialize()
	hoi3.assertNonStatic(self)
end

-- singleton behavior
CNullTag.new = function(theClass, ...)
	if CNullTag.instance == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize()
  		CNullTag.instance = instance
  	end
  	
  	return CNullTag.instance
end

---
-- @since 1.3
-- @return string 
hoi3.f(CCountryTag, 'GetTag', hoi3.TYPE_NIL)

function CNullTag:__tostring()
	return ""
end