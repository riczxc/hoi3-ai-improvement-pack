require('hoi3.api.CAction')

CDiplomaticAction = CAction:subclass('hoi3.CDiplomaticAction')

CDiplomaticAction.ACCEPT	= 1
CDiplomaticAction.DECLINE = 2
CDiplomaticAction.PROPOSE	= 3  

---
-- @since 1.3
-- @return number
function CDiplomaticAction:GetAIAcceptance()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:GetValue(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:GetType(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticAction:IsValid()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticAction:IsSelectable()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:SetValue(...)
	Hoi3Object.throwUnknownSignature()
end
