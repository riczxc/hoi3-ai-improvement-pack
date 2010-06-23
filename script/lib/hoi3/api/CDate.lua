require('hoi3')

module("hoi3.api", package.seeall)

CDate = hoi3.Hoi3Object:subclass('hoi3.CDate')

---
-- @since 1.3
-- @return number 
function CDate:GetDayOfMonth()
	return 1
end

---
-- @since 1.3
-- @return number
function CDate:GetMonthOfYear()
	return 1
end

---
-- @since 2.0
-- @return unknown
function CDate:GetTotalDays()
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CDate:GetYear()
	return 1936
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
function CDate:AddDays(daysToAdd)
	hoi3.assertParameterType(1, daysToAdd, hoi3.TYPE_NUMBER)
	
	hoi3.throwNotYetImplemented()
end
