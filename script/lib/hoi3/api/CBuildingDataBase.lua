require('hoi3')

module("hoi3.api", package.seeall)

CBuildingDataBase = hoi3.AbstractObject:subclass('hoi3.CBuildingDataBase')

---
-- @since 1.3
-- @param string name
-- @return CBuilding 
function CBuildingDataBase.GetBuilding(name)
	hoi3.assertParameterType(1, name, hoi3.TYPE_STRING)
	
	return CBuildingDataBase.loadResultOrImplOrRandom(
		CBuildingDataBase,
		'CBuilding',
		'GetBuilding',
		name
	)
end

---
-- @since 1.3
-- @param number index
-- @return CBuilding 
function CBuildingDataBase.GetBuildingFromIndex(index)
	hoi3.assertParameterType(1, index, hoi3.TYPE_NUMBER)
	
	return CBuildingDataBase.loadResultOrImplOrRandom(
		CBuildingDataBase,
		'CBuilding',
		'GetBuildingFromIndex',
		index
	)
end

---
--- Implementations
---
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