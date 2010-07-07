require('hoi3.Hoi3Object')

module( "hoi3", package.seeall)

MultitonObject = Hoi3Object:subclass('hoi3.MultitonObject')

MultitonObject.instances = {}

function MultitonObject:_getUnid()
	return self._unid
end

function MultitonObject:_argsToUnid(...)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:_argsToUnid instead of class._argsToUnid")
	
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
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:new instead of class.new")
	
	local key = self:_argsToUnid(...)
	-- Force table creation
  	MultitonObject.instances[self.name] = MultitonObject.instances[self.name] or {}
  	
  	if nil == MultitonObject.instances[self.name][key] then
  		local instance = setmetatable({ class = self }, self.__classDict)
	  	instance:initialize(...)
	  	instance._unid = key
	  	MultitonObject.instances[self.name][key] = instance 
  	end
  	
  	return MultitonObject.instances[self.name][key]
end

function MultitonObject:hasInstance(...)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:hasInstance instead of class.hasInstance")
	
	local key = self:_argsToUnid(...)
	return self:_hasInstance(key)
end

function MultitonObject:_hasInstance(key)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:_hasInstance instead of class._hasInstance")
	
	return MultitonObject.instances[self.name] ~= nil and
		MultitonObject.instances[self.name][key] ~= nil
end 

function MultitonObject:getInstance(...)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:getInstance instead of class.getInstance")
	
	for k,v in pairs(self) do
		print(tostring(k).." ("..type(k)..") = "..tostring(v).." ("..type(v)..")")
	end
	local key = self:_argsToUnid(...)
	return self:_getInstance(key)
end 

function MultitonObject:_getInstance(key)
	local _classes = middleclass.getClasses()
	assert(_classes[self]~=nil, "Use class:_getInstance instead of class._getInstance")
	
	if self:_hasInstance(key) then
		-- the object may need rehydratation
		-- if is deserialized (no metatable support in dumps and risk of infinite loop)
		--setmetatable(MultitonObject.instances[self.name][key], self.__classDict)
		
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

--// The Save Function
-- used by serializeInstances
local function exportstring( s )
	s = string.format( "%q",s )
	-- to replace
	s = string.gsub( s,"\\\n","\\n" )
	s = string.gsub( s,"\r","\\r" )
	s = string.gsub( s,string.char(26),"\"..string.char(26)..\"" )
	return s
end


function MultitonObject.serializeInstances(filename)
	local charS,charE = "	","\n"
	local file,err

	--
	-- File management
	--
	-- create a pseudo file that writes to a string and return the string
	if not filename then
		file =  { write = function( self,newstr ) self.str = self.str..newstr end, str = "" }
		charS,charE = "",""
		-- write table to tmpfile
	elseif filename == true or filename == 1 then
		charS,charE,file = "","",io.tmpfile()
		-- write table to file
			-- use io.open here rather than io.output, since in windows when clicking on a file opened with io.output will create an error
	else
		file,err = io.open( filename, "w" )
		if err then return _,err end
	end
	
	--
	-- Table management
	-- 
	-- initiate variables for save procedure
	local tables,lookup = { MultitonObject.instances },{ [MultitonObject.instances] = 1 }
	
	file:write( "return {"..charE )
	for idx,t in ipairs( tables ) do
		if filename and filename ~= true and filename ~= 1 then
			file:write( "-- Table: {"..idx.."}"..charE )
		end
		file:write( "{"..charE )
		local thandled = {}
		for i,v in ipairs( t ) do
			thandled[i] = true
			-- escape functions and userdata
			if type( v ) ~= "userdata" then
				-- only handle value
				if type( v ) == "table" then
					if not lookup[v] then
						table.insert( tables, v )
						lookup[v] = #tables
					end
					file:write( charS.."{"..lookup[v].."},"..charE )
				elseif type( v ) == "function" then
				-- IGNORE Functions
					-- file:write( charS.."loadstring("..exportstring(string.dump( v )).."),"..charE )
					file:write( charS.."nil,"..charE )
				else
					local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
					file:write(  charS..value..","..charE )
				end
			end
		end
		for i,v in pairs( t ) do
			-- escape functions and userdata
			if (not thandled[i]) and type( v ) ~= "userdata" then
				-- handle index
				if type( i ) == "table" and not middleclass.instanceOf(hoi3.FunctionObject,i) then
					if not lookup[i] then
						table.insert( tables,i )
						lookup[i] = #tables
					end
					file:write( charS.."[{"..lookup[i].."}]=" )
				else
					local index = ( type( i ) == "string" and "["..exportstring( i ).."]" ) or string.format( "[%d]",i )
					file:write( charS..index.."=" )
				end
				-- handle value
				if type( v ) == "table" then
					if not lookup[v] then
						table.insert( tables,v )
						lookup[v] = #tables
					end
					
					if not middleclass.instanceOf(hoi3.FunctionObject,v)  then
						file:write( "{"..lookup[v].."},"..charE )
					else
						file:write( "nil,"..charE )
					end
				elseif type( v ) == "function" then
					-- IGNORE Functions
					--	file:write( "loadstring("..exportstring(string.dump( v )).."),"..charE )
					file:write( "nil,"..charE )
				else
					local value =  ( type( v ) == "string" and exportstring( v ) ) or tostring( v )
					file:write( value..","..charE )
				end
			end
		end
		file:write( "},"..charE )
	end
	file:write( "}" )
	-- Return Values
	-- return stringtable from string
	if not filename then
		-- set marker for stringtable
		return file.str.."--|"
	-- return stringttable from file
	elseif filename == true or filename == 1 then
		file:seek ( "set" )
		-- no need to close file, it gets closed and removed automatically
		-- set marker for stringtable
		return file:read( "*a" ).."--|"
	-- close file and return 1
	else
		file:close()
		return 1
	end
end

local function recursiveRehydrator(table, level)
	level = level or 1
	if type(table) ~= hoi3.TYPE_TABLE then 
		return table 
	end
	
	if table.____rehydrating == true then
		return table
	end
	
	table.____rehydrating = true
	local prefix = string.rep("  ",level)

	for k, v in pairs(table) do		
		--[[
		if type(v) == hoi3.TYPE_TABLE and
			not middleclass.instanceOf(hoi3.Object,v) and
			v.class ~= nil and 
			v.class.__classDict ~= nil then
			print(prefix.." rehydrated !") 
			setmetatable(v, v.class.__classDict)
		end
		]]
		
		table[k] = recursiveRehydrator(v, level + 1)
	end
	table.____rehydrating = nil
	return table
end 

--// The Load Function
function MultitonObject.deserializeInstances( sfile )
	-- catch marker for stringtable
	if string.sub( sfile,-3,-1 ) == "--|" then
		tables,err = loadstring( sfile )
	else
		tables,err = loadfile( sfile )
	end
	if err then return _,err
	end
	tables = tables()
	for idx = 1,#tables do
		local tolinkv,tolinki = {},{}
		for i,v in pairs( tables[idx] ) do
			if type( v ) == "table" and tables[v[1]] then
				table.insert( tolinkv,{ i,tables[v[1]] } )
			end
			if type( i ) == "table" and tables[i[1]] then
				table.insert( tolinki,{ i,tables[i[1]] } )
			end
		end
		-- link values, first due to possible changes of indices
		for _,v in ipairs( tolinkv ) do
			tables[idx][v[1]] = v[2]
		end
		-- link indices
		for _,v in ipairs( tolinki ) do
			tables[idx][v[2]],tables[idx][v[1]] =  tables[idx][v[1]],nil
		end
	end
		
	MultitonObject.instances = recursiveRehydrator(tables[1])
end

