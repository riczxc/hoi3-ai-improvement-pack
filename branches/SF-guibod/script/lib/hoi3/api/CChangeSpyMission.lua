require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeSpyMission = CCommand:subclass('hoi3.CChangeSpyMission')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag target
-- @param number spyMission
-- @return CChangeSpyMission
function CChangeSpyMission:initialize(actor, target, spyMission)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	hoi3.assertParameterType(3, spyMission, 'number')

	hoi3.throwNotYetImplemented()
end