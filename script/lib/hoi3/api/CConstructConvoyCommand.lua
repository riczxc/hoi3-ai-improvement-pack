require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CConstructConvoyCommand = CCommand:subclass('hoi3.api.CConstructConvoyCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CConstructConvoyCommand.constructorSignature = {'CCountryTag', hoi3.TYPE_BOOLEAN, hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag actor
-- @param bool isEscort (true = escort, false = convoy)
-- @param number quantity
-- @return CConstructConvoyCommand
function CConstructConvoyCommand:initialize(tag, isEscort, quantity)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, isEscort, hoi3.TYPE_BOOLEAN)
	hoi3.assertParameterType(3, quantity, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.isEscort = isEscort
	self.quantity = quantity
end

function CConstructConvoyCommand:desc()
	local str
	
	if self.isEscort then str = "escort" else str = "convoy" end
	return "Issued construction of "..tostring(self.quantity).." "..str..
		" by "..tostring(self.tag).."."
end