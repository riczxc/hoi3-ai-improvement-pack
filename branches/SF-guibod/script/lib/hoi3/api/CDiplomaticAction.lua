require('hoi3.api.CAction')

module("hoi3.api", package.seeall)

CDiplomaticAction = CAction:subclass('hoi3.CDiplomaticAction')

CDiplomaticAction.ACCEPT	= 1
CDiplomaticAction.DECLINE = 2
CDiplomaticAction.PROPOSE	= 3  

---
-- @since 1.3
-- @return number
function CDiplomaticAction:GetAIAcceptance()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:GetValue(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:GetType(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticAction:IsValid()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomaticAction:IsSelectable()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CDiplomaticAction:SetValue(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end
