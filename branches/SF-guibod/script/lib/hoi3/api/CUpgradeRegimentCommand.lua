require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CUpgradeRegimentCommand = CCommand:subclass('hoi3.api.CUpgradeRegimentCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CUpgradeRegimentCommand.constructorSignature = {'CSubUnit', hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool isEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommand
function CUpgradeRegimentCommand:initialize(unit, num)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, unit, 'CSubUnit')
	hoi3.assertParameterType(2, num, hoi3.TYPE_NUMBER)

	self.unit = unit
	self.num = num
end

function CUpgradeRegimentCommand:desc()
	return "Issued upgrade command."
end