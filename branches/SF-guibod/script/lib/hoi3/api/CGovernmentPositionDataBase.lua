require('hoi3')

module("hoi3.api", package.seeall)

CGovernmentPositionDataBase = hoi3.AbstractObject:subclass('hoi3.api.CGovernmentPositionDataBase')

---
-- @since 2.0
-- @return number
hoi3.fs(CGovernmentPositionDataBase, 'GetGovernmentPositionByIndex', 'CGovernmentPosition', hoi3.TYPE_NUMBER)

function CGovernmentPositionDataBase.GetGovernmentPositionByIndexImpl(index)	
	return hoi3.fromIndexTableMember(CGovernmentPosition:getInstances(), index)
end