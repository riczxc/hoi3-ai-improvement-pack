require('hoi3.AbstractObject')

CTechnologyDataBase = AbstractObject:subclass('hoi3.CTechnologyDataBase')

---
-- @since 1.3
-- @static
-- @param string folderName
-- @return number 
function CTechnologyDataBase.GetFolderIndex(folderName)
	Hoi3Object.assertParameterType(1, folderName, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnologyCategory>
function CTechnologyDataBase.GetCategories()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnology>
function CTechnologyDataBase.GetTechnologies()
	Hoi3Object.throwNotYetImplemented()
end