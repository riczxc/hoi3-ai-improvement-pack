require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIEspionageMinister = CAIAgent:subclass('hoi3.CAIEspionageMinister')

-- Same constructor
CAIEspionageMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @return bool
function CAIEspionageMinister:IsAligningToFaction()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsAligningToFaction'
	)
end  