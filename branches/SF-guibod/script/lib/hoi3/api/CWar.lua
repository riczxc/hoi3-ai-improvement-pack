require('hoi3')

module("hoi3.api", package.seeall)

CWar = hoi3.MultitonObject:subclass('hoi3.CWar')

---
-- @since 1.3
-- @param string key --TODO: maybe use a CID() object as key ?
-- @return string 
function CWar:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return unknown 
hoi3.f(CWar, 'GetAttackers', false, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number
hoi3.f(CWar, 'GetCurrentRunningTimeInMonths', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return unknown
hoi3.f(CWar, 'GetDefenders', false, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return CDate
hoi3.f(CWar, 'GetStartDate', false, 'CDate')

---
-- @since 1.3
-- @return bool
hoi3.f(CWar, 'IsLimited', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CWar, 'IsPartOfWar', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')