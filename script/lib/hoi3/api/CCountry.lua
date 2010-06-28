require('hoi3')

module("hoi3.api", package.seeall)

CCountry = hoi3.MultitonObject:subclass('hoi3.CCountry')

---
-- @param CCountryTag countryTag
function CCountry:initalize(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	self.countryTag = countryTag
end

---
-- @since 1.3
-- @return CIdeology 
hoi3.f(CCountry, 'AccessIdeologyOrganization', false, 'CIdeology')

---
-- @since 1.3
-- @return CIdeology 
hoi3.f(CCountry, 'AccessIdeologyPopularity', false, 'CIdeology')

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'CalcDesperation', false, 'CFixedPoint')

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
hoi3.f(CCountry, 'CalculateIsAllied', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'CalculateNumberOfActiveInfluences', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'CalculateReinforcementMultiplier', false, 'CFixedPoint')

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountry, 'CanCreatePuppet', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountry, 'Exists', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
hoi3.f(CCountry, 'GetAbility', false, hoi3.TYPE_BOOLEAN, 'CTechnologyCategory')

---
-- @since 1.3
-- @return CProvince 
hoi3.f(CCountry, 'GetActingCapitalLocation', false, 'CProvince')

---
-- @since 1.3
-- @return table<CProvince> 
hoi3.f(CCountry, 'GetAirBases', false, 'table<CProvince>')

---
-- @since 1.3
-- @return CAlignment 
hoi3.f(CCountry, 'GetAlignment', false, 'CAlignment')

---
-- @since 1.3
-- @return unknown 
hoi3.f(CCountry, 'GetAlignmentCord', false, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetAllowedResearchSlots', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetAvailableIC', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetBuildCost', false, 'CFixedPoint', 'CBuilding')

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
function CCountry:GetBuildCostIC(pUnit, quantity, buildReserve)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	hoi3.assertParameterType(2, quantity, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(3, buildReserve, hoi3.TYPE_BOOLEAN)
	
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	hoi3.assertParameterType(2, quantity, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(3, buildReserve, hoi3.TYPE_BOOLEAN)
	
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
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number  
function CCountry:GetCapital()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetCapital'
	)
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetCapitalLocation()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CProvince',
		'GetCapitalLocation'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetControlledProvinces()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetControlledProvinces'
	)
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetCoreProvinces()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetCoreProvinces'
	)
end

---
-- @since 2.0
-- @return table<CConstruction>
function CCountry:GetConstructions()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CConstruction>',
		'GetConstructions'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildCost()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetConvoyBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildTime()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetConvoyBuildTime'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedIn()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetConvoyedIn'
	)
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedOut()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetConvoyedOut'
	)
end

---
-- @since 1.3
-- @return table<CConvoy> 
function CCountry:GetConvoys()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CConvoy>',
		'GetConvoys'
	)
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountry:GetCountryTag()
	hoi3.assertNonStatic(self)
	return self.countryTag
end

---
-- @since 1.3
-- @return table<CCountryTag> 
function CCountry:GetCurrentAtWarWith()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetCurrentAtWarWith'
	)
end

---
-- @since 1.4
-- @return table<CTechnology>
function CCountry:GetCurrentResearch()
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, goodIndex, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, goodIndex, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, goodIndex, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDiplomaticInfluence'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDissent()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetDissent'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEffectiveNeutrality()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEffectiveNeutrality'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildCost()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEscortBuildCost'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildTime()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetEscortBuildTime'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetEscorts()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGovernment',
		'GetGovernment'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetHighestThreat()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetHighestThreat'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetHomeProduced()
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, distributionSetting, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, groupIndex, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, distributionSetting, hoi3.TYPE_NUMBER)

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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetManpower'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetMaxIC()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetMaxIC'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
function CCountry:GetMaxNeutralityForWarWith(countryTag)
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, positionIndex, hoi3.TYPE_NUMBER)
	
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetMoneyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNationalUnity()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetNationalUnity'
	)
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountry:GetNavalBases()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CProvince>',
		'GetNavalBases'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetNeighbours()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetNeighbours'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNeutrality()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetNeutrality'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfControlledProvinces()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumberOfControlledProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfCurrentResearch()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumberOfCurrentResearch'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfOwnedProvinces()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumberOfOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAllies()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumOfAllies'
	)
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAirfields()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumOfAirfields'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetNumOfPorts()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetNumOfPorts'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetOfficerRatio()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetOfficerRatio'
	)
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetOverlord()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetOverlord'
	)
end

---
-- @since 1.3
-- @return table<number>
function CCountry:GetOwnedProvinces()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<number>',
		'GetOwnedProvinces'
	)
end

---
-- @since 1.3
-- @return CGoodsPool
function CCountry:GetPool()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetPool'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossibleLiberations()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetPossibleLiberations'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossiblePuppets()
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, distributionSetting, 'CDistributionSetting')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetProductionDistributionAt',
		distributionSetting
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
function CCountry:GetRelation(countryTag)
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CRule',
		'GetRules'
	)
end

---
-- @since 1.3
-- @return CIdeology
function CCountry:GetRulingIdeology()
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetSpyingOnUs'
	)
end

---
-- @since 1.3
-- @return CStrategicWarfare
function CCountry:GetStrategicWarfare()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CStrategicWarfare',
		'GetStrategicWarfare'
	)
end

---
-- @since 1.3
-- @return CAIStrategy
function CCountry:GetStrategy()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CAIStrategy',
		'GetStrategy'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSupplyBalanceAverage()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetSupplyBalanceAverage'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSurrenderLevel()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetSurrenderLevel'
	)
end

---
-- @since 1.3
-- @return CTechnologyStatus
function CCountry:GetTechnologyStatus()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CTechnologyStatus',
		'GetTechnologyStatus'
	)
end

---
-- @since 2.0
-- @return number 
function CCountry:GetTotalConvoyTransports()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTotalConvoyTransports'
	)
end

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
function CCountry:GetTotalCoreBuildingLevels(buildingIndex)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, buildingIndex, hoi3.TYPE_NUMBER)
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTotalCoreBuildingLevels',
		buildingIndex
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalIC()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTotalIC'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetTotalLeadership()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetTotalLeadership'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededConvoyTransports()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTotalNeededConvoyTransports'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededTransports()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTotalNeededTransports'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTotalProduced()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTotalProduced'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedAway()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedAway'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedAwaySansAlliedSupply()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedAwaySansAlliedSupply'
	)
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedFor()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedFor'
	)
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedForSansAlliedSupply()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CGoodsPool',
		'GetTradedForSansAlliedSupply'
	)
end

---
-- @since 1.3
-- @return number
function CCountry:GetTransports()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetTransports'
	)
end

---
-- @since 1.4
-- @return CUnitList
function CCountry:GetUnits()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CUnitList',
		'GetUnits'
	)
end

---
-- @since 1.4
-- @return table<CUnit>
function CCountry:GetUnitsIterator()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CUnit>',
		'GetUnitsIterator'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetUsedIC()
	hoi3.assertNonStatic(self)
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetVariable'
	)
end

---
-- @since 1.4
-- @return CVariables
function CCountry:GetVariables()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'CVariables',
		'GetVariables'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetVassals()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetVassals'
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:HasConstruction()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasConstruction'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:HasDiplomatEnroute(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasDiplomatEnroute',
		countryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:HasExtraManpowerLeft()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasExtraManpowerLeft'
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:HasFaction()
	hoi3.assertNonStatic(self)
	-- FIXME, check CFaction instead ?
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasFaction'
	)
end

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
function CCountry:HasNeighborInFaction(faction)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, faction, 'CFaction')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'HasNeighborInFaction',
		faction
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsAtWar()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsAtWar'
	)
end

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
function CCountry:IsBuildingAllowed(building, province)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, building, 'CBuilding')
	hoi3.assertParameterType(2, province, 'CProvince')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsEnemy',
		otherCountryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsFactionLeader()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsFactionLeader'
	)
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @param bool unknownFlag
-- @return bool
function CCountry:IsFriend(otherCountryTag, unknownFlag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	hoi3.assertParameterType(2, unknownFlag, hoi3.TYPE_BOOLEAN)
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsFriend',
		otherCountryTag, 
		unknownFlag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsGovernmentInExile()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
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
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsMajor'
	)
end

function CCountry:IsMajorImpl()
	hoi3.assertNonStatic(self)
	return self:GetTotalIC() >= 60
end

---
-- @since 1.3
-- @return bool
function CCountry:IsMobilized()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsMobilized'
	)
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountry:IsNeighbour(otherCountryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, faction, 'CFaction')
	hoi3.assertParameterType(2, unknownFlag, hoi3.TYPE_BOOLEAN)
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsNeighbourToFactionHostile',
		faction, 
		unknownFlag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:isPuppet()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'isPuppet'
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:IsSubject()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsSubject'
	)
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountry:NeedConvoyToTradeWith(countryTag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'NeedConvoyToTradeWith',
		countryTag
	)
end

---
-- @since 1.3
-- @return bool
function CCountry:MayLiberateCountries()
	hoi3.assertNonStatic(self)
	-- TODO: Interrogate Politic Minister 
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'MayLiberateCountries'
	)
end


function CCountry.random()
	return CCountry:new(CCountryTag.random())
end