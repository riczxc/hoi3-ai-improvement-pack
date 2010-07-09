require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CCreateVassalCommand = CCommand:subclass('hoi3.api.CCreateVassalCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CCreateVassalCommand.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CCreateVassalCommand
function CCreateVassalCommand:initialize(tag, libtag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, libtag, 'CCountryTag')

	self.tag = tag
	self.libtag = libtag
end

function CCreateVassalCommand:desc()
	return tostring(self.tag).." created vassal "..tostring(self.libtag).."."
end