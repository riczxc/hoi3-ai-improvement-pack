require('hoi3.Hoi3Object')

CDecisionObject = Hoi3Object:subclass('hoi3.CDecisionObject')

---
-- @since 1.3
-- @return CString 
function CDecisionObject:GetKey()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDecisionObject:IsAllowed()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDecisionObject:IsPotential()
	Hoi3Object.throwNotYetImplemented()
end
