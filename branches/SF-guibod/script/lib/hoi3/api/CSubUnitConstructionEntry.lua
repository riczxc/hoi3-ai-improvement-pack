require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CSubUnitConstructionEntry = Hoi3Object:subclass('hoi3.CSubUnitConstructionEntry')

--[[
	FIXME: middleclass notation makes underscored properties private.
	There may be problem accessing _vWeight or _pCategory !
]]
function CSubUnitConstructionEntry:initialize(nPrio, pUnit)
  hoi3.assertParameterType(1, nPrio, 'number')
  hoi3.assertParameterType(2, pUnit, 'CSubUnitDefinition')
  
  --number
  self.nPrio	= nil
  --CSubUnitDefinition
  self.pUnit	= nil
end