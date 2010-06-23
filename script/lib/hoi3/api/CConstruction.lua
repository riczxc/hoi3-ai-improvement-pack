require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CConstruction = Hoi3Object:subclass('hoi3.CConstruction')

---
-- @since 2.0
-- @return number 
function CConstruction:GetCost()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetCost'
	)
end

---
-- @since 2.0
-- @return CMilitaryConstruction
function CConstruction:GetMilitary()
	return self:loadResultOrFakeOrRandom(
		'CMilitaryConstruction',
		'GetMilitary'
	)
end

---
-- @since 2.0
-- @return bool
function CConstruction:IsMilitary()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'IsMilitary'
	)
end