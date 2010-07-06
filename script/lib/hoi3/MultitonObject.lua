require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

MultitonObject = Hoi3Object:subclass('hoi3.MultitonObject')

MultitonObject.instances = {}

function MultitonObject:_getUnid()
	return self._unid
end

function MultitonObject:argsToUnid(...)
	local args = {...}
	local numkeys = self.numkeys or 1
	local key = self.name.."["
	
	assert(1<=numkeys and numkeys<=4, tostring(self).." numkeys property must be between 1 and 3")
  	assert(#args == numkeys, tostring(self).." constructor requires "..tostring(numkeys).." keys parameters, "..tostring(#args).." given.")
  	
  	for i=1,numkeys do
  		local t = type(args[i])
  		if t == hoi3.TYPE_TABLE and 
  			middleclass.instanceOf(hoi3.MultitonObject,args[i]) then
			key = key .. args[i]:_getUnid()
		else
			if t == hoi3.TYPE_STRING and
				t == hoi3.TYPE_NUMBER and
				t == hoi3.TYPE_BOOLEAN then
				
				error("Multiton key args must be either Multiton object or scalar !")
			end
			
			key = key .. args[i]				
		end
  		
  		if i~=numkeys then
  			key = key .. "---" --separator
  		end
  	end
  	
  	key = key .. "]"
  	return key
end 

function MultitonObject:new(...)
	local key = self:argsToUnid(...)
	-- Force table creation
  	MultitonObject.instances[self.name] = MultitonObject.instances[self.name] or {}
  	
  	if nil == MultitonObject.instances[self.name][key] then
  		local instance = setmetatable({ class = self }, self.__classDict)
	  	instance:initialize(...)
	  	instance._unid = key
	  	MultitonObject.instances[self.name][key] = instance 
  	end
  	
  	return self:getInstance(key)
end

function MultitonObject:hasInstance(key)
	return MultitonObject.instances[self.name] ~= nil and
		MultitonObject.instances[self.name][key] ~= nil
end 

function MultitonObject:getInstance(key)
	if self:hasInstance(key) then
		return MultitonObject.instances[self.name][key]
	end
	
	hoi3.throwDataNotFound(self.name, key)
end 

function MultitonObject:clearInstances()
	MultitonObject.instances[self.name] = {}
end

function MultitonObject:getInstances()
	return MultitonObject.instances[self.name]
end