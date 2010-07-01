require('hoi3')

module("hoi3.api", package.seeall)

CAI = hoi3.MultitonObject:subclass('hoi3.CAI')

---
-- @param CCountryTag countryTag
function CAI:initalize(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

--- 
-- @since 1.4
-- @static
CAI._DIPLOMACY_	= 1 
CAI._INTELLIGENCE_ = 2
CAI._POLITICS_ = 3
CAI._PRODUCTION_ = 4
CAI._TECHNOLOGY_ = 5

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
hoi3.f(CAI, 'AlreadyTradingDisabledResource', false, hoi3.TYPE_BOOLEAN, 'CTradeRoute') 

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
hoi3.f(CAI, 'AlreadyTradingResourceOtherWay', false, hoi3.TYPE_BOOLEAN, 'CTradeRoute') 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'CanDeclareWar', false, hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag') 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'CanTradeFreeResources', false, hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag')

---
-- @since 2.0
-- @param number needs
-- @param number goodsType
-- @return CFixedPoint
hoi3.f(CAI, 'EvaluateCancelTrades', false, 'CFixedPoint', hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag from
-- @param CCountryTag to
-- @return CFixedPoint
hoi3.f(CAI, 'GetAmountTradedFrom', false, 'CFixedPoint', hoi3.TYPE_NUMBER, 'CCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return CCountry
hoi3.f(CAI, 'GetCountry', false, 'CCountry', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCountry countryA
-- @param CCountry countryB
-- @return CFixedPoint
hoi3.f(CAI, 'GetCountryAlignmentDistance', false, 'CFixedPoint', 'CCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @return CDate
hoi3.f(CAI, 'GetCurrentDate', false, 'CDate')

function CAI:GetCurrentDateImpl()
	return CCurrentGameState.GetCurrentDate()
end

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetDeployedSubUnitCounts', false, 'CArrayFloat')

---
-- @since 1.3
-- @return string
-- @static
hoi3.f(CAI, 'GetModDirectory', true, hoi3.TYPE_STRING)

---
-- @since 1.3
-- @param CCountry country
-- @param CFaction faction
-- @return CFixedPoint
hoi3.f(CAI, 'GetNormalizedAlignmentDistance', false, 'CFixedPoint', 'CCountry', 'CFaction')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAI, 'GetNumberOfOwnedProvinces', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetProductionSubUnitCounts', false, 'CArrayFloat')

---
-- @since 1.3
-- @return CSubUnitConstructionEntryList
hoi3.f(CAI, 'GetReqProdQueue', false, 'CSubUnitConstructionEntryList')

---
-- @since 1.3
-- @return iterator<CSubUnitConstructionEntry>
hoi3.f(CAI, 'GetReqProdQueueIter', false, 'iterator<CSubUnitConstructionEntry>')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDiplomacyStatus
hoi3.f(CAI, 'GetRelation', false, 'CDiplomacyStatus', 'CCountryTag', 'CCountryTag')

function CAI:GetRelationImpl(tagA, tagB)
	print(tagA)
	print(tagB)
	return CDiplomacyStatus(tagA, tagB)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
hoi3.f(CAI, 'GetSpamPenalty', false, hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 2.0
-- @return CArrayFloat
hoi3.f(CAI, 'GetTheatreSubUnitNeedCounts', false, 'CArrayFloat')

---
-- @since 1.3
-- @return bool
-- @static
hoi3.f(CAI, 'HasCommonExtension', true, hoi3.TYPE_BOOLEAN)

---
-- @since 1.4
-- @return bool
hoi3.f(CAI, 'HasFilledProdQueue', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param  CTradeRoute route
-- @return bool
hoi3.f(CAI, 'HasTradeGoneStale', false, hoi3.TYPE_BOOLEAN, 'CTradeRoute')

---
-- @since 1.3
-- @return bool
-- @static
hoi3.f(CAI, 'HasUserExtension', true, hoi3.TYPE_BOOLEAN)

---
-- @since 1.4
-- @param number automationtype
-- @return bool
-- @static
hoi3.f(CAI, 'IsAIControlledForPlayer', false, hoi3.TYPE_NUMBER, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
hoi3.f(CAI, 'IsInfluencing', false, hoi3.TYPE_BOOLEAN, 'CCountryTag', 'CCountryTag')

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool
hoi3.f(CAI, 'IsTradeingAwayNeededResource', false, hoi3.TYPE_BOOLEAN, 'CTradeRoute')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'MoveToNeighbor', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'MoveUnit', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAI, 'RequestSubUnit', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CCommand command
-- @return void
hoi3.f(CAI, 'Post', false, hoi3.TYPE_VOID, 'CCommand')

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
hoi3.f(CAI, 'PostAction', false, hoi3.TYPE_VOID, 'CAction')

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
hoi3.f(CAI, 'PrintConsole', false, hoi3.TYPE_VOID, hoi3.TYPE_STRING)

function CAI:PrintConsoleImpl(message)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, message, hoi3.TYPE_STRING)
	
	print(message)
	dtools.info(message)
end