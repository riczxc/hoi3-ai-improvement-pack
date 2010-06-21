require('hoi3.api.CDiplomaticAction')

CInfluenceAllianceLeader = CDiplomaticAction:subclass('hoi3.CInfluenceAllianceLeader')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CInfluenceAllianceLeader
function CInfluenceAllianceLeader:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end