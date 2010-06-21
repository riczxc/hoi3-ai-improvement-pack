require('hoi3.Hoi3Object')

CSubUnitConstructionEntryObject = Hoi3Object:subclass('hoi3.CSubUnitConstructionEntry')

--[[
	FIXME: middleclass notation makes underscored properties private.
	There may be problem accessing _vWeight or _pCategory !
]]
function CSubUnitConstructionEntryObject:initialize(nPrio, pUnit)
  Hoi3Object.assertParameterType(1, nPrio, 'number')
  Hoi3Object.assertParameterType(2, pUnit, 'CSubUnitDefinition')
  
  --number
  self.nPrio	= nil
  --CSubUnitDefinition
  self.pUnit	= nil
end