require('hoi3')

module("hoi3.api", package.seeall)

CGoodsValues = hoi3.Hoi3Object:subclass('hoi3.api.CGoodsValues')

-- Constructor signature
-- information only, that will be used by documentation generator.
CGoodsValues.constructorSignature = {}
CGoodsValues.properties = {
	vMoney 			= { "read/write", hoi3.TYPE_NUMBER },
	vFuel 			= { "read/write", hoi3.TYPE_NUMBER },
	vCrudeOil 		= { "read/write", hoi3.TYPE_NUMBER },
	vMetal 			= { "read/write", hoi3.TYPE_NUMBER },
	vEnergy 		= { "read/write", hoi3.TYPE_NUMBER },
	vSupplies 		= { "read/write", hoi3.TYPE_NUMBER },
	vRareMaterials 	= { "read/write", hoi3.TYPE_NUMBER }
}

function CGoodsValues:initialize()
	self.vMoney = 0
	self.vFuel = 0
	self.vCrudeOil = 0
	self.vMetal = 0
	self.vEnergy = 0
	self.vSupplies = 0
	self.vRareMaterials = 0
end
