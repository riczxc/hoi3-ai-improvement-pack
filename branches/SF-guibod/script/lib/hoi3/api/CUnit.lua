require('hoi3')

module("hoi3.api", package.seeall)

CUnit = hoi3.Hoi3Object:subclass('hoi3.CUnit')

---
-- @since 1.3
-- @return table<CUnit> (or CSubUnitDefinition ?) 
function CUnit:GetChildren()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CString
function CUnit:GetName()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CUnit:IsMoving()
	hoi3.throwNotYetImplemented()
end