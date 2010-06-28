require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CCancelUnitConstructionCommand = CCommand:subclass('hoi3.CCancelUnitConstructionCommand')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param CID cID
-- @return CCancelUnitConstructionCommand
function CCancelUnitConstructionCommand:initialize(countryTag, cID)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	hoi3.assertParameterType(2, cID, 'CID')

	self.tag = countryTag
	self.cid = cID
end

---
-- @since 1.3
-- @return CCancelUnitConstructionCommand 
hoi3.f(CCallAllyAction, 'Clone', false, 'CCancelUnitConstructionCommand')
