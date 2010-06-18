require('hoi3.Hoi3Object')

CCountryDataBaseObject = Hoi3Object:subclass('hoi3.CCountryDataBaseObject')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
function CCountryDataBaseObject.GetTag(countryCode)
	Hoi3Object.assertParameterType(1, countryCode, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

-- CCountryDataBase has static methods and properties
-- we need to declare a CCountryDataBase table 
CCountryDataBase = CCountryDataBaseObject