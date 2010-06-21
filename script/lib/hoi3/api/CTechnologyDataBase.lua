require('hoi3.Hoi3Object')

CTechnologyDataBaseObject = Hoi3Object:subclass('hoi3.CTechnologyDataBaseObject')

---
-- @since 1.3
-- @static
-- @param string folderName
-- @return number 
function CTechnologyDataBaseObject.GetFolderIndex(folderName)
	Hoi3Object.assertParameterType(1, folderName, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnologyCategory>
function CTechnologyDataBaseObject.GetCategories()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @static
-- @return table<CTechnology>
function CTechnologyDataBaseObject.GetTechnologies()
	Hoi3Object.throwNotYetImplemented()
end

-- CTechnologyDataBase has static methods and properties
-- we need to declare a CTechnologyDataBase table 
CTechnologyDataBase = CTechnologyDataBaseObject