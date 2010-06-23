require('hoi3.AbstractObject')

module("hoi3.api", package.seeall)

CCountryDataBase = AbstractObject:subclass('hoi3.CCountryDataBase')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
function CCountryDataBase.GetTag(countryCode)
	hoi3.assertParameterType(1, countryCode, 'string')
	
	return CCountryDataBase.loadResultOrFakeOrRandom(
		CCountryDataBase,
		'CCountryTag',
		'GetTag'
	)
end