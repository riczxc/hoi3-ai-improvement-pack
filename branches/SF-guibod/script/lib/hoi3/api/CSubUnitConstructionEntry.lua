require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitConstructionEntry = hoi3.Hoi3Object:subclass('hoi3.api.CSubUnitConstructionEntry')

--[[
	FIXME: middleclass notation makes underscored properties private.
	There may be problem accessing _vWeight or _pCategory !
]]
function CSubUnitConstructionEntry:initialize(nPrio, pUnit)
  hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, nPrio, hoi3.TYPE_NUMBER)
  hoi3.assertParameterType(2, pUnit, 'CSubUnitDefinition')
  
  --number
  self.nPrio	= nil
  --CSubUnitDefinition
  self.pUnit	= nil
end