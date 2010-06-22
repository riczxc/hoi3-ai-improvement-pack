require('hoi3.MultitonObject')

CAI = MultitonObject:subclass('hoi3.CAI')

---
-- @param CCountryTag countryTag
function CAI:initalize(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
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
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrFakeOrRandom(
		'boolean', 
		"AlreadyTradingDisabledResource", 
		route
	)
end

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
function CAI:AlreadyTradingResourceOtherWay(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrFakeOrRandom(
		'boolean', 
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
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'boolean', 
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
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'boolean', 
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
	Hoi3Object.assertParameterType(1, needs, 'number')
	Hoi3Object.assertParameterType(2, goodsType, 'number')

	assert(goodsType < CGoodsPool._GC_NUMOF_ + 1, string.format("goodsType must be lower than %d", CGoodsPool._GC_NUMOF_ + 1))
	assert(goodsType > 0, string.format("goodsType must be greater than %d", 0))
	
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint', 
		"EvaluateCancelTrades", 
		needs,  
		goodsType
	)
end

function CAI:EvaluateCancelTradesFake(needs, goodsType)
	-- Simulate trade cancelation
	if needs > 0 then
	   return needs - 1
	else
	   return needs + 1
	end
end


---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag from
-- @param CCountryTag to
-- @return CFixedPoint
function CAI:GetAmountTradedFrom(goodsType, from,  to)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.assertParameterType(2, from, 'CCountryTag')
	Hoi3Object.assertParameterType(3, to, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountry countryA
-- @param CCountry countryB
-- @return CFixedPoint
function CAI:GetCountryAlignmentDistance(countryA, countryB)
	Hoi3Object.assertParameterType(1, countryA, 'CCountry')
	Hoi3Object.assertParameterType(2, countryB, 'CCountry')
	
	return self:loadResultOrFakeOrRandom(
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
	return CAI.loadResultOrFakeOrRandom(
		--loadResultOrFake is used statically, we pass "self" paramater as class reference
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
	return CAI.loadResultOrFakeOrRandom(
		CAI,
		'string',
		"GetCommonModDirectory"
	)
end

---
-- @since 2.0
-- @return CArrayFix
function CAI:GetDeployedSubUnitCounts()
	return self:loadResultOrFakeOrRandom(
		'CArrayFix',
		"GetDeployedSubUnitCounts"
	)
end

---
-- @since 1.3
-- @return string
-- @static
function CAI.GetModDirectory()
	return CAI.loadResultOrFakeOrRandom(
		CAI,
		'string',
		"GetModDirectory"
	)
end

---
-- @since 1.3
-- @param CCountry country
-- @param CFaction faction
-- @return CFixedPoint
function CAI:GetNormalizedAlignmentDistance(country, faction)
	Hoi3Object.assertParameterType(1, country, 'CCountry')
	Hoi3Object.assertParameterType(2, faction, 'CFaction')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, country, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'number',
		"GetNumberOfOwnedProvinces",
		countryTag
	)
end

---
-- @since 2.0
-- @return 
function CAI:GetProductionSubUnitCounts()
	return self:loadResultOrFakeOrRandom(
		'CArrayFix',
		"GetProductionSubUnitCounts"
	)
end

---
-- @since 1.3
-- @return CSubUnitConstructionEntryList
function CAI:GetReqProdQueue()
	return self:loadResultOrFakeOrRandom(
		'CSubUnitConstructionEntryList',
		"GetReqProdQueue"
	)
end

---
-- @since 1.3
-- @return table<CSubUnitConstructionEntry>
function CAI:GetReqProdQueueIter()
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		"number",
		"GetSpamPenalty",
		countryTag
	)
end

---
-- @since 2.0
-- @return CArrayFix
function CAI:GetTheatreSubUnitNeedCounts()
	return self:loadResultOrFakeOrRandom(
		"CArrayFix",
		"GetTheatreSubUnitNeedCounts"
	)
end

---
-- @since 1.3
-- @return bool
-- @static
function CAI.HasCommonExtension()
	return CAI.loadResultOrFakeOrRandom(
		CAI,
		'boolean',
		"HasCommonExtension"
	)
end

---
-- @since 1.4
-- @return bool
function CAI:HasFilledProdQueue()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'HasFilledProdQueue'
	)
end

---
-- @since 1.3
-- @param  CTradeRoute route
-- @return bool
function CAI:HasTradeGoneStale(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'HasTradeGoneStale',
		route
	)	
end

---
-- @since 1.3
-- @return bool
-- @static
function CAI.HasUserExtension()
	return CAI.loadResultOrFakeOrRandom(
		CAI,
		'boolean',
		"HasUserExtension"
	)
end

---
-- @since 1.4
-- @param number automationtype
-- @return bool
-- @static
function CAI.IsAIControlledForPlayer(automationtype)
	Hoi3Object.assertParameterType(1, automationtype, 'number')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
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
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
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
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'IsTradeingAwayNeededResource',
		route
	)
end

---
-- @since 1.3
-- @return unknown
function CAI:MoveToNeighbor(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAI:MoveUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAI:RequestSubUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCommand command
-- @return void
function CAI:Post(command)
	Hoi3Object.assertParameterType(1, command, 'CCommand')
	
	--TODO: do log something in here through dtools. It is quite interresting to 
	--have a function posted.
end

---
-- @since 1.3
-- @param CAction action
-- @return void
function CAI:PostAction(action)
	Hoi3Object.assertParameterType(1, action, 'CAction')
	
	--TODO: do log something in here through dtools. It is quite interresting to 
	--have a function posted.
end

---
-- @since 1.3
-- @param string message
-- @return void
function CAI:PrintConsole(message)
	Hoi3Object.assertParameterType(1, message, 'string')
	
	print(message)
	dtools.info(message)
end