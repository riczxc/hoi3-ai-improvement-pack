require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIPoliticsMinister = CAIAgent:subclass('hoi3.CAIPoliticsMinister')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIPoliticsMinister:IsCapitalSafeToLiberate(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'IsCapitalSafeToLiberate',
		countryTag
	)
end

---
-- @since 2.0
-- @return table<CMinister>
function CAIPoliticsMinister:GetPossibleMinisters()
	return self:loadResultOrFakeOrRandom(
		'table<CMinister>',
		'GetPossibleMinisters'
	)
end
