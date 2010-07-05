require('hoi3')

module("hoi3.api", package.seeall)

CDecision = hoi3.MultitonObject:subclass('hoi3.CDecision')

---
-- @since 1.3
-- @param CString key
-- @return CDebtAction
function CDecision:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return CString 
hoi3.f(CDecision, 'GetKey', 'CString')

function CDecision:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return bool
hoi3.f(CDecision, 'IsAllowed', hoi3.TYPE_BOOLEAN)

function CDecision:IsAllowed()
	return self:IsPotential() and hoi3.RAND_LIKELY:compute()
end

---
-- @since 1.3
-- @return bool
hoi3.f(CDecision, 'IsPotential', hoi3.RAND_VUNLIKELY)

function CDecision.random()
	return hoi3.randomTableMember(CDecision:getInstances())
end
