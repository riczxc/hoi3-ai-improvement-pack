require('hoi3.Hoi3Object')

CAIPoliticsMinisterObject = Hoi3Object:subclass('hoi3.CAIAgent')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIPoliticsMinisterObject:IsCapitalSafeToLiberate(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 2.0
-- @return table<CMinister>
function CAIPoliticsMinisterObject:GetPossibleMinisters()
	
	Hoi3Object.throwNotYetImplemented()
end
