require('hoi3')

module("hoi3.api", package.seeall)

CAIStrategy = hoi3.MultitonObject:subclass('hoi3.api.CAIStrategy')

--- 
-- @since 1.3
CAIStrategy._AI_UNDEFINED_	= 0
CAIStrategy._AI_MILITARIST_	= 1
CAIStrategy._AI_INDUSTRIALIST_ = 2
CAIStrategy._AI_DIPLOMAT_	= 3
CAIStrategy._AI_BALANCED_	= 4 

---
-- @param CCountryTag countryTag
function CAIStrategy:initialize(tag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	
	self._tag = tag
end

---
-- @since 1.3
-- @param unknown
-- @return unknown 
hoi3.f(CAIStrategy, 'AddSubUnit', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return void
hoi3.f(CAIStrategy, 'CancelPrepareWar', hoi3.TYPE_VOID, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetAccessScore', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetAntagonism', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @return CCountry
hoi3.f(CAIStrategy, 'GetCountry', 'CCountry')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CAIStrategy, 'GetCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetFriendliness', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIStrategy, 'GetPersonality', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAIStrategy, 'GetProtectionism', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @return iterator<CTheatre>
hoi3.f(CAIStrategy, 'GetTheatres', 'iterator<CTheatre>', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
hoi3.f(CAIStrategy, 'GetThreat', 'CFixedPoint', 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIStrategy, 'GetWantedSubUnits', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)  

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarScoreWith', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN) 

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarTarget', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'GetWarTargets', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsBalanced', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsDiplomat', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsIndustrialist', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsMilitarist', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIStrategy, 'IsPreparingWar', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CAIStrategy, 'IsPreparingWarWith', hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @return void
hoi3.f(CAIStrategy, 'PrepareWar', hoi3.TYPE_VOID, 'CCountryTag', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param number score
-- @param CDecision decision
-- @return void
hoi3.f(CAIStrategy, 'PrepareWarDecision', hoi3.TYPE_VOID, 'CCountryTag', hoi3.TYPE_NUMBER, 'CDecision')

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIStrategy, 'PrepareLimitedWar', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

function CAIStrategy.userdataToInstance(myClass, userdata, parent)
	-- intends to be run as myclass:bindToInstance(userdata)
	hoi3.assert(type(myClass) == hoi3.TYPE_TABLE, "Class reference is not a table.") 
	hoi3.assert(middleclass.subclassOf(hoi3.Hoi3Object,myClass), "Class reference is not Hoi3Object Instance.")
	hoi3.assert( type(userdata) == hoi3.TYPE_USERDATA, "Userdata is not userdata ! "..tostring(type(userdata)).." found !")

	if userdata.GetCountryTag == nil and type(userdata.GetCountryTag) ~= hoi3.TYPE_FUNCTION then
		hoi3.error("Bad signature for userdata, didn't match CAIStrategy.userdataToInstance() !")
		return
	end
	
	local key 
	if userdata:GetCountryTag():GetTag() ~= nil then
		key = hoi3.api.CCountryTag(userdata:GetCountryTag():GetTag())
	else
		key = hoi3.api.CNullTag()
	end
	local myInstance = CAIStrategy(key)
	myInstance.__userdata = userdata
	return myInstance
end
