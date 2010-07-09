require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitConstructionEntry = hoi3.Hoi3Object:subclass('hoi3.api.CSubUnitConstructionEntry')

-- Constructor signature
-- information only, that will be used by documentation generator.
CSubUnitConstructionEntry.constructorSignature = {'CSubUnitDefinition', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER}
CSubUnitConstructionEntry.properties = {
	nPrio 		= { "read only", hoi3.TYPE_NUMBER },
	nSequence 	= { "read only", hoi3.TYPE_NUMBER },
	pUnit 		= { "read only", 'CSubUnitDefinition' }
}

function CSubUnitConstructionEntry:initialize(pUnit, nPrio, nSequence)
  hoi3.assertNonStatic(self)
	
  hoi3.assertParameterType(1, pUnit, 'CSubUnitDefinition')
  hoi3.assertParameterType(2, nPrio, hoi3.TYPE_NUMBER)
  hoi3.assertParameterType(3, nSequence, hoi3.TYPE_NUMBER)

  self.nPrio	= nPrio
  self.pUnit	= pUnit
  self.nSequence = nSequence
end