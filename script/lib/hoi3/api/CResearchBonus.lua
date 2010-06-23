require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CResearchBonus = Hoi3Object:subclass('hoi3.CResearchBonus')

--[[
	FIXME: middleclass notation makes underscored properties private.
	There may be problem accessing _vWeight or _pCategory !
]]
function CResearchBonus:initialize(vWeight, pCategory)
  hoi3.assertParameterType(1, vWeight, 'CFixedPoint')
  hoi3.assertParameterType(2, pCategory, 'CTechnologyCategory')
  
  --CFixedPoint
  self._vWeight	= nil
  --CTechnologyCategory
  self._pCategory	= nil
end