require('hoi3.Hoi3Object')

CDateObject = Hoi3Object:subclass('hoi3.CDateObject')

---
-- @since 1.3
-- @return number 
function CDateObject:GetDayOfMonth()
	return 1
end

---
-- @since 1.3
-- @return number
function CDateObject:GetMonthOfYear()
	return 1
end

---
-- @since 2.0
-- @return unknown
function CDateObject:GetTotalDays()
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number
function CDateObject:GetYear()
	return 1936
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
function CDateObject:AddDays(daysToAdd)
	Hoi3Object.assertParameterType(1, daysToAdd, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end
