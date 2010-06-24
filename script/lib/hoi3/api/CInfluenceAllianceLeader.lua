require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CInfluenceAllianceLeader = CDiplomaticAction:subclass('hoi3.CInfluenceAllianceLeader')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CInfluenceAllianceLeader
function CInfluenceAllianceLeader:initialize(countryTagA, countryTagB)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end