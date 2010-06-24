require('hoi3')

module("hoi3.api", package.seeall)

CConstruction = hoi3.Hoi3Object:subclass('hoi3.CConstruction')

---
-- @since 2.0
-- @return number 
function CConstruction:GetCost()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetCost'
	)
end

---
-- @since 2.0
-- @return CMilitaryConstruction
function CConstruction:GetMilitary()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CMilitaryConstruction',
		'GetMilitary'
	)
end

---
-- @since 2.0
-- @return bool
function CConstruction:IsMilitary()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsMilitary'
	)
end