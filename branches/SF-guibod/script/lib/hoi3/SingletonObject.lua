require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

SingletonObject = Hoi3Object:subclass('hoi3.SingletonObject')

SingletonObject.instances = {}

SingletonObject.new = function(theClass, ...)
	if SingletonObject.instances[theClass] == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize(...)
  		SingletonObject.instances[theClass] = instance
  	end
  	
  	return SingletonObject.getInstance(theClass)
end

SingletonObject.getInstance = function(theClass)
	if SingletonObject.instances[theClass] ~= nil then 
		return SingletonObject.instances[theClass]
	end
end 
