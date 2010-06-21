require('hoi3.Hoi3Object')

CSpyPresence = Hoi3Object:subclass('hoi3.CSpyPresence')

CSpyPresence.MAX_SPY_LEVEL = 10
CSpyPresence.MAX_SPY_PRIORITY = 4

---
-- @since 1.3
-- @return CDate 
function CSpyPresence:GetLastMissionChangeDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetMission()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresence:GetPriority()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CSpyPresence:MissionAllowed(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end
