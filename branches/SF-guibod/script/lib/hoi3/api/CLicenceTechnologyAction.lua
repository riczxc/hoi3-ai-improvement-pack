require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CLicenceTechnologyAction = CDiplomaticAction:subclass('hoi3.CLicenceTechnologyAction')

---
-- @since 1.3
-- @return CFixedPoint
function CLicenceTechnologyAction:GetMoney()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLicenceTechnologyAction:GetParalell()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CLicenceTechnologyAction:GetSerial()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CSubUnitDefinition
function CLicenceTechnologyAction:GetSubunit()
	hoi3.throwNotYetImplemented()
end