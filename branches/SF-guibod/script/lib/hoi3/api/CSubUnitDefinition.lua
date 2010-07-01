require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitDefinition = hoi3.MultitonObject:subclass('hoi3.CSubUnitDefinition')

function CSubUnitDefinition:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildCostIC', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildCostMP', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildTime', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetCombatWidth', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetCompletionSize', false, hoi3.TYPE_NUMBER)
---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetDefaultStrength', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetDefensivness', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return Cstring
hoi3.f(CSubUnitDefinition, 'GetKey', false, 'CString')

function CSubUnitDefinition:GetKeyImpl()
	return self.key
end

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CSubUnitDefinition:GetIndexImpl()
	return self:getIndexInDictionnary(CSubUnitDefinition:getInstances())
end

---
-- @since 1.3
-- @return string
hoi3.f(CSubUnitDefinition, 'GetName', false, hoi3.TYPE_STRING)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetSoftness', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetToughness', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'CanParadrop', false, hoi3.TYPE_BOOLEAN)
---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsBomber', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsBuildable', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCag', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCapitalShip', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCarrier', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsRegiment', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsSecondRank', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsShip', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsSub', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsTransport', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsValid', false, hoi3.TYPE_BOOLEAN)

function CSubUnitDefinition.random()
	return hoi3.randomTableMember(CSubUnitDefinition:getInstances())
end
