require('hoi3.Hoi3Object')

CDiplomacyStatusObject = Hoi3Object:subclass('hoi3.CDiplomacyStatusObject')

---
-- @since 1.3
-- @return bool 
function CDiplomacyStatusObject:AllowDebts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CDiplomacyStatusObject:GetTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatusObject:GetThreat()
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return table<CTradeRoute>
function CDiplomacyStatusObject:GetTradeRoutes()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatusObject:GetValue()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CWar
function CDiplomacyStatusObject:GetWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasAlliance()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasAnyAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasEmbargo()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasFriendlyAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasHostileAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasMilitaryAccess()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasNap()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasTruce()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:HasWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:IsBeingInfluenced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:IsFightingWarTogether()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:IsGuaranteed()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatusObject:IsGuaranting()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFixedPoint relation
-- @return void
function CDiplomacyStatusObject:SetValue(relation)
	Hoi3Object.assertParameterType(1, relation, 'CFixedPoint')
	
	Hoi3Object.throwNotYetImplemented()
end