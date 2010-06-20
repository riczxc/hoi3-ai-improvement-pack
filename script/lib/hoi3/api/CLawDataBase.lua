require('hoi3.Hoi3Object')

CLawDataBaseObject = Hoi3Object:subclass('hoi3.CLawDataBaseObject')

---
-- @since 1.3
-- @return table<CLawGroup>
function CLawDataBaseObject.GetGroups()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLawGroup 
function CLawDataBaseObject.GetLawGroup(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLaw 
function CLawDataBaseObject.CLaw(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CLaw>
function CLawDataBaseObject.GetLawList()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBaseObject.GetNumberOfLawGroups()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBaseObject.GetNumberOfLaws()	
	Hoi3Object.throwNotYetImplemented()
end

-- CLawDataBase has static methods and properties
-- we need to declare a CLawDataBase table 
CLawDataBase = CLawDataBaseObject