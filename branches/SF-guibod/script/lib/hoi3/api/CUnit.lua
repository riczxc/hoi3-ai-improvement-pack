require('hoi3.Hoi3Object')

CUnit = Hoi3Object:subclass('hoi3.CUnit')

---
-- @since 1.3
-- @return table<CUnit> (or CSubUnitDefinition ?) 
function CUnit:GetChildren()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CString
function CUnit:GetName()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CUnit:IsMoving()
	Hoi3Object.throwNotYetImplemented()
end