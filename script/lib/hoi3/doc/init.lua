module("hoi3.doc", package.seeall)

local CRLF = "\n"

require("hoi3.api")

function genWikiToc(filename)
local file,err,str

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
	
	function file:title(str, level)
		local level = level or 1
		local tag = string.rep("=",level)
		
		self:write(tag .. str .. tag .. CRLF)
	end
	
	local t = {}
	
	local function addToCategory(cat, className, class)
		t[cat] = t[cat] or {}
		t[cat][className] = class   
	end  
	
	for className, class in dtools.table.orderedPairs(hoi3.api.getCompleteApi()) do
		if hoi3.api[className] ~= nil then
			addToCategory("01- API classes",className, class)
		else
			addToCategory("02- Non-API classes",className, class)
		end
		
		if middleclass.subclassOf(hoi3.MultitonObject, class) then
			addToCategory("03- Named object classes",className, class)
		end
		
		if className:find("DataBase") then
			addToCategory("04- DataBase classes",className, class)
		end
		
		if middleclass.subclassOf(hoi3.api.CCommand, class) then
			addToCategory("05- Command classes",className, class)
		end
		
		if middleclass.subclassOf(hoi3.api.CAgent, class) then
			addToCategory("06- Minister classes",className, class)
		end
		
		if middleclass.subclassOf(hoi3.api.CAction, class) then
			addToCategory("07- Action classes",className, class)
		end
		
		if className == "CString" or 
			className == "CDate" or
			className == "CFixedPoint" or
			className == "CArrayFix" or
			className == "CArrayFloat" then
			addToCategory("08- Primitives classes",className, class)
		end
		
		if class.getConstructorSignature ~= nil and 
			class:getConstructorSignature() ~= nil then
			addToCategory("09- With public constructor",className, class)
		end
		
		if class.getConstants ~= nil and 
			class:getConstants() ~= nil and
			hoi3.countTableMember(class:getConstants()) > 0 then
			addToCategory("10- With static constants",className, class)
		end
	end
	
	for group, v in dtools.table.orderedPairs(t) do
		file:write("  * [LUAClassReference "..group.."]"..CRLF)
		for className, class in dtools.table.orderedPairs(v) do
			file:write("    * [LUAClassReference#"..className.." "..className.."]"..CRLF)
		end
	end
	
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

function genWikiDoc(filename)
	local file,err,str

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
	
	function file:title(str, level)
		local level = level or 1
		local tag = string.rep("=",level)
		
		self:write(tag .. str .. tag .. CRLF)
	end
	
	function file:htab(...)
		local str = "<tr>"
		for i,v in ipairs({...}) do
			str = str .. "<th>" .. tostring(v).."</th>"
		end
		str = str .. "</tr>"
		self:write(str .. CRLF)
	end
	
	function file:tab(...)
		local str = "<tr>"
		for i,v in ipairs({...}) do
			str = str .. "<td>" .. tostring(v).."</td>"
		end
		str = str .. "</tr>"
		self:write(str .. CRLF)
	end

 	file:write("#summary LUA Class Reference"..CRLF)
 	file:write("#labels Featured,Phase-Implementation"..CRLF)
  	file:write("#sidebar LUAClassReferenceSideBar"..CRLF)
 	file:write(CRLF..CRLF)
 	
 	local head = "Hearts of Iron III - LUA class reference"
 	local linkToHead = "<font size=\"2\">[#"..head:gsub(" ","_").." Back To Top]</font>"
	file:title(head)
	
	for className, class in dtools.table.orderedPairs(hoi3.api.getCompleteApi()) do
		file:write("-----".. CRLF)
		file:title(className,2)
				
		-- Implements
		if class.superclass ~= nil then
			local sup = class
			str = ""
			while sup.superclass ~= nil do
				sup = sup.superclass
				local _,_,name = string.find(sup.name,".*%.(%w+)")
				if name == nil then name = sup.name end
				
				if str == "" then
					str = "Implements "
				else
					str = str .. ", "				
				end 
				
				if hoi3.api[name] == nil then
					str = str .. "<font color=\"grey\"><em>"
				end
				str = str .. "[#"..name.." "..name.."]"
				if hoi3.api[name] == nil then
					str = str .. "</em></font>"
				end
			end
			file:write(str.. CRLF.. CRLF)
		end
		
		-- Information regarding API or base object status
		if nil == hoi3.api[className] then
			file:write("This object does not exist in HOI3, and is only used in hoi3 fake api.".. CRLF.. CRLF)
		end
		
		file:title("Constructor summary",4)
		if class.getConstructorSignature ~= nil and class:getConstructorSignature() ~= nil then
			local signature = class:getConstructorSignature()
			str = className.."("
			for i,v in ipairs(signature) do
				str = str .. v
				if i ~= #signature then
					str = str .. ", "
				end
			end
			str = str ..")"
			file:write("<code language=\"lua\">".. str.. "</code>" .. CRLF)
		else
			file:write("There is no known constructor for this object.".. CRLF)
		end
		
		if class.getApiFunctions then
			local functions = class:getApiFunctions(true)
			if hoi3.countTableMember(functions) > 0 then 
				file:title("Method summary",4)
				file:write("<table width=\"100%\" border=\"1\">"..CRLF)
				file:htab("Type","Method","Since")
				for methodName, method in dtools.table.orderedPairs(functions) do	
					if(method.myclass ~= class) then
						-- Inherited
						file:tab(
							"<font face=\"monospace\" color=\"grey\"><i>"..method:returnTypeAsString(true):gsub("<","`<`").."</i></font>",
							"<font face=\"monospace\" color=\"grey\"><i>"..method:signatureAsString(true):gsub("<","`<`").."</i></font>",
							""
						)
					else
						file:tab(
							"<font face=\"monospace\">"..method:returnTypeAsString(true):gsub("<","`<`").."</font>",
							"<font face=\"monospace\">"..method:signatureAsString(true):gsub("<","`<`").."</font>",
							""
						)
					end
				end
				file:write("</table>"..CRLF)
			end
		end
		
		if class.getConstants then
			local constants = class:getConstants()
			if hoi3.countTableMember(constants) > 0 then 
				file:title("Constant summary",4)
				file:write("<table width=\"100%\" border=\"1\">"..CRLF)
				file:htab("Constant","Value","Since")
				for constantName, constant in dtools.table.orderedPairs(constants) do	
					-- We escape wiki since _MYCONSTANT_ would result in italic MYCONSTANT !
					file:tab(
						"<font face=\"monospace\">`"..className.."."..constantName.."`</font>",
						"<font face=\"monospace\">"..constant.."</font>",
						""
					)
				end
				file:write("</table>"..CRLF)
			end
		end
		file:write(linkToHead..CRLF..CRLF)
	end

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
	

