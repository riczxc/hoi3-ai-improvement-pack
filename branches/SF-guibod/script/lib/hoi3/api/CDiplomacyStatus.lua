require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CDiplomacyStatus = Hoi3Object:subclass('hoi3.CDiplomacyStatus')

---
-- @since 1.3
-- @return bool 
function CDiplomacyStatus:AllowDebts()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CDiplomacyStatus:GetTarget()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatus:GetThreat()
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return table<CTradeRoute>
function CDiplomacyStatus:GetTradeRoutes()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatus:GetValue()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CWar
function CDiplomacyStatus:GetWar()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasAlliance()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasAnyAgreement()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasEmbargo()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasFriendlyAgreement()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasHostileAgreement()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasMilitaryAccess()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasNap()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasTruce()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasWar()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsBeingInfluenced()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsFightingWarTogether()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsGuaranteed()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsGuaranting()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFixedPoint relation
-- @return void
function CDiplomacyStatus:SetValue(relation)
	hoi3.assertParameterType(1, relation, 'CFixedPoint')
	
	hoi3.throwNotYetImplemented()
end