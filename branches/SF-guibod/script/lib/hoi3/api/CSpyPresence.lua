require('hoi3')

module("hoi3.api", package.seeall)

CSpyPresence = hoi3.Hoi3Object:subclass('hoi3.CSpyPresence')

CSpyPresence.MAX_SPY_LEVEL = 10
CSpyPresence.MAX_SPY_PRIORITY = 4

---
-- @since 1.3
-- @return CDate 
hoi3.f(CSpyPresence, 'GetLastMissionChangeDate', false, 'CDate')

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetLevel', false, self.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetMission', false, self.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CSpyPresence, 'GetPriority', false, self.TYPE_NUMBER)

---
-- @since 1.3
-- @param unknown
-- @return unknown 
hoi3.f(CSpyPresence, 'MissionAllowed', false, self.TYPE_UNKNOWN, self.TYPE_UNKNOWN)
