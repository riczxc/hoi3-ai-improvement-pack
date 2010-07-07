require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CLicenceTechnologyAction = CDiplomaticAction:subclass('hoi3.api.CLicenceTechnologyAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CLicenceTechnologyAction
function CLicenceTechnologyAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

---
-- @since 1.3
-- @return CFixedPoint
hoi3.fs(CLicenceTechnologyAction, 'GetMoney', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.fs(CLicenceTechnologyAction, 'GetParalell', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.fs(CLicenceTechnologyAction, 'GetSerial', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CSubUnitDefinition
hoi3.fs(CLicenceTechnologyAction, 'GetSubunit', 'CSubUnitDefinition')

function CLicenceTechnologyAction:desc()
	return tostring(self.tag).." licences "..tostring(self.target).. "."
end