module("hoi3.doc", package.seeall)

local CRLF = "\n"

require("hoi3.api")


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
 	
	file:title("Hearts of Iron III - LUA class reference")
	
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
		
		if class.constructorSignature ~= nil then
			file:title("Constructor summary",4)
			str = className.."("
			for i,v in ipairs(class.constructorSignature) do
				str = str .. v
				if i ~= #constructorSignature then
					str = str .. ", "
				end
			end
			str = str ..")"
			file:write(str.. CRLF)
		end
		
		if class.getApiFunctions then
			local functions = class:getApiFunctions()
			if hoi3.countTableMember(functions) > 0 then 
				file:title("Method summary",4)
				file:write("<table width=\"100%\">"..CRLF)
				file:htab("Type","Method","Since")
				for methodName, method in dtools.table.orderedPairs(functions) do	
					file:tab(
						"<font face=\"monospace\">"..method:returnTypeAsString(true):gsub("<","`<`").."</font>",
						"<font face=\"monospace\">"..method:signatureAsString(true):gsub("<","`<`").."</font>",
						""
					)
				end
				file:write("</table>"..CRLF)
			end
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
	

