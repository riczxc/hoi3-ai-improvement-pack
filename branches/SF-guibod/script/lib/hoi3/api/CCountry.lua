require('hoi3.MultitonObject')

CCountry = MultitonObject:subclass('hoi3.CCountry')

---
-- @param CCountryTag countryTag
function CCountry:initalize(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyOrganization()
	return self:loadResultOrFakeOrRandom(
		'CIdeology',
		'AccessIdeologyOrganization'
	)
end

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyPopularity()
	return self:loadResultOrFakeOrRandom(
		'CIdeology',
		'AccessIdeologyPopularity'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalcDesperation()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'CalcDesperation'
	)
end

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
function CCountry:CalculateIsAllied(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'CalculateIsAllied',
		countryTag
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:CalculateNumberOfActiveInfluences()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CalculateNumberOfActiveInfluences'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalculateReinforcementMultiplier()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'CalculateReinforcementMultiplier'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountry:CanCreatePuppet()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'CanCreatePuppet'
	)
end

---
-- @since 1.3
-- @return bool 
function CCountry:Exists()
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'Exists'
	)
end

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
function CCountry:GetAbility(category)
	Hoi3Object.assertParameterType(1, category, 'CTechnologyCategory')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'GetAbility',
		category
	)
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetActingCapitalLocation()
	return self:loadResultOrFakeOrRandom(
		'CProvince',
		'GetActingCapitalLocation'
	)
end

---
-- @since 1.3
-- @return table<CProvince> 
function CCountry:GetAirBases()
	return self:loadResultOrFakeOrRandom(
		'table<CProvince>',
		'GetAirBases'
	)
end

---
-- @since 1.3
-- @return CAlignment 
function CCountry:GetAlignment()
	return self:loadResultOrFakeOrRandom(
		'CAlignment',
		'GetAlignment'
	)
end

---
-- @since 1.3
-- @return unknown 
function CCountry:GetAlignmentCord()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetAllowedResearchSlots()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetAllowedResearchSlots'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetAvailableIC()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetAvailableIC'
	)
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
function CCountry:GetBuildCost(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	Hoi3Object.assertParameterType(2, quantity, 'number')
	Hoi3Object.assertParameterType(3, buildReserve, 'boolean')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	Hoi3Object.assertParameterType(2, quantity, 'number')
	Hoi3Object.assertParameterType(3, buildReserve, 'boolean')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number  
function CCountry:GetCapital()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetCapital'
	)
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetCapitalLocation()
	return self:loadResultOrFakeOrRandom(
		'CProvince',
		'GetCapitalLocation'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetControlledProvinces()
	return self:loadResultOrFakeOrRandom(
		'table<CProvince>',
		'GetControlledProvinces'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetCoreProvinces()
	return self:loadResultOrFakeOrRandom(
		'table<CProvince>',
		'GetCoreProvinces'
	)
end

---
-- @since 2.0
-- @return table<CConstruction>
function CCountry:GetConstructions()
	return self:loadResultOrFakeOrRandom(
		'table<CConstruction>',
		'GetConstructions'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildCost()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetConvoyBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildTime()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetConvoyBuildTime'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedIn()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetConvoyedIn'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedOut()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetConvoyedOut'
	)
end

---
-- @since 1.3
-- @return table<CConvoy> 
function CCountry:GetConvoys()
	return self:loadResultOrFakeOrRandom(
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
	return self:loadResultOrFakeOrRandom(
		'table<CCountryTag>',
		'GetCurrentAtWarWith'
	)
end

---
-- @since 1.4
-- @return table<CTechnology>
function CCountry:GetCurrentResearch()
	return self:loadResultOrFakeOrRandom(
		'table<CTechnology>',
		'GetCurrentResearch'
	)
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyBalance(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetDailyIncome',
		goodIndex
	)
end

---
-- @since 1.3
-- @return table<CDiplomacyStatus>
function CCountry:GetDiplomacy()
	return self:loadResultOrFakeOrRandom(
		'table<CDiplomacyStatus>',
		'GetDiplomacy'
	)
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CCountry:GetDiplomaticDistance(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetDiplomaticDistance',
		countryTag
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDiplomaticInfluence()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetDiplomaticInfluence'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDissent()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetDissent'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEffectiveNeutrality()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetEffectiveNeutrality'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildCost()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetEscortBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildTime()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetEscortBuildTime'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetEscorts()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetEscorts'
	)
end

---
-- @since 1.3
-- @return CFaction
function CCountry:GetFaction()
	return self:loadResultOrFakeOrRandom(
		'CFaction',
		'GetFaction'
	)
end

---
-- @since 1.3
-- @return CModifier
function CCountry:GetGlobalModifier()
	return self:loadResultOrFakeOrRandom(
		'CModifier',
		'GetGlobalModifier'
	)
end

---
-- @since 1.3
-- @return CGovernment
function CCountry:GetGovernment()
	return self:loadResultOrFakeOrRandom(
		'CGovernment',
		'GetGovernment'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetHighestThreat()
	return self:loadResultOrFakeOrRandom(
		'CCountryTag',
		'GetHighestThreat'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetHomeProduced()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetHomeProduced'
	)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
function CCountry:GetICPart(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, lawGroup, 'CLawGroup')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, groupIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')

	return self:loadResultOrFakeOrRandom(
		'CDistributionSetting',
		'GetLeadershipDistributionAt',
		distributionSetting
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetManpower()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetManpower'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetMaxIC()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetMaxIC'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
function CCountry:GetMaxNeutralityForWarWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')

	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, positionIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
		'CMinister',
		'GetMinister',
		positionIndex
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetMoneyBalanceAverage()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetMoneyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNationalUnity()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetNationalUnity'
	)
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountry:GetNavalBases()
	return self:loadResultOrFakeOrRandom(
		'table<CProvince>',
		'GetNavalBases'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetNeighbours()
	return self:loadResultOrFakeOrRandom(
		'table<CCountryTag>',
		'GetNeighbours'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNeutrality()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetNeutrality'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfControlledProvinces()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumberOfControlledProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfCurrentResearch()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumberOfCurrentResearch'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfOwnedProvinces()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumberOfOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAllies()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumOfAllies'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAirfields()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumOfAirfields'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetNumOfPorts()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetNumOfPorts'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetOfficerRatio()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetOfficerRatio'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetOverlord()
	return self:loadResultOrFakeOrRandom(
		'CCountryTag',
		'GetOverlord'
	)
end

---
-- @since 1.3
-- @return table<number>
function CCountry:GetOwnedProvinces()
	return self:loadResultOrFakeOrRandom(
		'table<number>',
		'GetOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return CGoodsPool
function CCountry:GetPool()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetPool'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossibleLiberations()
	return self:loadResultOrFakeOrRandom(
		'table<CCountryTag>',
		'GetPossibleLiberations'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossiblePuppets()
	return self:loadResultOrFakeOrRandom(
		'table<CCountryTag>',
		'GetPossiblePuppets'
	)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountry:GetProductionDistributionAt(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'CDistributionSetting')
	
	return self:loadResultOrFakeOrRandom(
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
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'CDiplomacyStatus',
		'GetRelation',
		countryTag
	)
end

---
-- @since 1.3
-- @return CRule
function CCountry:GetRules()
	return self:loadResultOrFakeOrRandom(
		'CRule',
		'GetRules'
	)
end

---
-- @since 1.3
-- @return CIdeology
function CCountry:GetRulingIdeology()
	return self:loadResultOrFakeOrRandom(
		'CIdeology',
		'GetRulingIdeology'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
function CCountry:GetSpyPresence(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrFakeOrRandom(
		'CSpyPresence',
		'GetSpyPresence',
		countryTag
	)
end

---
-- @since 2.0
-- @return table<CCountryTag>
function CCountry:GetSpyingOnUs()
	return self:loadResultOrFakeOrRandom(
		'table<CCountryTag>',
		'GetSpyingOnUs'
	)
end

---
-- @since 1.3
-- @return CStrategicWarfare
function CCountry:GetStrategicWarfare()
	return self:loadResultOrFakeOrRandom(
		'CStrategicWarfare',
		'GetStrategicWarfare'
	)
end

---
-- @since 1.3
-- @return CAIStrategy
function CCountry:GetStrategy()
	return self:loadResultOrFakeOrRandom(
		'CAIStrategy',
		'GetStrategy'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSupplyBalanceAverage()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetSupplyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSurrenderLevel()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetSurrenderLevel'
	)
end

---
-- @since 1.3
-- @return CTechnologyStatus
function CCountry:GetTechnologyStatus()
	return self:loadResultOrFakeOrRandom(
		'CTechnologyStatus',
		'GetTechnologyStatus'
	)
end

---
-- @since 2.0
-- @return number 
function CCountry:GetTotalConvoyTransports()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTotalConvoyTransports'
	)
end

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
function CCountry:GetTotalCoreBuildingLevels(buildingIndex)
	Hoi3Object.assertParameterType(1, buildingIndex, 'number')
	
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTotalCoreBuildingLevels',
		buildingIndex
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalIC()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTotalIC'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetTotalLeadership()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetTotalLeadership'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededConvoyTransports()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTotalNeededConvoyTransports'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededTransports()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTotalNeededTransports'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTotalProduced()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetTotalProduced'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedAway()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetTradedAway'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedAwaySansAlliedSupply()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetTradedAwaySansAlliedSupply'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedFor()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetTradedFor'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedForSansAlliedSupply()
	return self:loadResultOrFakeOrRandom(
		'CGoodsPool',
		'GetTradedForSansAlliedSupply'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTransports()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetTransports'
	)
end

---
-- @since 1.4
-- @return CUnitList
function CCountry:GetUnits()
	return self:loadResultOrFakeOrRandom(
		'CUnitList',
		'GetUnits'
	)
end

---
-- @since 1.4
-- @return table<CUnit>
function CCountry:GetUnitsIterator()
	return self:loadResultOrFakeOrRandom(
		'table<CUnit>',
		'GetUnitsIterator'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetUsedIC()
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetUsedIC'
	)
end

---
-- @since 1.4
-- @param string key
-- @return CFixedPoint
function CCountry:GetVariable(key)
	Hoi3Object.assertParameterType(1, key, 'string')
	
	return self:loadResultOrFakeOrRandom(
		'CFixedPoint',
		'GetVariable'
	)
end

---
-- @since 1.4
-- @return CVariables
function CCountry:GetVariables()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetVassals()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:HasConstruction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:HasDiplomatEnroute(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:HasExtraManpowerLeft()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:HasFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
function CCountry:HasNeighborInFaction(faction)
	Hoi3Object.assertParameterType(1, faction, 'CFaction')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsAtWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
function CCountry:IsBuildingAllowed(building, province)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	Hoi3Object.assertParameterType(2, province, 'CProvince')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountry:IsEnemy(otherCountryTag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsFactionLeader()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @param bool unknownFlag
-- @return bool
function CCountry:IsFriend(otherCountryTag, unknownFlag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, unknownFlag, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsGovernmentInExile()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsMajor()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsMobilized()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountry:IsNeighbour(otherCountryTag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFaction  faction
-- @param bool unknownFlag
-- @return bool
function CCountry:IsNeighbourToFactionHostile(faction, unknownFlag)
	Hoi3Object.assertParameterType(1, faction, 'CFaction')
	Hoi3Object.assertParameterType(2, unknownFlag, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:isPuppet()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:IsSubject()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:NeedConvoyToTradeWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountry:MayLiberateCountries()
	Hoi3Object.throwNotYetImplemented()
end