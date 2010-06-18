require('hoi3.Hoi3Object')

CConstructionObject = Hoi3Object:subclass('hoi3.CConstructionObject')

---
-- @since 2.0
-- @return number 
function CConstructionObject:GetCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CMilitaryConstruction
function CConstructionObject:GetMilitary()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return bool
function CConstructionObject:IsMilitary()
	Hoi3Object.throwNotYetImplemented()
end