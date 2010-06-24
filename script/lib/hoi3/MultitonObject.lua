require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

MultitonObject = Hoi3Object:subclass('hoi3.MultitonObject')

MultitonObject.instances = {}

MultitonObject.new = function(theClass, key, ...)
  	assert(key~=nil, "Multiton constructor needs a key/hash as first parameter.")
  
  	-- Force table creation
  	MultitonObject.instances[theClass] = MultitonObject.instances[theClass] or {}
  
	if MultitonObject.instances[theClass][key] == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize(key, ...)
  		MultitonObject.instances[theClass][key] = instance
  	end
  	
  	return MultitonObject.getInstance(theClass, key)
end

MultitonObject.getInstance = function(theClass, key)
	if MultitonObject.instances[theClass] ~= nil and
		MultitonObject.instances[theClass][key] ~= nil then
		return MultitonObject.instances[theClass][key]
	end
end 
