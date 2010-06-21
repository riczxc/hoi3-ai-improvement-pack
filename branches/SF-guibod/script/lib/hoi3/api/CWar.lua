require('hoi3.Hoi3Object')

CWar = Hoi3Object:subclass('hoi3.CWar')

---
-- @since 1.3
-- @return unknown 
function CWar:GetAttackers()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number
function CWar:GetCurrentRunningTimeInMonths()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CWar:GetDefenders()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CDate
function CWar:GetStartDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CWar:IsLimited()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CWar:IsPartOfWar(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented(countryTag)
end