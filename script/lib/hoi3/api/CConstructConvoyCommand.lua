require('hoi3.Hoi3Object')

CConstructConvoyCommandObject = Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool ConvoyOrEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommandObject
function CConstructConvoyCommand(actor, ConvoyOrEscort, quantity)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, ConvoyOrEscort, 'boolean')
	Hoi3Object.assertParameterType(3, quantity, 'number')

	Hoi3Object.throwNotYetImplemented()
end