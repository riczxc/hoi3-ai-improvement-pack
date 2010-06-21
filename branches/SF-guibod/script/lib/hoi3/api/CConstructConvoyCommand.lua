require('hoi3.api.CCommand')

CConstructConvoyCommand = CCommand:subclass('hoi3.CConstructConvoyCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool ConvoyOrEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommand
function CConstructConvoyCommand:initialize(actor, ConvoyOrEscort, quantity)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, ConvoyOrEscort, 'boolean')
	Hoi3Object.assertParameterType(3, quantity, 'number')

	Hoi3Object.throwNotYetImplemented()
end