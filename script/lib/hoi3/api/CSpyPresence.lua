require('hoi3')

module("hoi3.api", package.seeall)

CSpyPresence = hoi3.Hoi3Object:subclass('hoi3.api.CSpyPresence')

CSpyPresence.MAX_SPY_LEVEL = 10
CSpyPresence.MAX_SPY_PRIORITY = 4

---
-- @since 1.3
-- @return CEU3Date 
hoi3.f(CSpyPresence, 'GetLastMissionChangeDate', 'CEU3Date')

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetLevel', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetMission', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetPriority', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @static
-- @param unknown
-- @return unknown 
hoi3.fs(CSpyPresence, 'MissionAllowed', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

function CSpyPresence.random()
	return CSpyPresence()
end
