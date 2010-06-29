require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyDataBase = hoi3.AbstractObject:subclass('hoi3.CTechnologyDataBase')

---
-- @since 1.3
-- @static
-- @param string folderName
-- @return number 
hoi3.f(CTechnologyDataBase, 'GetFolderIndex', false, hoi3.TYPE_NUMBER, hoi3.TYPE_STRING)

--[[
local techFolder = tech:GetFolder()
	local techFolderName = tech:GetFolder():GetKey()
	local folderModifiers = minister:GetFolderModifers()

	if techFolder == "land_doctrine_folder" then
		local landModifier = folderModifiers:GetAt( CTechnologyDataBase.GetFolderIndex("infantry_folder") )
]]

---
-- @since 1.3
-- @static
-- @return table<CTechnologyCategory>
hoi3.f(CTechnologyDataBase, 'GetCategories', false, 'table<CTechnologyCategory>')

function CSubUnitDataBase.GetCategories()
	return CTechnologyCategory:getInstances()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnology>
hoi3.f(CTechnologyDataBase, 'GetTechnologies', false, 'table<CTechnology>')

function CSubUnitDataBase.GetTechnologies()
	return CTechnology:getInstances()
end