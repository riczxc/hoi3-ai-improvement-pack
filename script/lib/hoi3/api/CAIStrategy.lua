require('hoi3.Hoi3Object')

CAIStrategyObject = Hoi3Object:subclass('hoi3.Hoi3Object')

--- 
-- @since 1.3
CAIObject._AI_BALANCED_	= 1 
CAIObject._AI_DIPLOMAT_	= 2
CAIObject._AI_INDUSTRIALIST_ = 3
CAIObject._AI_MILITARIST_	= 4
CAIObject._AI_UNDEFINED_	= 5

---
-- @since 1.3
-- @return unknown 
function CAIStrategyObject:AddSubUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return void
function CAIStrategyObject:CancelPrepareWar(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategyObject:GetAccessScore(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategyObject:GetAntagonism(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CCountry
function CAIStrategyObject:GetCountry()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CCountryTag
function CAIStrategyObject:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategyObject:GetFriendliness(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategyObject:GetPersonality(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategyObject:GetProtectionism(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return table<CTheatre>
function CAIStrategyObject:GetTheatres(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CAIStrategyObject:GetThreat(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategyObject:GetWantedSubUnits(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategyObject:GetWarScoreWith(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategyObject:GetWarTarget(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategyObject:GetWarTargets(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategyObject:IsBalanced()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategyObject:IsDiplomat()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategyObject:IsIndustrialist()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategyObject:IsMilitarist()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategyObject:IsPreparingWar()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIStrategyObject:IsPreparingWarWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @return void
function CAIStrategyObject:PrepareWar(countryTag, score)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, score, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @param CDecision decision
-- @return void
function CAIStrategyObject:PrepareWarDecision(countryTag, score, decision)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, score, 'number')
	Hoi3Object.assertParameterType(3, decision, 'CDecision')
	
	Hoi3Object.throwNotYetImplemented()
end  

-- CAI has static methods and properties
-- we need to declare a CAI table 
CAIStrategy = CAIStrategyObject