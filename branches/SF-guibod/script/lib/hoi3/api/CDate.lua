require('hoi3.Hoi3Object')

CDateObject = Hoi3Object:subclass('hoi3.CDateObject')

---
-- @since 1.3
-- @return number 
function CDateObject:GetDayOfMonth()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CDateObject:GetMonthOfYear()
	Hoi3Object.throwNotYetImplemented()
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
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
function CDateObject:AddDays(daysToAdd)
	Hoi3Object.assertParameterType(1, daysToAdd, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end
