require('hoi3.api.CList')

module("hoi3.api", package.seeall)

CCountryList = CList:subclass('hoi3.CCountryList')

---
-- @since 1.3
-- @return bool
function CCountryList:IsEnemy()
	return CCountryList:loadResultOrImplOrRandom(
		'boolean',
		'IsEnemy'
	)
end  