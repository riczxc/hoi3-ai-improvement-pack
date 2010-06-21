require('hoi3.api.CAIAgent')

CAIPoliticsMinister = CAIAgent:subclass('hoi3.CAIPoliticsMinister')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIPoliticsMinister:IsCapitalSafeToLiberate(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 2.0
-- @return table<CMinister>
function CAIPoliticsMinister:GetPossibleMinisters()
	
	Hoi3Object.throwNotYetImplemented()
end
