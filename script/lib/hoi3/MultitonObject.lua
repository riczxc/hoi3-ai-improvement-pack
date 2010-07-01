require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

MultitonObject = Hoi3Object:subclass('hoi3.MultitonObject')

MultitonObject.instances = {}

MultitonObject.new = function(theClass, key1, key2, key3, ...)
  	local params = {key1, key2, key3, ...}
  	local numkeys = theClass.numkeys or 1
  	assert(1<=numkeys and numkeys<=4, "Multiton numkeys property must be between 1 and 3")
  	assert(#params == numkeys, "Multiton constructor requires "..tostring(numkeys).." keys parameters, "..tostring(#params).." given.")
  	
  	-- Force table creation
  	MultitonObject.instances[theClass] = MultitonObject.instances[theClass] or {}
  	
  	--
  	local doCreate = false
  	if numkeys >= 1 and MultitonObject.instances[theClass][key1] == nil then
  		MultitonObject.instances[theClass][key1] = {}
  		doCreate = true
  	end
  	
  	if numkeys >= 2 and MultitonObject.instances[theClass][key1][key2] == nil then
  		MultitonObject.instances[theClass][key1][key2] = {}
  		doCreate = true
  	end
  	
  	if numkeys >= 3 and MultitonObject.instances[theClass][key1][key2][key3] == nil then
  		MultitonObject.instances[theClass][key1][key2][key3] = {}
  		doCreate = true
  	end
  	
  	if doCreate then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
	  	instance:initialize(key1, key2, key3, ...)
	  	
	  	if numkeys == 1 then
	  		MultitonObject.instances[theClass][key1] = instance
	  	elseif numkeys == 2 then
	  		MultitonObject.instances[theClass][key1][key2] = instance
	  	elseif numkeys == 3 then
	  		MultitonObject.instances[theClass][key1][key2][key3] = instance
	  	end
  	end
  	
  	return MultitonObject.getInstance(theClass, key1, key2, key3)
end

function MultitonObject:getInstance(key1, key2, key3)
	local params = {key1, key2, key3}
  	local numkeys = self.numkeys or 1
  	assert(1<=numkeys and numkeys<=4, "Multiton numkeys property must be between 1 and 3")
  	assert(#params >= numkeys, "Multiton constructor requires "..tostring(numkeys).." keys parameters, "..tostring(#params).." given.")
  	
  	if MultitonObject.instances[self] ~= nil and
		MultitonObject.instances[self][key1] ~= nil then
		
		if numkeys == 1 then
			return MultitonObject.instances[self][key1]
		end
		
		if MultitonObject.instances[self][key1][key2] ~= nil then
			if numkeys == 2 then
				return MultitonObject.instances[self][key1][key2]
			end
		
			if MultitonObject.instances[self][key1][key2][key3] ~= nil then
				if numkeys == 3 then
					return MultitonObject.instances[self][key1][key2][key3]
				end
			end
		end
	end
end 

function MultitonObject:clearInstances()
	MultitonObject.instances[self] = {}
end

-- instance table returns a table of instance using instance as its own-key
-- this is VERY important for iterator with value only such the one
-- returned by HOI3 api.
function MultitonObject:getInstances()
	local numkeys = self.numkeys or 1
	if MultitonObject.instances[self] == nil then return {}	end
	return MultitonObject._getInstancesRecursor(MultitonObject.instances[self], numkeys)
end

MultitonObject._getInstancesRecursor = function(ref, level, db)
	local db = db or {}
	for k, v in pairs(ref) do
		if level > 1 then
			db = MultitonObject._getInstancesRecursor(v, (level - 1), db)
		else
			db[v] = v
		end
	end
	return db
end
