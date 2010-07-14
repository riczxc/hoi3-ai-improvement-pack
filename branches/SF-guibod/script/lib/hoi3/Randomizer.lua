require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

Randomizer = Hoi3Object:subclass("hoi3.Randomizer")

function Randomizer:initialize(typeAsString)
	hoi3.assert(typeAsString, "Bad randomizer type.")
	
	if Randomizer.isIteratorTypeString(typeAsString) then
		self.type = hoi3.TYPE_ITERATOR
		self.subtype = Randomizer(Randomizer.getIteratorTypeFromString(typeAsString))
	elseif Randomizer.isTableTypeString(typeAsString) then
		self.type = hoi3.TYPE_TABLE
		self.subtype = Randomizer(Randomizer.getTableTypeFromString(typeAsString))
	else
		self.type = typeAsString
	end
end

function Randomizer:__tostring()
	return self:getStringDescriptor()
end

function Randomizer:getStringDescriptor(bWiki)
	local bWiki = bWiki or false
	
	local t = self.type
	if bWiki and (hoi3.api[t] ~= nil or hoi3[t] ~= nil) and hoi3.api[t].__classDict ~= nil then
		t = "[#"..(self.type).." "..(self.type).."]"
	end
	
	if (self.type == hoi3.TYPE_TABLE or self.type == hoi3.TYPE_ITERATOR) and self.subtype ~= nil then
		local st = self.subtype:getStringDescriptor(bWiki)	
		return t.."<"..st..">"
	else
		return t
	end
end

Randomizer.isIteratorTypeString = function(str)
	return nil ~= Randomizer.getIteratorTypeFromString(str)
end

Randomizer.getIteratorTypeFromString = function(str)
	local found0, found1, capture1 = string.find(str, hoi3.TYPE_ITERATOR.."<(%a+)>")
	return capture1
end

Randomizer.isTableTypeString = function(str)
	return nil ~= Randomizer.getTableTypeFromString(str)
end

Randomizer.getTableTypeFromString = function(str)
	local found0, found1, capture1 = string.find(str, hoi3.TYPE_TABLE.."<(%a+)>")
	return capture1
end


Randomizer.curseed = 0
function Randomizer.seed()
	Randomizer.curseed = Randomizer.curseed + (os.clock()*1000)
	math.randomseed(Randomizer.curseed) 
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
	Randomizer.seed()
	-- trigger some random before to delegate results, random fails on some OS.
	math.random(); math.random(); math.random()

	local typeAsString = self.type

	-- isIteratorType support either string or table
	-- iterator is stored and handle as a table
	if typeAsString ~= nil and typeAsString == hoi3.TYPE_TABLE then
		return self:computeTable()
	elseif typeAsString ~= nil and typeAsString == hoi3.TYPE_ITERATOR then
		return self:computeIterator()
	elseif typeAsString == hoi3.TYPE_FUNCTION or
		typeAsString == hoi3.TYPE_THREAD or
		typeAsString == hoi3.TYPE_USERDATA then
		-- Throw an error, we don't handle such special datatypes !
		hoi3.error("Failed to randomize special datatype. function, thread and userdata type are not handled")   
	elseif typeAsString == hoi3.TYPE_NIL then
		return nil
	elseif typeAsString == hoi3.TYPE_STRING then
		-- return a human readable string of 10 caracters
		return self:computeString()
	elseif typeAsString == hoi3.TYPE_NUMBER then
		return self:computeNumber()
	elseif typeAsString == hoi3.TYPE_BOOLEAN then
		return self:computeBoolean()
	elseif typeAsString == hoi3.TYPE_VOID then
		return
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
	self.minlen = self.minlen or 10
	self.maxlen = self.maxlen or 10
	self.len = self.len or math.random(self.minlen,self.maxlen)
	if self.chr == nil then
		self.chr = {}
		self.chr[0] = {"b","c","d","f","g","h","j","k","l","m","n","p","r","s","t","v","w","x","y","z","_"}
		self.chr[1] = {"a","e","i","o","u"}  
	end
	
	hoi3.assert(#self.chr > 0, "Empty character list specified.")
	
	while string.len(str) < self.len do
		for i = 0, #self.chr do
			hoi3.assert(type(self.chr[i]) == TYPE_TABLE, "Expected character list for slot #"..i.." got "..type(self.chr[i])..".")
			hoi3.assert(#self.chr[i]>0,"Empty character list #"..i.." specified.")
			
			str = str .. self.chr[i][ math.random(#self.chr[i])]
			if string.len(str) >= self.len then break end
		end
	end
	
	--dtools.debug("Randomized string content : "..str)
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
	
	local bool = math.random(100) <= self.perc	
	--dtools.debug("Randomized boolean content : "..tostring(bool))
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
	
	hoi3.assert(self.min <= self.max, "Number min value > max value, can't compute randomized value")
	
	local number
	if self.float ~= true then
		number = math.random(self.min, self.max)
	else
		local span = self.max - self.min
		number = self.min + (math.random() * self.max)
	end	
	--dtools.debug("Randomized number content : "..tostring(number))
	return number
end

Randomizer.computeTable = function(self)
	self = self or {}
	self.sizemin = self.sizemin or 1
	self.sizemax = self.sizemax or 5
	self.subtype = self.subtype or hoi3.TYPE_NUMBER
	
	hoi3.assert(self.sizemin <= self.sizemax, "Iterator min > max size, can't compute randomized value")
	
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

--[[
An iterator in LUA (or a generator) is a mulitple result set composed
of a function (such as next()), an invariant table and a initial position (nil for 1st member)
In order not to implement multiple value result randomizer as well as save/load state mechanisms
only works with invariant state part, so it is a table.

HOI3 api iterator don't handle keys, this mean in lua term that the key IS also the value.

In conclusion, HOI3 api iterator randomizer is cloning the result of an table randomizer
swicthing numeric keys for the value itself.
]]
Randomizer.computeIterator = function(self)
	local it = {}
	for k, v in pairs(Randomizer.computeTable(self)) do
		it[v] = v
	end
	
	return it
end

---
-- Named randomizer instances
RAND_BOOL = Randomizer(hoi3.TYPE_BOOLEAN)

RAND_BOOL_IMPOSSIBLE = Randomizer(hoi3.TYPE_BOOLEAN)
RAND_BOOL_IMPOSSIBLE.perc = 0

RAND_BOOL_VUNLIKELY = Randomizer(hoi3.TYPE_BOOLEAN)
RAND_BOOL_VUNLIKELY.perc = 20

RAND_BOOL_UNLIKELY = Randomizer(hoi3.TYPE_BOOLEAN)
RAND_BOOL_UNLIKELY.perc = 40

RAND_BOOL_LIKELY = Randomizer(hoi3.TYPE_BOOLEAN)
RAND_BOOL_LIKELY.perc = 60

RAND_BOOL_VLIKELY = Randomizer(hoi3.TYPE_BOOLEAN)
RAND_BOOL_VLIKELY.perc = 80

RAND_PERC = Randomizer(hoi3.TYPE_NUMBER)
RAND_PERC.min = 0
RAND_PERC.max = 100

RAND_0TO10 = Randomizer(hoi3.TYPE_NUMBER)
RAND_0TO10.min = 0
RAND_0TO10.max = 10

RAND_STRING = Randomizer(hoi3.TYPE_STRING)