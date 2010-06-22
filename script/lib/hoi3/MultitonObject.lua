require('hoi3.Hoi3Object')

MultitonObject = Hoi3Object:subclass('hoi3.MultitonObject')

MultitonObject.instances = {}

MultitonObject.new = function(theClass, key, ...)
	if key == nil then
		error("Multiton constructor needs a key/hash as first parameter.")
	end
	
	if MultitonObject.instances[key] ~= nil then
  		MultitonObject.instances[key] = Super.new(theClass, key, ...)
  	end
  	
  	return MultitonObject.getInstance(key)
end

MultitonObject.getInstance = function(key)
	return MultitonObject.instances[key]
end 
