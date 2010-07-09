require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructBuildingCommand = CCommand:subclass('hoi3.api.CConstructBuildingCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CConstructBuildingCommand.constructorSignature = {'CCountryTag','CBuilding',hoi3.TYPE_NUMBER,hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CBuilding building
-- @param number provinceId
-- @param number quantity
-- @return CConstructBuildingCommand
function CConstructBuildingCommand:initialize(tag, building, province, quantity)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, building, 'CBuilding')
	hoi3.assertParameterType(3, province, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(4, quantity, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.building = building
	self.province = province
	self.quantity = quantity
end

function CConstructBuildingCommand:desc()
	return "Issued construction of "..tostring(self.quantity).." "..tostring(self.building:GetName())..
		" in province #"..tostring(self.province).." by "..tostring(self.tag).."."
end