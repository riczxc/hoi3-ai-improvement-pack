require('hoi3')

module("hoi3.api", package.seeall)

CEU3Date = hoi3.Hoi3Object:subclass('hoi3.api.CEU3Date')

CEU3Date.d1976 = 189298800

function CEU3Date:initialize(time)
	if value ~= nil then
		hoi3.assertParameterType(1, time, hoi3.TYPE_NUMBER)
	end

	self._time = time or CEU3Date.d1976
end

---
-- @since 1.3
-- @return number 
hoi3.f(CEU3Date, 'GetDayOfMonth', hoi3.TYPE_NUMBER)

function CEU3Date:GetDayOfMonthImpl()
	return tonumber(os.date('%d',self._time))
end

---
-- @since 1.3
-- @return number
hoi3.f(CEU3Date, 'GetMonthOfYear', hoi3.TYPE_NUMBER)

function CEU3Date:GetMonthOfYearImpl()
	return tonumber(os.date('%m',self._time))
end

---
-- @since 2.0
-- @return number
hoi3.f(CEU3Date, 'GetTotalDays', hoi3.TYPE_NUMBER)

function CEU3Date:GetTotalDaysImpl()
	return math.floor((self._time - CEU3Date.d1976) / (60*60*24))
end

---
-- @since 1.3
-- @return number
hoi3.f(CEU3Date, 'GetYear', hoi3.TYPE_NUMBER)

function CEU3Date:GetYearImpl()
	return tonumber(os.date('%Y',self._time)) - 40
end

---
-- @since 1.3
-- @param number daysToAdd
-- @return void
hoi3.f(CEU3Date, 'AddDays', hoi3.TYPE_VOID, hoi3.TYPE_NUMBER)

function CEU3Date:AddDaysImpl(daysToAdd)
	self._time = self._time + (daysToAdd*60*60*24)
	self:clearResults()
end

function CEU3Date.random()
	local date = {}
	--math.randomseed() has issues
	hoi3.Randomizer.seed()
	math.random(); math.random(); math.random()
	date.year = math.random(1976, 1988)
	date.month = math.random(1, 12)
	date.day = math.random(1, 31) --i hope 31 sept would be translated to 01 oct
	
	return CEU3Date(os.time(date))
end

function CEU3Date.userdataToInstance(myClass, userdata, parent)
	if userdata == nil then
		dtools.warn("Expected CEU3Date userdata but got nil !?")
		return
	end
	
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")
	
	if userdata.GetYear ~= nil and userdata.GetMonthOfYear ~= nil then
		hoi3.error("Bad signature for userdata, didn't match CEU3Date.userdataToInstance() !")
		return
	end
	
	local date = {}
	date.year = userdata:GetYear() + 40
	date.month = userdata:GetMonthOfYear() + 1
	date.day = userdata:GetDayOfMonth() + 1
	
	local myInstance = CEU3Date(os.time(date))
	myInstance.__userdata = userdata
	return myInstance
end