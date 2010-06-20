require('hoi3.api.CDiplomaticAction')

CInfluenceAllianceLeaderObject = CDiplomaticActionObject:subclass('hoi3.CInfluenceAllianceLeader')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CInfluenceAllianceLeaderObject
function CInfluenceAllianceLeader(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end