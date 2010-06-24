require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

Randomizer = Hoi3Object:subclass("hoi3.Randomizer")

function Randomizer:initialize(typeAsString)
	if Randomizer.isIteratorTypeString(typeAsString) then
		self.type = hoi3.TYPE_TABLE
		self.subtype = Randomizer(Randomizer.getIteratorTypeFromString(typeAsString))
	else
		self.type = typeAsString
	end
end

function Randomizer:__tostring()
	if self.type == hoi3.TYPE_TABLE and self.subtype ~= nil then
		return self.type.."<"..self.subtype..">"
	else
		return self.type
	end
end

Randomizer.isIteratorTypeString = function(str)
	return nil ~= Randomizer.getIteratorTypeFromString(str)
end

Randomizer.getIteratorTypeFromString = function(str)
	local found0, found1, capture1 = string.find(str, hoi3.TYPE_TABLE.."<(%a+)>")
	return capture1
end


--- Below Static methods

---
-- Compute random value for a given type
-- this method returns "nil" instead of throwing exception
--
-- minimal self properties :
-- self.type = string selfining
-- self.subtype = a nested self table for iterator member (may be another iterator!)
-- @self table self
function Randomizer:compute()
	math.randomseed( os.clock() )
	-- trigger some random before to delegate results, random fails on some OS.
	math.random(); math.random(); math.random()

	local typeAsString = self.type

	-- isIteratorType support either string or table
	if typeAsString ~= nil and typeAsString == hoi3.TYPE_TABLE then
		return self:computeIterator()
	elseif typeAsString == hoi3.TYPE_FUNCTION or
		typeAsString == hoi3.TYPE_THREAD or
		typeAsString == hoi3.TYPE_USERDATA then
		-- Throw an error, we don't handle such special datatypes !
		error("Failed to randomize special datatype. function, thread and userdata type are not handled")   
	elseif typeAsString == hoi3.TYPE_NIL then
		return nil
	elseif typeAsString == hoi3.TYPE_STRING then
		-- return a human readable string of 10 caracters
		return self:computeString()
	elseif typeAsString == hoi3.TYPE_NUMBER then
		return self:computeNumber()
	elseif typeAsString == hoi3.TYPE_BOOLEAN then
		return self:computeBoolean()
	else
		require('hoi3.api')
		
		-- try to delegate to object reference
		if hoi3.api[typeAsString] and 
			type(hoi3.api[typeAsString].random) == hoi3.TYPE_FUNCTION then
			return hoi3.api[typeAsString].random(self)
		end
	end
	
	hoi3.throwNoRandomizerSupport(typeAsString)
end

---
--
-- self.len = 10
-- self.chr = {{"A","B"},{"1"},...}
--  alternate one character picked from 1st character list, then one character 
-- 
-- @self table self (optional)
-- @return string
function Randomizer:computeString()
	local str = ""
	
	self = self or {}
	self.len = self.len or 10
	if self.chr == nil then
		self.chr = {}
		self.chr[0] = {"b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","y","z","_"}
		self.chr[1] = {"a","e","i","o","u"}  
	end
	
	assert(#self.chr > 0, "Empty character list specified.")
	
	while string.len(str) < self.len do
		for i = 0, #self.chr do
			assert(type(self.chr[i]) == TYPE_TABLE, "Expected character list for slot #"..i.." got "..type(self.chr[i])..".")
			assert(#self.chr[i]>0,"Empty character list #"..i.." specified.")
			
			str = str .. self.chr[i][ math.random(#self.chr[i])]
			if string.len(str) >= self.len then break end
		end
	end
	
	dtools.debug("Randomized string content : "..str)
	return str	
end

---
--
-- self.perc = 50
-- 
-- @self table self (optional)
-- @return string
Randomizer.computeBoolean = function(self)
	self = self or {}
	self.perc = self.perc or 50
	
	local bool = math.random(100) < self.perc	
	dtools.debug("Randomized boolean content : "..tostring(bool))
	return bool
end

---
-- self.min = 0
-- self.max = 100
-- self.float = false
-- 
-- @self table self (optional)
-- @return string
Randomizer.computeNumber = function(self)
	self = self or {}
	self.float = self.float or false
	self.min = self.min or 0
	self.max = self.max or 100
	
	assert(self.min <= self.max, "Number min value > max value, can't compute randomized value")
	
	if self.float ~= true then
		return math.random(self.min, self.max)
	else
		local span = self.max - self.min
		return self.min + (math.random() * self.max)
	end	
end

Randomizer.computeIterator = function(self)
	self = self or {}
	self.sizemin = self.sizemin or 1
	self.sizemax = self.sizemax or 5
	self.subtype = self.subtype or hoi3.TYPE_NUMBER
	
	assert(self.sizemin <= self.sizemax, "Iterator min > max size, can't compute randomized value")
	
	if(type(self.subtype)==hoi3.TYPE_STRING) then
		self.subtype = Randomizer:new(self.subtype)
	end
	
	local value
	local t = {}
	local size = math.random(self.sizemin, self.sizemax)
	local r = self.subtype
	for i = 0, size do
		table.insert(t,r:compute())
	end
	
	return t
end