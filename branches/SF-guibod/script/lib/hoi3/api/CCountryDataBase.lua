require('hoi3')

module("hoi3.api", package.seeall)

CCountryDataBase = hoi3.AbstractObject:subclass('hoi3.api.CCountryDataBase')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
hoi3.fs(CCountryDataBase, 'GetTag', 'CCountryTag', hoi3.TYPE_STRING)

function CCountryDataBase.GetTagImpl(tag)
	return CCountryTag:getInstance(tag)
end