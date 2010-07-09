require('hoi3')

module("hoi3.api", package.seeall)

CGovernmentPositionDataBase = hoi3.AbstractObject:subclass('hoi3.api.CGovernmentPositionDataBase')

---
-- @since 2.0
-- @return number
hoi3.fs(CGovernmentPositionDataBase, 'GetGovernmentPosition', 'CGovernmentPosition', hoi3.TYPE_STRING)

function CGovernmentPositionDataBase.GetGovernmentPositionImpl(key)	
	return CGovernmentPosition.getInstance(key)
end

---
-- @since 2.0
-- @return number
hoi3.fs(CGovernmentPositionDataBase, 'GetGovernmentPositionByIndex', 'CGovernmentPosition', hoi3.TYPE_NUMBER)

function CGovernmentPositionDataBase.GetGovernmentPositionByIndexImpl(index)	
	return hoi3.fromIndexTableMember(CGovernmentPosition:getInstances(), index)
end

---
-- @since 2.0
-- @return iterator<CGovernmentPosition>
hoi3.fs(CGovernmentPositionDataBase, 'GetGovernmentPositionList', 'iterator<CGovernmentPosition>')

function CGovernmentPositionDataBase.GetGovernmentPositionListImpl()	
	return CGovernmentPosition:getInstances()
end

---
-- @since 1.3
-- @return number
hoi3.fs(CGovernmentPositionDataBase, 'GetNumberOfGovernmentPositions', hoi3.TYPE_NUMBER)

function CGovernmentPositionDataBase.GetNumberOfGovernmentPositionsImpl()	
	return hoi3.countIteratorMember(CGovernmentPositionDataBase.GetGovernmentPositionList())
end