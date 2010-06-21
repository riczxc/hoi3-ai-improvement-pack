require('hoi3.AbstractObject')

CLawDataBase = AbstractObject:subclass('hoi3.CLawDataBase')

---
-- @since 1.3
-- @return table<CLawGroup>
function CLawDataBase.GetGroups()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLawGroup 
function CLawDataBase.GetLawGroup(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLaw 
function CLawDataBase.CLaw(index)
	Hoi3Object.assertParameterType(1, index, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CLaw>
function CLawDataBase.GetLawList()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBase.GetNumberOfLawGroups()	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBase.GetNumberOfLaws()	
	Hoi3Object.throwNotYetImplemented()
end