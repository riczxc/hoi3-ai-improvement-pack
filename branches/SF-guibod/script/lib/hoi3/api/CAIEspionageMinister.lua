require('hoi3.api.CAIAgent')

CAIEspionageMinister = CAIAgent:subclass('hoi3.CAIEspionageMinister')

---
-- @since 1.3
-- @return bool
function CAIEspionageMinister:IsAligningToFaction()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'IsAligningToFaction'
	)
end  