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
hoi3.f(CDate, 'GetDayOfMonth', hoi3.TYPE_NUMBER)

function CDate:GetDayOfMonthImpl()
	return tonumber(os.date('%d',self.time))
end

---
-- @since 1.3
-- @return number
hoi3.f(CDate, 'GetMonthOfYear', hoi3.TYPE_NUMBER)

function CDate:GetMonthOfYearImpl()
	return tonumber(os.date('%m',self.time))
end

---
-- @since 2.0
-- @return number
hoi3.f(CDate, 'GetTotalDays', hoi3.TYPE_NUMBER)

function CDate:GetTotalDaysImpl()
	return math.floor((self.time - CDate.d1976) / (60*60*24))
end

---
-- @since 1.3
-- @return number
hoi3.f(CDate, 'GetYear', hoi3.TYPE_NUMBER)

function CDate:GetYearImpl()
	return tonumber(os.date('%Y',self.time)) - 40
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
hoi3.f(CDate, 'AddDays', hoi3.TYPE_VOID, hoi3.TYPE_NUMBER)

function CDate:AddDaysImpl(daysToAdd)
	self.time = self.time + (daysToAdd*60*60*24)
	self:clearResults()
end

function CDate.random()
	local date = {}
	--math.randomseed() has issues
	hoi3.Randomizer.seed()
	math.random(); math.random(); math.random()
	date.year = math.random(1976, 1988)
	date.month = math.random(1, 12)
	date.day = math.random(1, 31) --i hope 31 sept would be translated to 01 oct
	
	cdate = CDate(os.time(date))

	return cdate
end