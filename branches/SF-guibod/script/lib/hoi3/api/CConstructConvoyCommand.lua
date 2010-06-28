require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructConvoyCommand = CCommand:subclass('hoi3.CConstructConvoyCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool isEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommand
function CConstructConvoyCommand:initialize(actor, isEscort, quantity)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, isEscort, hoi3.TYPE_BOOLEAN)
	hoi3.assertParameterType(3, quantity, hoi3.TYPE_NUMBER)

	self.actor = actor
	self.isEscort = isEscort
	self.quantity = quantity
end