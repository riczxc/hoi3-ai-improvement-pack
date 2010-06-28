require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyDataBase = hoi3.AbstractObject:subclass('hoi3.CTechnologyDataBase')

---
-- @since 1.3
-- @static
-- @param string folderName
-- @return number 
function CTechnologyDataBase.GetFolderIndex(folderName)
	hoi3.assertParameterType(1, folderName, hoi3.TYPE_STRING)
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnologyCategory>
function CTechnologyDataBase.GetCategories()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnology>
function CTechnologyDataBase.GetTechnologies()
	hoi3.throwNotYetImplemented()
end