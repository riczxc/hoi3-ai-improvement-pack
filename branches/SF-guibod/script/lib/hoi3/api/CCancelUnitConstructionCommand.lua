require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CCancelUnitConstructionCommand = CCommand:subclass('hoi3.api.CCancelUnitConstructionCommand')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param CID cID
-- @return CCancelUnitConstructionCommand
function CCancelUnitConstructionCommand:initialize(tag, cid)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, cid, 'CID')

	self.tag = tag
	self.cid = cid
end

function CCancelUnitConstructionCommand:desc()
	return "Unit construction "..tostring(self.cid).." canceled by "..tostring(self.tag).."."
end