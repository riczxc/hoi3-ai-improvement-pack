require('hoi3')

module("hoi3.api", package.seeall)

CAI = hoi3.MultitonObject:subclass('hoi3.CAI')

---
-- @param CCountryTag countryTag
function CAI:initalize(countryTag)
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
function CAI:AlreadyTradingDisabledResource(route)
	hoi3.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN, 
		"AlreadyTradingDisabledResource", 
		route
	)
end

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
function CAI:AlreadyTradingResourceOtherWay(route)
	hoi3.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN, 
		"AlreadyTradingResourceOtherWay", 
		route
	)
end 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAI:CanDeclareWar(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN, 
		"CanDeclareWar", 
		countryTagA, 
		countryTagB
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAI:CanTradeFreeResources(countryTagA,  countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN, 
		"CanTradeFreeResources", 
		countryTagA, 
		countryTagB
	)
end

---
-- @since 2.0
-- @param number needs
-- @param number goodsType
-- @return CFixedPoint
function CAI:EvaluateCancelTrades(needs,  goodsType)
	hoi3.assertParameterType(1, needs, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(2, goodsType, hoi3.TYPE_NUMBER)

	assert(goodsType < CGoodsPool._GC_NUMOF_ + 1, string.format("goodsType must be lower than %d", CGoodsPool._GC_NUMOF_ + 1))
	assert(goodsType > 0, string.format("goodsType must be greater than %d", 0))
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint', 
		"EvaluateCancelTrades", 
		needs,  
		goodsType
	)
end


---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag from
-- @param CCountryTag to
-- @return CFixedPoint
function CAI:GetAmountTradedFrom(goodsType, from,  to)
	hoi3.assertParameterType(1, goodsType, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(2, from, 'CCountryTag')
	hoi3.assertParameterType(3, to, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		"GetAmountTradedFrom", 
		goodsType, 
		from,  
		to
	)
end

---
-- @since 1.3
-- @return CCountry
function CAI:GetCountry(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountry countryA
-- @param CCountry countryB
-- @return CFixedPoint
function CAI:GetCountryAlignmentDistance(countryA, countryB)
	hoi3.assertParameterType(1, countryA, 'CCountry')
	hoi3.assertParameterType(2, countryB, 'CCountry')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		"GetCountryAlignmentDistance", 
		countryA, 
		countryB
	)
end

---
-- @since 1.3
-- @return CDate
-- @static
function CAI.GetCurrentDate()
	return CAI.loadResultOrImplOrRandom(
		--loadResultOrImpl is used statically, we pass "self" paramater as class reference
		--instead of class instance !
		CAI,
		'CDate',
		"GetCurrentDate"
	)	
end

---
-- @since 1.3
-- @return string
-- @static
function CAI.GetCommonModDirectory()
	return CAI.loadResultOrImplOrRandom(
		CAI,
		hoi3.TYPE_STRING,
		"GetCommonModDirectory"
	)
end

---
-- @since 2.0
-- @return CArrayFix
function CAI:GetDeployedSubUnitCounts()
	return self:loadResultOrImplOrRandom(
		'CArrayFix',
		"GetDeployedSubUnitCounts"
	)
end

---
-- @since 1.3
-- @return string
-- @static
function CAI.GetModDirectory()
	return CAI.loadResultOrImplOrRandom(
		CAI,
		hoi3.TYPE_STRING,
		"GetModDirectory"
	)
end

---
-- @since 1.3
-- @param CCountry country
-- @param CFaction faction
-- @return CFixedPoint
function CAI:GetNormalizedAlignmentDistance(country, faction)
	hoi3.assertParameterType(1, country, 'CCountry')
	hoi3.assertParameterType(2, faction, 'CFaction')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		"GetNormalizedAlignmentDistance",
		country, 
		faction
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAI:GetNumberOfOwnedProvinces(countryTag)
	hoi3.assertParameterType(1, country, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		"GetNumberOfOwnedProvinces",
		countryTag
	)
end

---
-- @since 2.0
-- @return CArrayFix
function CAI:GetProductionSubUnitCounts()
	return self:loadResultOrImplOrRandom(
		'CArrayFix',
		"GetProductionSubUnitCounts"
	)
end

---
-- @since 1.3
-- @return CSubUnitConstructionEntryList
function CAI:GetReqProdQueue()
	return self:loadResultOrImplOrRandom(
		'CSubUnitConstructionEntryList',
		"GetReqProdQueue"
	)
end

---
-- @since 1.3
-- @return table<CSubUnitConstructionEntry>
function CAI:GetReqProdQueueIter()
	return self:loadResultOrImplOrRandom(
		'table<CSubUnitConstructionEntry>',
		"GetReqProdQueueIter"
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDiplomacyStatus
function CAI:GetRelation(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CDiplomacyStatus',
		"GetRelation",
		countryTagA, 
		countryTagB
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAI:GetSpamPenalty(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		"number",
		"GetSpamPenalty",
		countryTag
	)
end

---
-- @since 2.0
-- @return CArrayFix
function CAI:GetTheatreSubUnitNeedCounts()
	return self:loadResultOrImplOrRandom(
		"CArrayFix",
		"GetTheatreSubUnitNeedCounts"
	)
end

---
-- @since 1.3
-- @return bool
-- @static
function CAI.HasCommonExtension()
	return CAI.loadResultOrImplOrRandom(
		CAI,
		hoi3.TYPE_BOOLEAN,
		"HasCommonExtension"
	)
end

---
-- @since 1.4
-- @return bool
function CAI:HasFilledProdQueue()
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasFilledProdQueue'
	)
end

---
-- @since 1.3
-- @param  CTradeRoute route
-- @return bool
function CAI:HasTradeGoneStale(route)
	hoi3.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasTradeGoneStale',
		route
	)	
end

---
-- @since 1.3
-- @return bool
-- @static
function CAI.HasUserExtension()
	return CAI.loadResultOrImplOrRandom(
		CAI,
		hoi3.TYPE_BOOLEAN,
		"HasUserExtension"
	)
end

---
-- @since 1.4
-- @param number automationtype
-- @return bool
-- @static
function CAI.IsAIControlledForPlayer(automationtype)
	hoi3.assertParameterType(1, automationtype, hoi3.TYPE_NUMBER)
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsAIControlledForPlayer',
		automationtype
	)	
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAI:IsInfluencing(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsInfluencing',
		countryTagA, 
		countryTagB
	)
end

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool
function CAI:IsTradeingAwayNeededResource(route)
	hoi3.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsTradeingAwayNeededResource',
		route
	)
end

---
-- @since 1.3
-- @return unknown
function CAI:MoveToNeighbor(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAI:MoveUnit(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAI:RequestSubUnit(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCommand command
-- @return void
function CAI:Post(command)
	hoi3.assertParameterType(1, command, 'CCommand')
	
	--TODO: do log something in here through dtools. It is quite interresting to 
	--have a function posted.
end

---
-- @since 1.3
-- @param CAction action
-- @return void
function CAI:PostAction(action)
	hoi3.assertParameterType(1, action, 'CAction')
	
	--TODO: do log something in here through dtools. It is quite interresting to 
	--have a function posted.
end

---
-- @since 1.3
-- @param string message
-- @return void
function CAI:PrintConsole(message)
	hoi3.assertParameterType(1, message, hoi3.TYPE_STRING)
	
	print(message)
	dtools.info(message)
end