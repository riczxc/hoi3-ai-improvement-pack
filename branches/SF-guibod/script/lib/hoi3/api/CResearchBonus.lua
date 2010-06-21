require('hoi3.Hoi3Object')

CResearchBonusObject = Hoi3Object:subclass('hoi3.CResearchBonus')

--[[
	FIXME: middleclass notation makes underscored properties private.
	There may be problem accessing _vWeight or _pCategory !
]]
function CResearchBonusObject:initialize(vWeight, pCategory)
  --CFixedPoint
  self._vWeight	= nil
  --CTechnologyCategory
  self._pCategory	= nil
end