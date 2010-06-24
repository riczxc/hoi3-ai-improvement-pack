require('hoi3')

module("hoi3.api", package.seeall)

CDecision = hoi3.Hoi3Object:subclass('hoi3.CDecision')

---
-- @since 1.3
-- @return CString 
function CDecision:GetKey()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDecision:IsAllowed()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDecision:IsPotential()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end
