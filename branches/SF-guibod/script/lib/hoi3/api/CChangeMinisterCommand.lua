require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeMinisterCommand = CCommand:subclass('hoi3.api.CChangeMinisterCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CChangeMinisterCommand.constructorSignature = {'CCountryTag','CMinister','CGovernmentPosition'}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CLaw law
-- @param CLawGroup group
-- @return CChangeMinisterCommand
function CChangeMinisterCommand:initialize(tag, minister, pos)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, minister, 'CMinister')
	hoi3.assertParameterType(3, pos, 'CGovernmentPosition')

	self.tag = tag
	self.minister = minister
	self.pos = pos
end

function CChangeMinisterCommand:desc()
	return "Changed minister to "..tostring(self.minister:GetKey())..
		" for "..tostring(self.pos:GetKey()).." group"..
		" by "..tostring(self.tag).."."
end