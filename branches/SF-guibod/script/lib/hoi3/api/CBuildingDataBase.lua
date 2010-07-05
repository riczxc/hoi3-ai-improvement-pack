require('hoi3')

module("hoi3.api", package.seeall)

CBuildingDataBase = hoi3.AbstractObject:subclass('hoi3.CBuildingDataBase')

---
-- @since 1.3
-- @static
-- @param string name
-- @return CBuilding 
hoi3.fs(CBuildingDataBase, 'GetBuilding', 'CBuilding', hoi3.TYPE_STRING)

function CBuildingDataBase.GetBuildingImpl(key)
	return CBuilding:getInstance(key)
end

---
-- @since 1.3
-- @param number index
-- @return CBuilding 
hoi3.f(CBuildingDataBase, 'GetBuildingFromIndex', 'CBuilding', hoi3.TYPE_NUMBER)

function CBuildingDataBase.GetBuildingFromIndexImpl(index)
	return hoi3.fromIndexTableMember(CBuilding:getInstances(), index)
end