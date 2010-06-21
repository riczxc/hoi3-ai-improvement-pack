require('hoi3.api.CCommand')

CChangeSpyMission = CCommand:subclass('hoi3.CChangeSpyMission')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag target
-- @param number spyMission
-- @return CChangeSpyMission
function CChangeSpyMission:initialize(actor, target, spyMission)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, target, 'CCountryTag')
	Hoi3Object.assertParameterType(3, spyMission, 'number')

	Hoi3Object.throwNotYetImplemented()
end