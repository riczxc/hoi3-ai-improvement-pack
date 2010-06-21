require('hoi3.Hoi3Object')

CDate = Hoi3Object:subclass('hoi3.CDate')

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
	Hoi3Object.throwUnknownSignature()
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
	Hoi3Object.assertParameterType(1, daysToAdd, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end
