require('hoi3.AbstractObject')

CCountryDataBase = AbstractObject:subclass('hoi3.CCountryDataBase')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
function CCountryDataBase.GetTag(countryCode)
	Hoi3Object.assertParameterType(1, countryCode, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end