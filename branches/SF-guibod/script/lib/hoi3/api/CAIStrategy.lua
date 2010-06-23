require('hoi3')

module("hoi3.api", package.seeall)

CAIStrategy = hoi3.Hoi3Object:subclass('hoi3.CAIStrategy')

--- 
-- @since 1.3
CAIStrategy._AI_BALANCED_	= 1 
CAIStrategy._AI_DIPLOMAT_	= 2
CAIStrategy._AI_INDUSTRIALIST_ = 3
CAIStrategy._AI_MILITARIST_	= 4
CAIStrategy._AI_UNDEFINED_	= 5

---
-- @param CCountryTag countryTag
function CAIStrategy:initalize(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return unknown 
function CAIStrategy:AddSubUnit(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return void
function CAIStrategy:CancelPrepareWar(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetAccessScore(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetAccessScore',
		countryTag
	)
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetAntagonism(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetAntagonism',
		countryTag
	)
end  

---
-- @since 1.3
-- @return CCountry
function CAIStrategy:GetCountry()
	return self.countryTag:GetCountry()
end  

---
-- @since 1.3
-- @return CCountryTag
function CAIStrategy:GetCountryTag()
	return self.countryTag
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetFriendliness(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetFriendliness',
		countryTag
	)
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetPersonality(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIStrategy:GetProtectionism(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetProtectionism',
		countryTag
	)
end  

---
-- @since 1.3
-- @return table<CTheatre>
function CAIStrategy:GetTheatres(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CAIStrategy:GetThreat(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetThreat',
		countryTag
	)
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWantedSubUnits(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarScoreWith(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarTarget(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIStrategy:GetWarTargets(...)
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsBalanced()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsBalanced'
	)
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsDiplomat()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsDiplomat'
	)
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsIndustrialist()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsIndustrialist'
	)
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsMilitarist()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsMilitarist'
	)
end  

---
-- @since 1.3
-- @return bool
function CAIStrategy:IsPreparingWar()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsPreparingWar'
	)
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
function CAIStrategy:IsPreparingWarWith(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsPreparingWar',
		countryTag
	)
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @return void
function CAIStrategy:PrepareWar(countryTag, score)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	hoi3.assertParameterType(2, score, hoi3.TYPE_NUMBER)
	
	hoi3.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @param CDecision decision
-- @return void
function CAIStrategy:PrepareWarDecision(countryTag, score, decision)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	hoi3.assertParameterType(2, score, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(3, decision, 'CDecision')
	
	hoi3.throwNotYetImplemented()
end  