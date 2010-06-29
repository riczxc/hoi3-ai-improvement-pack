require('hoi3')

module("hoi3.api", package.seeall)

CDiplomacyStatus = hoi3.MultitonObject:subclass('hoi3.CDiplomacyStatus')

-- Multiton pattern for this object use 2 keys
CDiplomacyStatus.numkeys = 2

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CCountryTag target
-- @return CDiplomacyStatus
function CDiplomacyStatus:initialize(actor, target)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	
	self.actor = actor
	self.target = target
end

---
-- @since 1.3
-- @return bool 
hoi3.f(CDiplomacyStatus, 'AllowDebts', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CDiplomacyStatus, 'GetTarget', false, 'CCountryTag')

function CDiplomacyStatus:GetTarget()
	return self.target 
end

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CDiplomacyStatus, 'GetThreat', false, 'CFixedPoint')

---
-- @since 1.3
-- @return table<CTradeRoute>
hoi3.f(CDiplomacyStatus, 'GetTradeRoutes', false, 'table<CTradeRoute>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CDiplomacyStatus, 'GetValue', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CWar
hoi3.f(CDiplomacyStatus, 'GetWar', false, 'CWar')

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasAlliance', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasAnyAgreement', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasEmbargo', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasFriendlyAgreement', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasHostileAgreement', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasMilitaryAccess', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasNap', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasTruce', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'HasWar', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsBeingInfluenced', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsFightingWarTogether', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsGuaranteed', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CDiplomacyStatus, 'IsGuaranting', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CFixedPoint relation
-- @return void
hoi3.f(CDiplomacyStatus, 'SetValue', false, hoi3.TYPE_VOID, 'CFixedPoint')