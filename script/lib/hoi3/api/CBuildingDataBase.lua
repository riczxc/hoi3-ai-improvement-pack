require('hoi3')

module("hoi3.api", package.seeall)

CBuildingDataBase = hoi3.AbstractObject:subclass('hoi3.CBuildingDataBase')

---
-- @since 1.3
-- @static
-- @param string name
-- @return CBuilding 
hoi3.f(CBuildingDataBase, 'GetBuilding', true, 'CBuilding', hoi3.TYPE_STRING)

function CBuildingDataBase.GetBuildingImpl(name)
	require('hoi3.conf')
	
	local db = hoi3.conf.buildingDatabase()
	for k, v in pairs(db) do
		if v:GetName() == name then
			return v
		end
	end
	hoi3.throwDataNotFound()
end

---
-- @since 1.3
-- @param number index
-- @return CBuilding 
hoi3.f(CBuildingDataBase, 'GetBuildingFromIndex', false, 'CBuilding', hoi3.TYPE_NUMBER)

---
--- Implementations
---


function CBuildingDataBase.GetBuildingFromIndexImpl(index)
	require('hoi3.conf')
	
	local db = hoi3.conf.buildingDatabase()
	for k, v in pairs(db) do
		if v:GetIndex() == index then
			return v
		end
	end
	hoi3.throwDataNotFound()
end