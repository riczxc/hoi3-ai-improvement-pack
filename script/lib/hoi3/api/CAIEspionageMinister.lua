require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIEspionageMinister = CAIAgent:subclass('hoi3.CAIEspionageMinister')

---
-- @since 1.3
-- @return bool
function CAIEspionageMinister:IsAligningToFaction()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsAligningToFaction'
	)
end  