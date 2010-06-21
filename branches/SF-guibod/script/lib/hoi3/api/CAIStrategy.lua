require('hoi3.Hoi3Object')

CAIStrategy = Hoi3Object:subclass('hoi3.CAIStrategy')

--- 
-- @since 1.3
CAI._AI_BALANCED_	= 1 
CAI._AI_DIPLOMAT_	= 2
CAI._AI_INDUSTRIALIST_ = 3
CAI._AI_MILITARIST_	= 4
CAI._AI_UNDEFINED_	= 5

---
-- @since 1.3
-- @return unknown 
function CAIStrategy:AddSubUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return void
function CAIStrategy:CancelPrepareWar(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetAccessScore(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetAntagonism(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CCountry
function CAIStrategy:GetCountry()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CCountryTag
function CAIStrategy:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetFriendliness(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetPersonality(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetProtectionism(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return table<CTheatre>
function CAIStrategy:GetTheatres(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CAIStrategy:GetThreat(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWantedSubUnits(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarScoreWith(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarTarget(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarTargets(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsBalanced()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsDiplomat()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsIndustrialist()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsMilitarist()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsPreparingWar()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIStrategy:IsPreparingWarWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @return void
function CAIStrategy:PrepareWar(countryTag, score)
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
function CAIStrategy:PrepareWarDecision(countryTag, score, decision)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, score, 'number')
	Hoi3Object.assertParameterType(3, decision, 'CDecision')
	
	Hoi3Object.throwNotYetImplemented()
end  