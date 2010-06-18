require('hoi3.Hoi3Object')

CChangeSpyMissionObject = Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag target
-- @param number spyMission
-- @return CChangeSpyMissionObject
function CChangeSpyMission(actor, target, spyMission)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, target, 'CCountryTag')
	Hoi3Object.assertParameterType(3, spyMission, 'number')

	Hoi3Object.throwNotYetImplemented()
end