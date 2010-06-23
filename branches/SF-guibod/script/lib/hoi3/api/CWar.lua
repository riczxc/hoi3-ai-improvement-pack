require('hoi3')

module("hoi3.api", package.seeall)

CWar = hoi3.Hoi3Object:subclass('hoi3.CWar')

---
-- @since 1.3
-- @return unknown 
function CWar:GetAttackers()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number
function CWar:GetCurrentRunningTimeInMonths()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CWar:GetDefenders()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CDate
function CWar:GetStartDate()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CWar:IsLimited()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CWar:IsPartOfWar(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	hoi3.throwNotYetImplemented(countryTag)
end