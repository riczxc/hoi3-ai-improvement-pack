require('hoi3')

module("hoi3.api", package.seeall)

CConstruction = hoi3.Hoi3Object:subclass('hoi3.CConstruction')

---
-- @since 2.0
-- @return number 
function CConstruction:GetCost()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetCost'
	)
end

---
-- @since 2.0
-- @return CMilitaryConstruction
function CConstruction:GetMilitary()
	return self:loadResultOrImplOrRandom(
		'CMilitaryConstruction',
		'GetMilitary'
	)
end

---
-- @since 2.0
-- @return bool
function CConstruction:IsMilitary()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsMilitary'
	)
end