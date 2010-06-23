require('hoi3')

module("hoi3.api", package.seeall)

CCountryDataBase = hoi3.AbstractObject:subclass('hoi3.CCountryDataBase')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
function CCountryDataBase.GetTag(countryCode)
	hoi3.assertParameterType(1, countryCode, hoi3.TYPE_STRING)
	
	return CCountryDataBase.loadResultOrImplOrRandom(
		CCountryDataBase,
		'CCountryTag',
		'GetTag'
	)
end