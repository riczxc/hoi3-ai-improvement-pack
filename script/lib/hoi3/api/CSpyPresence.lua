require('hoi3.Hoi3Object')

CSpyPresenceObject = Hoi3Object:subclass('hoi3.CSpyPresence')

---
-- @since 1.3
-- @return CDate 
function CSpyPresenceObject:GetLastMissionChangeDate()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresenceObject:GetLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresenceObject:GetMission()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CSpyPresenceObject:GetPriority()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CSpyPresenceObject:MissionAllowed(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

CSpyPresenceObject.MAX_SPY_LEVEL = 10
CSpyPresenceObject.MAX_SPY_PRIORITY = 4

-- CSpyPresence has static methods and properties
-- we need to declare a CSpyPresence table
CSpyPresence = CSpyPresenceObject