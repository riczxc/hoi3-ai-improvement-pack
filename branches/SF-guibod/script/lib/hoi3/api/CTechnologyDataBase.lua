require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyDataBase = hoi3.AbstractObject:subclass('hoi3.api.CTechnologyDataBase')

---
-- @since 1.3
-- @static
-- @param string folderName
-- @return number 
hoi3.f(CTechnologyDataBase, 'GetFolderIndex', hoi3.TYPE_NUMBER, hoi3.TYPE_STRING)

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
-- @return iterator<CTechnologyCategory>
hoi3.f(CTechnologyDataBase, 'GetCategories', 'iterator<CTechnologyCategory>')

function CSubUnitDataBase.GetCategories()
	return CTechnologyCategory:getInstances()
end

---
-- @since 2.0
-- @static
-- @return CTechnology
hoi3.fs(CTechnologyDataBase, 'GetTechnology', 'CTechnology')

function CSubUnitDataBase.GetTechnology(key)
	return CTechnology:getInstance(key)
end