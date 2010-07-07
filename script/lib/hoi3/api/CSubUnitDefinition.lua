require('hoi3')

module("hoi3.api", package.seeall)

CSubUnitDefinition = hoi3.MultitonObject:subclass('hoi3.api.CSubUnitDefinition')

function CSubUnitDefinition:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildCostIC', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildCostMP', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetBuildTime', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetCombatWidth', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetCompletionSize', hoi3.TYPE_NUMBER)
---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetDefaultStrength', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetDefensivness', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return Cstring
hoi3.f(CSubUnitDefinition, 'GetKey', 'CString')

function CSubUnitDefinition:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetIndex', hoi3.TYPE_NUMBER)

function CSubUnitDefinition:GetIndexImpl()
	return self:getIndexInDictionnary(CSubUnitDefinition:getInstances())
end

---
-- @since 1.3
-- @return string
hoi3.f(CSubUnitDefinition, 'GetName', hoi3.TYPE_STRING)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetSoftness', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CSubUnitDefinition, 'GetToughness', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'CanParadrop', hoi3.TYPE_BOOLEAN)
---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsBomber', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsBuildable', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCag', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCapitalShip', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsCarrier', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsRegiment', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsSecondRank', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsShip', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsSub', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsTransport', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CSubUnitDefinition, 'IsValid', hoi3.TYPE_BOOLEAN)

function CSubUnitDefinition.random()
	return hoi3.randomTableMember(CSubUnitDefinition:getInstances())
end
