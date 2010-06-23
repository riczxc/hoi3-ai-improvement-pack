require('hoi3')

module("hoi3.api", package.seeall)

CCountry = hoi3.MultitonObject:subclass('hoi3.CCountry')

---
-- @param CCountryTag countryTag
function CCountry:initalize(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyOrganization()
	return self:loadResultOrImplOrRandom(
		'CIdeology',
		'AccessIdeologyOrganization'
	)
end

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyPopularity()
	return self:loadResultOrImplOrRandom(
		'CIdeology',
		'AccessIdeologyPopularity'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalcDesperation()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'CalcDesperation'
	)
end

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
function CCountry:CalculateIsAllied(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'CalculateIsAllied',
		countryTag
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:CalculateNumberOfActiveInfluences()
	return self:loadResultOrImplOrRandom(
		'number',
		'CalculateNumberOfActiveInfluences'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalculateReinforcementMultiplier()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'CalculateReinforcementMultiplier'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountry:CanCreatePuppet()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'CanCreatePuppet'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountry:Exists()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'Exists'
	)
end

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
function CCountry:GetAbility(category)
	hoi3.assertParameterType(1, category, 'CTechnologyCategory')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'GetAbility',
		category
	)
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetActingCapitalLocation()
	return self:loadResultOrImplOrRandom(
		'CProvince',
		'GetActingCapitalLocation'
	)
end

---
-- @since 1.3
-- @return table<CProvince> 
function CCountry:GetAirBases()
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetAirBases'
	)
end

---
-- @since 1.3
-- @return CAlignment 
function CCountry:GetAlignment()
	return self:loadResultOrImplOrRandom(
		'CAlignment',
		'GetAlignment'
	)
end

---
-- @since 1.3
-- @return unknown 
function CCountry:GetAlignmentCord()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetAllowedResearchSlots()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetAllowedResearchSlots'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetAvailableIC()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetAvailableIC'
	)
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
function CCountry:GetBuildCost(building)
	hoi3.assertParameterType(1, building, 'CBuilding')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetBuildCost',
		building
	)
end

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
function CCountry:GetBuildCostIC(pUnit, quantity, buildReserve)
	hoi3.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	hoi3.assertParameterType(2, quantity, 'number')
	hoi3.assertParameterType(3, buildReserve, 'boolean')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetBuildCostIC',
		pUnit, 
		quantity, 
		buildReserve
	)
end

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
function CCountry:GetBuildCostMP(pUnit, quantity, buildReserve)
	hoi3.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	hoi3.assertParameterType(2, quantity, 'number')
	hoi3.assertParameterType(3, buildReserve, 'boolean')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetBuildCostMP',
		pUnit, 
		quantity, 
		buildReserve
	)
end

---
-- @since 1.3
-- @return unknown 
function CCountry:GetBuildTime(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number  
function CCountry:GetCapital()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetCapital'
	)
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetCapitalLocation()
	return self:loadResultOrImplOrRandom(
		'CProvince',
		'GetCapitalLocation'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetControlledProvinces()
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetControlledProvinces'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetCoreProvinces()
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetCoreProvinces'
	)
end

---
-- @since 2.0
-- @return table<CConstruction>
function CCountry:GetConstructions()
	return self:loadResultOrImplOrRandom(
		'table<CConstruction>',
		'GetConstructions'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildCost()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetConvoyBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildTime()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetConvoyBuildTime'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedIn()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetConvoyedIn'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedOut()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetConvoyedOut'
	)
end

---
-- @since 1.3
-- @return table<CConvoy> 
function CCountry:GetConvoys()
	return self:loadResultOrImplOrRandom(
		'table<CConvoy>',
		'GetConvoys'
	)
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountry:GetCountryTag()
	return self.countryTag
end

---
-- @since 1.3
-- @return table<CCountryTag> 
function CCountry:GetCurrentAtWarWith()
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetCurrentAtWarWith'
	)
end

---
-- @since 1.4
-- @return table<CTechnology>
function CCountry:GetCurrentResearch()
	return self:loadResultOrImplOrRandom(
		'table<CTechnology>',
		'GetCurrentResearch'
	)
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyBalance(goodIndex)
	hoi3.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDailyBalance',
		goodIndex
	)
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyExpense(goodIndex)
	hoi3.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDailyExpense',
		goodIndex
	)
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyIncome(goodIndex)
	hoi3.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDailyIncome',
		goodIndex
	)
end

---
-- @since 1.3
-- @return table<CDiplomacyStatus>
function CCountry:GetDiplomacy()
	return self:loadResultOrImplOrRandom(
		'table<CDiplomacyStatus>',
		'GetDiplomacy'
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CCountry:GetDiplomaticDistance(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDiplomaticDistance',
		countryTag
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDiplomaticInfluence()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDiplomaticInfluence'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDissent()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDissent'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEffectiveNeutrality()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEffectiveNeutrality'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildCost()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEscortBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildTime()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEscortBuildTime'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetEscorts()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetEscorts'
	)
end

---
-- @since 1.3
-- @return CFaction
function CCountry:GetFaction()
	return self:loadResultOrImplOrRandom(
		'CFaction',
		'GetFaction'
	)
end

---
-- @since 1.3
-- @return CModifier
function CCountry:GetGlobalModifier()
	return self:loadResultOrImplOrRandom(
		'CModifier',
		'GetGlobalModifier'
	)
end

---
-- @since 1.3
-- @return CGovernment
function CCountry:GetGovernment()
	return self:loadResultOrImplOrRandom(
		'CGovernment',
		'GetGovernment'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetHighestThreat()
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetHighestThreat'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetHomeProduced()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetHomeProduced'
	)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
function CCountry:GetICPart(distributionSetting)
	hoi3.assertParameterType(1, distributionSetting, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetICPart',
		distributionSetting
	)
end

---
-- @since 1.3
-- @param CLawGroup lawGroup
-- @return CLaw
function CCountry:GetLaw(lawGroup)
	hoi3.assertParameterType(1, lawGroup, 'CLawGroup')
	
	return self:loadResultOrImplOrRandom(
		'CLaw',
		'GetLaw',
		lawGroup
	)
end

---
-- @since 1.3
-- @param number groupIndex
-- @return CLaw
function CCountry:GetLawFromIndex(groupIndex)
	hoi3.assertParameterType(1, groupIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CLaw',
		'GetLawFromIndex',
		groupIndex
	)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountry:GetLeadershipDistributionAt(distributionSetting)
	hoi3.assertParameterType(1, distributionSetting, 'number')

	return self:loadResultOrImplOrRandom(
		'CDistributionSetting',
		'GetLeadershipDistributionAt',
		distributionSetting
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetManpower()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetManpower'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetMaxIC()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetMaxIC'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
function CCountry:GetMaxNeutralityForWarWith(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')

	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetMaxNeutralityForWarWith',
		countryTag
	)
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CMinister
function CCountry:GetMinister(positionIndex)
	hoi3.assertParameterType(1, positionIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'CMinister',
		'GetMinister',
		positionIndex
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetMoneyBalanceAverage()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetMoneyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNationalUnity()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetNationalUnity'
	)
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountry:GetNavalBases()
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetNavalBases'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetNeighbours()
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetNeighbours'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNeutrality()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetNeutrality'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfControlledProvinces()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumberOfControlledProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfCurrentResearch()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumberOfCurrentResearch'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfOwnedProvinces()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumberOfOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAllies()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumOfAllies'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAirfields()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumOfAirfields'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetNumOfPorts()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetNumOfPorts'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetOfficerRatio()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetOfficerRatio'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetOverlord()
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetOverlord'
	)
end

---
-- @since 1.3
-- @return table<number>
function CCountry:GetOwnedProvinces()
	return self:loadResultOrImplOrRandom(
		'table<number>',
		'GetOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return CGoodsPool
function CCountry:GetPool()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetPool'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossibleLiberations()
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetPossibleLiberations'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossiblePuppets()
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetPossiblePuppets'
	)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountry:GetProductionDistributionAt(distributionSetting)
	hoi3.assertParameterType(1, distributionSetting, 'CDistributionSetting')
	
	return self:loadResultOrImplOrRandom(
		'number',
		'GetProductionDistributionAt',
		distributionSetting
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
function CCountry:GetRelation(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CDiplomacyStatus',
		'GetRelation',
		countryTag
	)
end

---
-- @since 1.3
-- @return CRule
function CCountry:GetRules()
	return self:loadResultOrImplOrRandom(
		'CRule',
		'GetRules'
	)
end

---
-- @since 1.3
-- @return CIdeology
function CCountry:GetRulingIdeology()
	return self:loadResultOrImplOrRandom(
		'CIdeology',
		'GetRulingIdeology'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
function CCountry:GetSpyPresence(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'CSpyPresence',
		'GetSpyPresence',
		countryTag
	)
end

---
-- @since 2.0
-- @return table<CCountryTag>
function CCountry:GetSpyingOnUs()
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetSpyingOnUs'
	)
end

---
-- @since 1.3
-- @return CStrategicWarfare
function CCountry:GetStrategicWarfare()
	return self:loadResultOrImplOrRandom(
		'CStrategicWarfare',
		'GetStrategicWarfare'
	)
end

---
-- @since 1.3
-- @return CAIStrategy
function CCountry:GetStrategy()
	return self:loadResultOrImplOrRandom(
		'CAIStrategy',
		'GetStrategy'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSupplyBalanceAverage()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetSupplyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSurrenderLevel()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetSurrenderLevel'
	)
end

---
-- @since 1.3
-- @return CTechnologyStatus
function CCountry:GetTechnologyStatus()
	return self:loadResultOrImplOrRandom(
		'CTechnologyStatus',
		'GetTechnologyStatus'
	)
end

---
-- @since 2.0
-- @return number 
function CCountry:GetTotalConvoyTransports()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTotalConvoyTransports'
	)
end

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
function CCountry:GetTotalCoreBuildingLevels(buildingIndex)
	hoi3.assertParameterType(1, buildingIndex, 'number')
	
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTotalCoreBuildingLevels',
		buildingIndex
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalIC()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTotalIC'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetTotalLeadership()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetTotalLeadership'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededConvoyTransports()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTotalNeededConvoyTransports'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededTransports()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTotalNeededTransports'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTotalProduced()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTotalProduced'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedAway()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedAway'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedAwaySansAlliedSupply()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedAwaySansAlliedSupply'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedFor()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedFor'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedForSansAlliedSupply()
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedForSansAlliedSupply'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTransports()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetTransports'
	)
end

---
-- @since 1.4
-- @return CUnitList
function CCountry:GetUnits()
	return self:loadResultOrImplOrRandom(
		'CUnitList',
		'GetUnits'
	)
end

---
-- @since 1.4
-- @return table<CUnit>
function CCountry:GetUnitsIterator()
	return self:loadResultOrImplOrRandom(
		'table<CUnit>',
		'GetUnitsIterator'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetUsedIC()
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetUsedIC'
	)
end

---
-- @since 1.4
-- @param string key
-- @return CFixedPoint
function CCountry:GetVariable(key)
	hoi3.assertParameterType(1, key, 'string')
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetVariable'
	)
end

---
-- @since 1.4
-- @return CVariables
function CCountry:GetVariables()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetVassals()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:HasConstruction()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'HasConstruction'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:HasDiplomatEnroute(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'HasDiplomatEnroute',
		countryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:HasExtraManpowerLeft()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'HasExtraManpowerLeft'
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:HasFaction()
	-- FIXME, check CFaction instead ?
	return self:loadResultOrImplOrRandom(
		'boolean',
		'HasFaction'
	)
end

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
function CCountry:HasNeighborInFaction(faction)
	hoi3.assertParameterType(1, faction, 'CFaction')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'HasNeighborInFaction',
		faction
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsAtWar()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsAtWar'
	)
end

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
function CCountry:IsBuildingAllowed(building, province)
	hoi3.assertParameterType(1, building, 'CBuilding')
	hoi3.assertParameterType(2, province, 'CProvince')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsBuildingAllowed',
		building, 
		province
	)
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountry:IsEnemy(otherCountryTag)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsEnemy',
		otherCountryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsFactionLeader()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsFactionLeader'
	)
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @param bool unknownFlag
-- @return bool
function CCountry:IsFriend(otherCountryTag, unknownFlag)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	hoi3.assertParameterType(2, unknownFlag, 'boolean')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsFriend',
		otherCountryTag, 
		unknownFlag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsGovernmentInExile()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsGovernmentInExile'
	)
end

---
-- Is current country Major ?
--
-- Is total IC > 60 ?
-- @since 1.3
-- @return bool
function CCountry:IsMajor()
	return CCountry:GetTotalIC() >= 60
end

---
-- @since 1.3
-- @return bool
function CCountry:IsMobilized()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsMobilized'
	)
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountry:IsNeighbour(otherCountryTag)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsNeighbour',
		otherCountryTag
	)
end

---
-- @since 1.3
-- @param CFaction  faction
-- @param bool unknownFlag
-- @return bool
function CCountry:IsNeighbourToFactionHostile(faction, unknownFlag)
	hoi3.assertParameterType(1, faction, 'CFaction')
	hoi3.assertParameterType(2, unknownFlag, 'boolean')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsNeighbourToFactionHostile',
		faction, 
		unknownFlag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:isPuppet()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'isPuppet',
		faction, 
		unknownFlag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsSubject()
	return self:loadResultOrImplOrRandom(
		'boolean',
		'IsSubject'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:NeedConvoyToTradeWith(countryTag)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		'boolean',
		'NeedConvoyToTradeWith',
		countryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:MayLiberateCountries()
	-- TODO: Interrogate Politic Minister 
	return self:loadResultOrImplOrRandom(
		'boolean',
		'MayLiberateCountries'
	)
end


function CCountry.random()
	return CCountry:new(CCountryTag.random())
end