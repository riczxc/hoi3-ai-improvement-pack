require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

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
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, orderlist, 'table')
	hoi3.assertParameterType(3, capitalProvId, 'number')
	hoi3.assertParameterType(4, quantity, 'number')
	hoi3.assertParameterType(5, bBuildReserveAtPeace, 'boolean')
	hoi3.assertParameterType(6, countryTag, 'CCountryTag')
	hoi3.assertParameterType(7, cID, 'CID')

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CConstructUnitCommand 
function CConstructUnitCommand:Clone()
	hoi3.throwNotYetImplemented()
end
