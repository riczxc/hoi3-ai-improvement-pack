require('hoi3')

module("hoi3.api", package.seeall)

CWar = hoi3.Hoi3Object:subclass('hoi3.api.CWar')

---
-- @since 1.3
-- @return unknown 
hoi3.f(CWar, 'GetAttackers', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number
hoi3.f(CWar, 'GetCurrentRunningTimeInMonths', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return unknown
hoi3.f(CWar, 'GetDefenders', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown (returns userdata but not CEU3DATE)
hoi3.f(CWar, 'GetStartDate', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CWar, 'IsLimited', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CWar, 'IsPartOfWar', hoi3.TYPE_BOOLEAN, 'CCountryTag')

function CWar.random()
	local r = hoi3.RAND_PERC
	
	-- pick an existing war !
	local ret = hoi3.randomTableMember(CWar:getInstances())
	
	if ret == nil or r:compute() < 50 then
		-- a new war !
		local rt = hoi3.Randomizer(hoi3.TYPE_STRING)
		return CWar(rt:compute())
	else
		return ret
	end
	
end