require('hoi3')

module("hoi3.api", package.seeall)

CResearchBonus = hoi3.Hoi3Object:subclass('hoi3.api.CResearchBonus')
CResearchBonus.properties = {
	_vWeight	= { "read only", 'CFixedPoint' },
	_pCategory 	= { "read only", 'CTechnologyCategory' }
}

function CResearchBonus:initialize(vWeight, pCategory)
  	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, vWeight, 'CFixedPoint')
  	hoi3.assertParameterType(2, pCategory, 'CTechnologyCategory')
  
  	--CFixedPoint
  	self._vWeight	= vWeight
  	--CTechnologyCategory
  	self._pCategory	= pCategory
end