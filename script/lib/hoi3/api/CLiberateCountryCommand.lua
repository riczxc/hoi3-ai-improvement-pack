require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CLiberateCountryCommand = CCommand:subclass('hoi3.api.CLiberateCountryCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CLiberateCountryCommand.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CLiberateCountryCommand
function CLiberateCountryCommand:initialize(tag, libtag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, libtag, 'CCountryTag')

	self.tag = tag
	self.libtag = libtag
end

function CLiberateCountryCommand:desc()
	return tostring(self.tag).." liberated "..tostring(self.libtag).."."
end