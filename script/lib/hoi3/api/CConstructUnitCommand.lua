require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructUnitCommand = CCommand:subclass('hoi3.CConstructUnitCommand')

---
-- @since 1.3
-- @param CCountryTag  tag
-- @param iterator<CSubUnitDefinition>  order
-- @param number capital
-- @param number quantity
-- @param bool isReserve
-- @param CCountryTag  tag2
-- @param CID cid
-- @return CConstructUnitCommand
function CConstructUnitCommand:initialize(tag, list, capital, quantity, isReserve, tag2, cid)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, list, 'SubUnitList')
	hoi3.assertParameterType(3, capital, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(4, quantity, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(5, isReserve, hoi3.TYPE_BOOLEAN)
	hoi3.assertParameterType(6, tag2, 'CCountryTag')
	hoi3.assertParameterType(7, cid, 'CID')

	self.tag = tag
	self.list = list
	self.capital = capital
	self.quantity = quantity
	self.isReserve = isReserve
	self.tag2 = tag2
	self.cid = cid
end

function CConstructUnitCommand:desc()
	local str = ""
	
	if self.isReserve then str = "reserve " end
	
	for k, v in pairs(self.list.list) do
		str = str .. tostring(v:GetKey()) .. "-"
	end
	
	return "Issued construction of "..tostring(self.quantity).." "..str..
		" using province #"..tostring(self.capital).." and "..tostring(cid)..
		" cid by "..tostring(self.tag).." (for "..tostring(self.tag2)..")."
		
end