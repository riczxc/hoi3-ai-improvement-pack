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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @param unknown
-- @return unknown 
hoi3.f(CAIStrategy, 'AddSubUnit', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return void
hoi3.f(CAIStrategy, 'CancelPrepareWar', false, hoi3.TYPE_VOID, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetAccessScore', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetAntagonism', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @return CCountry
hoi3.f(CAIStrategy, 'GetCountry', false, 'CCountry')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CAIStrategy, 'GetCountryTag', false, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetFriendliness', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIStrategy, 'GetPersonality', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetProtectionism', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @return iterator<CTheatre>
hoi3.f(CAIStrategy, 'GetTheatres', false, 'iterator<CTheatre>', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
hoi3.f(CAIStrategy, 'GetThreat', false, 'CFixedPoint', 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIStrategy, 'GetWantedSubUnits', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)  

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarScoreWith', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN) 

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarTarget', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarTargets', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsBalanced', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsDiplomat', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsIndustrialist', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsMilitarist', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsPreparingWar', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CAIStrategy, 'IsPreparingWarWith', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @return void
hoi3.f(CAIStrategy, 'PrepareWar', false, hoi3.TYPE_VOID, 'CCountryTag', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @param CDecision decision
-- @return void
hoi3.f(CAIStrategy, 'PrepareWarDecision', false, hoi3.TYPE_VOID, 'CCountryTag', hoi3.TYPE_NUMBER, 'CDecision')