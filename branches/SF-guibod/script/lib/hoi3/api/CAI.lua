require('hoi3')

module("hoi3.api", package.seeall)

CAI = hoi3.MultitonObject:subclass('hoi3.api.CAI')

---
-- @param CCountryTag countryTag
function CAI:initialize(tag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	
	self.tag = tag
end

--- 
-- @since 1.4
-- @static
CAI._DIPLOMACY_	= 0
CAI._PRODUCTION_ = 1
CAI._TECHNOLOGY_ = 2
CAI._POLITICS_ = 3
CAI._INTELLIGENCE_ = 4

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
hoi3.f(CAI, 'AlreadyTradingDisabledResource', hoi3.TYPE_BOOLEAN, 'CTradeRoute') 

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
hoi3.f(CAI, 'AlreadyTradingResourceOtherWay', hoi3.TYPE_BOOLEAN, 'CTradeRoute') 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'CanDeclareWar', hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag') 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'CanTradeFreeResources', hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag')

---
-- @since 2.0
-- @param number needs
-- @param number goodsType
-- @return CFixedPoint
hoi3.f(CAI, 'EvaluateCancelTrades', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag from
-- @param CCountryTag to
-- @return CFixedPoint
hoi3.f(CAI, 'GetAmountTradedFrom', 'CFixedPoint', hoi3.TYPE_NUMBER, 'CCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return CCountry
hoi3.f(CAI, 'GetCountry', 'CCountry', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountry countryA
-- @param CCountry countryB
-- @return CFixedPoint
hoi3.f(CAI, 'GetCountryAlignmentDistance', 'CFixedPoint', 'CCountry', 'CCountry')

---
-- @since 1.3
-- @return CEU3Date
hoi3.f(CAI, 'GetCurrentDate', 'CEU3Date')

function CAI:GetCurrentDateImpl()
	return CCurrentGameState.GetCurrentDate()
end

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetDeployedSubUnitCounts', 'CArrayFloat')

---
-- @since 1.3
-- @return string
-- @static
hoi3.fs(CAI, 'GetModDirectory', hoi3.TYPE_STRING)

---
-- @since 2.0
-- @return string
-- @static
hoi3.fs(CAI, 'GetCommonModDirectory', hoi3.TYPE_STRING)

---
-- @since 1.3
-- @param CCountry country
-- @param CFaction faction
-- @return CFixedPoint
hoi3.f(CAI, 'GetNormalizedAlignmentDistance', 'CFixedPoint', 'CCountry', 'CFaction')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAI, 'GetNumberOfOwnedProvinces', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetProductionSubUnitCounts', 'CArrayFloat')

---
-- @since 1.3
-- @return CSubUnitConstructionEntryList
hoi3.f(CAI, 'GetReqProdQueue', 'CSubUnitConstructionEntryList')

---
-- @since 1.3
-- @return iterator<CSubUnitConstructionEntry>
hoi3.f(CAI, 'GetReqProdQueueIter', 'iterator<CSubUnitConstructionEntry>')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDiplomacyStatus
hoi3.f(CAI, 'GetRelation', 'CDiplomacyStatus', 'CCountryTag', 'CCountryTag')

function CAI:GetRelationImpl(tagA, tagB)
	return CDiplomacyStatus(tagA, tagB)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAI, 'GetSpamPenalty', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetTheatreSubUnitNeedCounts', 'CArrayFloat')

---
-- @since 1.3
-- @return bool
-- @static
hoi3.fs(CAI, 'HasCommonExtension', hoi3.TYPE_BOOLEAN)

---
-- @since 1.4
-- @return bool
hoi3.f(CAI, 'HasFilledProdQueue', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param  CTradeRoute route
-- @return bool
hoi3.f(CAI, 'HasTradeGoneStale', hoi3.TYPE_BOOLEAN, 'CTradeRoute')

---
-- @since 1.3
-- @return bool
-- @static
hoi3.fs(CAI, 'HasUserExtension', hoi3.TYPE_BOOLEAN)

---
-- @since 1.4
-- @param number automationtype
-- @return bool
-- @static
hoi3.f(CAI, 'IsAIControlledForPlayer', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'IsInfluencing', hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool
hoi3.f(CAI, 'IsTradeingAwayNeededResource', hoi3.TYPE_BOOLEAN, 'CTradeRoute')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'MoveToNeighbor', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'MoveUnit', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'RequestSubUnit', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCommand command
-- @return void
hoi3.f(CAI, 'Post', hoi3.TYPE_VOID, 'CCommand')

function CAI:PostImpl(command)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, command, 'CCommand')
	
	local message = tostring(command.class).." posted"
	if type(command.desc) == hoi3.TYPE_FUNCTION then 
		message = message.." : "..command:desc()
	end
	dtools.info(message)
end

---
-- @since 1.3
-- @param CAction action
-- @return void
hoi3.f(CAI, 'PostAction', hoi3.TYPE_VOID, 'CAction')

function CAI:PostActionImpl(action)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, action, 'CAction')
	
	local message = tostring(action.class).." posted"
	if type(action.desc) == hoi3.TYPE_FUNCTION then 
		message = message.." : "..action:desc()
	end
	dtools.info(message)
end

---
-- @since 1.3
-- @param string message
-- @return void
hoi3.f(CAI, 'PrintConsole', hoi3.TYPE_VOID, hoi3.TYPE_STRING)

function CAI:PrintConsoleImpl(message)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, message, hoi3.TYPE_STRING)
	
	print(message)
	dtools.info(message)
end

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'CalculateFriendOfFaction', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)