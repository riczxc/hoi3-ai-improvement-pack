require('hoi3.api.CCommand')

CConstructUnitCommand = CCommand:subclass('hoi3.CConstructUnitCommand')

---
-- @since 1.3
-- @param CCountryTag  actor
-- @param table<CSubUnitDefinition>  orderlist
-- @param number capitalProvId
-- @param number quantity
-- @param bool bBuildReserveAtPeace
-- @param CCountryTag  countryTag
-- @param CID cID
-- @return CConstructUnitCommand
function CConstructUnitCommand:initialize(actor, orderlist, capitalProvId, quantity, bBuildReserveAtPeace, countryTag, cId)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, orderlist, 'table')
	Hoi3Object.assertParameterType(3, capitalProvId, 'number')
	Hoi3Object.assertParameterType(4, quantity, 'number')
	Hoi3Object.assertParameterType(5, bBuildReserveAtPeace, 'boolean')
	Hoi3Object.assertParameterType(6, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(7, cID, 'CID')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CConstructUnitCommand 
function CConstructUnitCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end
