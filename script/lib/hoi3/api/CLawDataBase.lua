require('hoi3')

module("hoi3.api", package.seeall)

CLawDataBase = hoi3.AbstractObject:subclass('hoi3.CLawDataBase')

---
-- @since 1.3
-- @return table<CLawGroup>
function CLawDataBase.GetGroups()	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLawGroup 
function CLawDataBase.GetLawGroup(index)
	hoi3.assertParameterType(1, index, hoi3.TYPE_NUMBER)
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number index
-- @return CLaw 
function CLawDataBase.CLaw(index)
	hoi3.assertParameterType(1, index, hoi3.TYPE_NUMBER)
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CLaw>
function CLawDataBase.GetLawList()	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBase.GetNumberOfLawGroups()	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLawDataBase.GetNumberOfLaws()	
	hoi3.throwNotYetImplemented()
end