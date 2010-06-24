require('hoi3')

module("hoi3.api", package.seeall)

CDate = hoi3.Hoi3Object:subclass('hoi3.CDate')

CDate.d1976 = 189298800

function CDate:initialize(time)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, time, hoi3.TYPE_NUMBER)
	
	self.time = time
end

---
-- @since 1.3
-- @return number 
function CDate:GetDayOfMonth()
	hoi3.assertNonStatic(self)
	return tonumber(os.date('%d',self.time))
end

---
-- @since 1.3
-- @return number
function CDate:GetMonthOfYear()
	hoi3.assertNonStatic(self)
	return tonumber(os.date('%m',self.time))
end

---
-- @since 2.0
-- @return unknown
function CDate:GetTotalDays()
	hoi3.assertNonStatic(self)
	return math.floor((self.time - CDate.d1976) / (60*60*24))
end

---
-- @since 1.3
-- @return number
function CDate:GetYear()
	hoi3.assertNonStatic(self)
	return tonumber(os.date('%Y',self.time)) - 40
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
function CDate:AddDays(daysToAdd)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, daysToAdd, hoi3.TYPE_NUMBER)
	
	self.time = self.time + (daysToAdd*60*60*24)
end

function CDate.random()
	local date = {}
	math.randomseed(os.time())
	math.random(); math.random(); math.random()
	date.year = math.random(1976, 1988)
	date.month = math.random(1, 12)
	date.day = math.random(1, 31) --i hope 31 sept would be translated to 01 oct
	
	cdate = CDate(os.time(date))

	return cdate
end