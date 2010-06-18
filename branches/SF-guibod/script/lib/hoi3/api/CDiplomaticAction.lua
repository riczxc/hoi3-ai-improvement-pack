require('hoi3.api.CAction')

CDiplomaticActionObject = CActionObject:subclass('hoi3.CDiplomaticActionObject')

CDiplomaticActionObject.ACCEPT	= 1
CDiplomaticActionObject.DECLINE = 2
CDiplomaticActionObject.PROPOSE	= 3  

---
-- @since 1.3
-- @return number
function CDiplomaticActionObject:GetAIAcceptance()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticActionObject:GetValue(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticActionObject:GetType(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticActionObject:IsValid()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticActionObject:IsSelectable()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticActionObject:SetValue(...)
	Hoi3Object.throwUnknownSignature()
end
