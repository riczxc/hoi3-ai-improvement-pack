require('hoi3.Hoi3Object')

CUnitObject = Hoi3Object:subclass('hoi3.CUnit')

---
-- @since 1.3
-- @return table<CUnit> (or CSubUnitDefinition ?) 
function CUnitObject:GetChildren()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CString
function CUnitObject:GetName()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CUnitObject:IsMoving()
	Hoi3Object.throwNotYetImplemented()
end