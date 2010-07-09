require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CToggleMobilizationCommand = CCommand:subclass('hoi3.api.CToggleMobilizationCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CToggleMobilizationCommand.constructorSignature = {'CCountryTag',hoi3.TYPE_BOOLEAN}

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param boolean  bMobilize
-- @return CToggleMobilizationCommand
function CToggleMobilizationCommand:initialize(tag, domobilize)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, domobilize, hoi3.TYPE_BOOLEAN)

	self.tag = tag
	self.domobilize = domobilize
end

function CToggleMobilizationCommand:desc()
	if self.domobilize then
		return "Mobilization triggered by "..tostring(self.tag).."."
	else
		return "Demobilization triggered by "..tostring(self.tag).."."
	end
end