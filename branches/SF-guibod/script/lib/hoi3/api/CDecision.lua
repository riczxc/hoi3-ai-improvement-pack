require('hoi3')

module("hoi3.api", package.seeall)

CDecision = hoi3.MultitonObject:subclass('hoi3.CDecision')

---
-- @since 1.3
-- @param CString key
-- @return CDebtAction
function CDecision:initialize(key)
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return CString 
hoi3.f(CDecision, 'GetKey', false, 'CString')

function CDecision:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return bool
hoi3.f(CDecision, 'IsAllowed', false, hoi3.TYPE_BOOLEAN)

function CDecision:IsAllowed()
	return self:IsPotential() and hoi3.RAND_LIKELY.compute()
end

---
-- @since 1.3
-- @return bool
hoi3.f(CDecision, 'IsPotential', false, hoi3.RAND_VUNLIKELY)

function CDecision.random()
	local r = hoi3.Randomizer(hoi3.TYPE_STRING)
	r.minlen = 6
	r.maxlen = 20
	
	return CDecision(CString(r))
end
