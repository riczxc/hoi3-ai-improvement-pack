require('hoi3.Hoi3Object')

CWarObject = Hoi3Object:subclass('hoi3.CWar')

---
-- @since 1.3
-- @return unknown 
function CWarObject:GetAttackers()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number
function CWarObject:GetCurrentRunningTimeInMonths()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CWarObject:GetDefenders()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CDate
function CWarObject:GetStartDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CWarObject:IsLimited()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CWarObject:IsPartOfWar(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented(countryTag)
end