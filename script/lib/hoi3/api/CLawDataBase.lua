require('hoi3')

module("hoi3.api", package.seeall)

CLawDataBase = hoi3.AbstractObject:subclass('hoi3.CLawDataBase')

---
-- @since 1.3
-- @return iterator<CLawGroup>
hoi3.f(CLawDataBase, 'GetGroups', true, 'iterator<CLawGroup>')

function CLawDataBase.GetGroupsImpl()	
	return CLawGroup:getInstances()
end

---
-- @since 1.3
-- @param number index
-- @return CLawGroup 
hoi3.f(CLawDataBase, 'GetLawGroup', true, 'CLawGroup', hoi3.TYPE_NUMBER)

function CLawDataBase.GetLawGroupImpl(index)
	return fromIndexTableMember(CLawGroup:GetInstances(), index)
end

---
-- @since 1.3
-- @param number index
-- @return CLaw 
hoi3.f(CLawDataBase, 'GetLaw', true, 'CLaw', hoi3.TYPE_NUMBER)

function CLawDataBase.GetLawImpl(faction)
	return fromIndexTableMember(CLaw:GetInstances(), index)
end

---
-- @since 1.3
-- @return iterator<CLaw>
hoi3.f(CLawDataBase, 'GetLawList', true, 'iterator<CLaw>')

function CLawDataBase.GetLawListImpl()	
	return CLaw:getInstances()
end

---
-- @since 1.3
-- @return number
hoi3.f(CLawDataBase, 'GetNumberOfLawGroups', true, hoi3.TYPE_NUMBER)

function CLawDataBase.GetNumberOfLawGroupsImpl()	
	local _, s = CLawDataBase.GetGroups()
	return #s
end

---
-- @since 1.3
-- @return number
hoi3.f(CLawDataBase, 'GetNumberOfLaws', true, hoi3.TYPE_NUMBER)

function CLawDataBase.GetNumberOfLawsImpl()	
	local _, s = CLawDataBase.GetLawList()
	return #s
end

-- TODO add functions
-- GetLawIndexByName
-- GetLawGroupIndexByName
