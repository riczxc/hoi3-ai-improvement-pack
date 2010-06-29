require('hoi3')

module("hoi3.api", package.seeall)

CCountryDataBase = hoi3.AbstractObject:subclass('hoi3.CCountryDataBase')

---
-- @since 1.3
-- @param string countryCode
-- @return CCountryTag 
hoi3.f(CCountryDataBase, 'GetTag', true, 'CCountryTag', hoi3.TYPE_STRING)

function CCountryDataBase.GetTagImpl(tag)
	return CCountryTag:getInstance(tag)
end