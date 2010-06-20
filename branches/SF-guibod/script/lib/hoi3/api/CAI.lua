require('hoi3.Hoi3Object')

CAIObject = Hoi3Object:subclass('hoi3.CAIObject')

--- 
-- @since 1.4
CAIObject._DIPLOMACY_	= 1 

--- 
-- @since 1.4
CAIObject._INTELLIGENCE_ = 2

--- 
-- @since 1.4
CAIObject._POLITICS_ = 3

--- 
-- @since 1.4
CAIObject._PRODUCTION_ = 4

--- 
-- @since 1.4
CAIObject._TECHNOLOGY_ = 5

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
function CAIObject:AlreadyTradingDisabledResource(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	Hoi3Object.throwNotYetImplemented()
end 

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool 
function CAIObject:AlreadyTradingResourceOtherWay(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	Hoi3Object.throwNotYetImplemented()
end 

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAIObject:CanDeclareWar(countryTagA,  countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAIObject:CanTradeFreeResources(countryTagA,  countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number needs
-- @param number goodsType
-- @return CFixedPoint
function CAIObject:EvaluateCancelTrades(needs,  goodsType)
	Hoi3Object.assertParameterType(1, needs, 'number')
	Hoi3Object.assertParameterType(2, goodsType, 'number')
	
	assert(goodsType < CGoodsPool._GC_NUMOF_ + 1, string.format("goodsType must be lower than %d", CGoodsPool._GC_NUMOF_ + 1))
	assert(goodsType > 0, string.format("goodsType must be greater than %d", 0))
		
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
function CAIObject:GetAmountTradedFrom(goodsType, from,  to)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.assertParameterType(2, from, 'CCountryTag')
	Hoi3Object.assertParameterType(3, to, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountry
function CAIObject:GetCountry(x)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCountry countryA
-- @param CCountry countryB
-- @return CFixedPoint
function CAIObject:GetCountryAlignmentDistance(countryA, countryB)
	Hoi3Object.assertParameterType(1, countryA, 'CCountry')
	Hoi3Object.assertParameterType(2, countryB, 'CCountry')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CDate
-- @static
function CAIObject.GetCurrentDate()
	return CDateObject:new()
end

---
-- @since 1.3
-- @return string
-- @static
function CAIObject.GetCommonModDirectory()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CArrayFix
function CAIObject:GetDeployedSubUnitCounts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return string
-- @static
function CAIObject.GetModDirectory()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountry country
-- @param CFaction faction
-- @return CFixedPoint
function CAIObject:GetNormalizedAlignmentDistance(country, faction)
	Hoi3Object.assertParameterType(1, country, 'CCountry')
	Hoi3Object.assertParameterType(2, faction, 'CFaction')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return number
function CAIObject:GetNumberOfOwnedProvinces(countryTag)
	Hoi3Object.assertParameterType(1, country, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CArrayFix
function CAIObject:GetProductionSubUnitCounts(countryTag)
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CList_CSubUnitConstructionEntry
function CAIObject:GetReqProdQueue()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CSubUnitConstructionEntry>
function CAIObject:GetReqProdQueueIter()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CDiplomacyStatus
function CAIObject:GetRelation(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CDiplomacyStatus
function CAIObject:GetSpamPenalty(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CArrayFix
function CAIObject:GetTheatreSubUnitNeedCounts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CArrayFix
function CAIObject:GetTheatreSubUnitNeedCounts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
-- @static
function CAIObject.HasCommonExtension()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return bool
function CAIObject:HasFilledProdQueue()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param  CTradeRoute route
-- @return bool
function CAIObject:HasTradeGoneStale(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
-- @static
function CAIObject.HasUserExtension()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param number automationtype
-- @return bool
-- @static
function CAIObject.IsAIControlledForPlayer(automationtype)
	Hoi3Object.assertParameterType(1, automationtype, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return bool
function CAIObject:IsInfluencing(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTradeRoute route
-- @return bool
function CAIObject:IsTradeingAwayNeededResource(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CAIObject:MoveToNeighbor(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAIObject:MoveUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return unknown
function CAIObject:RequestSubUnit(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CCommand command
-- @return void
function CAIObject:Post(command)
	Hoi3Object.assertParameterType(1, command, 'CCommand')
	
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CAction action
-- @return void
function CAIObject:PostAction(action)
	Hoi3Object.assertParameterType(1, action, 'CAction')
	
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param string message
-- @return void
function CAIObject:PrintConsole(message)
	Hoi3Object.assertParameterType(1, message, 'string')
	
	Hoi3Object.throwUnknownSignature()
end

-- CAI has static methods and properties
-- we need to declare a CAI table 
CAI = CAIObject