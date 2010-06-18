require('hoi3.api.CCommand')

CConstructUnitCommandObject = CCommandObject:subclass('hoi3.CConstructUnitCommandObject')

---
-- @since 1.3
-- @return CConstructUnitCommandObject 
function CConstructUnitCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  actor
-- @param table<CSubUnitDefinition>  orderlist
-- @param number capitalProvId
-- @param number quantity
-- @param bool bBuildReserveAtPeace
-- @param CCountryTag  countryTag
-- @param CID cID
-- @return CConstructUnitCommandObject
function CConstructUnitCommand(actor, orderlist, capitalProvId, quantity, bBuildReserveAtPeace, countryTag, cId)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, orderlist, 'table')
	Hoi3Object.assertParameterType(3, capitalProvId, 'number')
	Hoi3Object.assertParameterType(4, quantity, 'number')
	Hoi3Object.assertParameterType(5, bBuildReserveAtPeace, 'boolean')
	Hoi3Object.assertParameterType(6, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(7, cID, 'CID')

	Hoi3Object.throwNotYetImplemented()
end