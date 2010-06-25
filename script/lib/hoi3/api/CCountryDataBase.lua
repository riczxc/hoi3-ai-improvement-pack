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

function CCountryDataBase.GetTagImpl(countryCode)
	hoi3.assertParameterType(1, countryCode, hoi3.TYPE_STRING)
	
	require('hoi3.conf')
	-- Call this method to create multiton instance
	hoi3.conf.countryDatabase()
	
	return CCountryTag:getInstance(countryCode)
end