require('hoi3.Hoi3Object')

CDiplomacyStatus = Hoi3Object:subclass('hoi3.CDiplomacyStatus')

---
-- @since 1.3
-- @return bool 
function CDiplomacyStatus:AllowDebts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CDiplomacyStatus:GetTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatus:GetThreat()
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return table<CTradeRoute>
function CDiplomacyStatus:GetTradeRoutes()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CDiplomacyStatus:GetValue()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CWar
function CDiplomacyStatus:GetWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasAlliance()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasAnyAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasEmbargo()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasFriendlyAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasHostileAgreement()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasMilitaryAccess()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasNap()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasTruce()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:HasWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsBeingInfluenced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsFightingWarTogether()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsGuaranteed()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CDiplomacyStatus:IsGuaranting()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFixedPoint relation
-- @return void
function CDiplomacyStatus:SetValue(relation)
	Hoi3Object.assertParameterType(1, relation, 'CFixedPoint')
	
	Hoi3Object.throwNotYetImplemented()
end