require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructConvoyCommand = CCommand:subclass('hoi3.CConstructConvoyCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool ConvoyOrEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommand
function CConstructConvoyCommand:initialize(actor, ConvoyOrEscort, quantity)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, ConvoyOrEscort, 'boolean')
	hoi3.assertParameterType(3, quantity, 'number')

	hoi3.throwNotYetImplemented()
end