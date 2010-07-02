require('hoi3')

module("hoi3.api", package.seeall)

CGovernmentPositionDataBase = hoi3.AbstractObject:subclass('hoi3.CGovernmentPositionDataBase')

---
-- @since 2.0
-- @return number
hoi3.f(CGovernmentPositionDataBase, 'GetGovernmentPositionByIndex', true, 'GovernmentPosition', hoi3.TYPE_NUMBER)

function CGovernmentPositionDataBase.GetGovernmentPositionByIndexImpl(index)	
	return hoi3.fromIndexTableMember(CGovernmentPosition:getInstances(), index)
end