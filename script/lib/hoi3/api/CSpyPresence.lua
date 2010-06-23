require('hoi3')

module("hoi3.api", package.seeall)

CSpyPresence = hoi3.Hoi3Object:subclass('hoi3.CSpyPresence')

CSpyPresence.MAX_SPY_LEVEL = 10
CSpyPresence.MAX_SPY_PRIORITY = 4

---
-- @since 1.3
-- @return CDate 
function CSpyPresence:GetLastMissionChangeDate()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetLevel()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetMission()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetPriority()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CSpyPresence:MissionAllowed(...)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end
