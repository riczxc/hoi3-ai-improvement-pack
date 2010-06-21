require('hoi3.Hoi3Object')

CConstruction = Hoi3Object:subclass('hoi3.CConstruction')

---
-- @since 2.0
-- @return number 
function CConstruction:GetCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CMilitaryConstruction
function CConstruction:GetMilitary()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CConstruction:IsMilitary()
	Hoi3Object.throwNotYetImplemented()
end