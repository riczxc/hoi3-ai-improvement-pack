require('hoi3.Hoi3Object')

CCountryObject = Hoi3Object:subclass('hoi3.CCountryObject')

---
-- @since 1.3
-- @return CIdeology 
function CCountryObject:AccessIdeologyOrganization()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeology 
function CCountryObject:AccessIdeologyPopularity()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountryObject:CalcDesperation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
function CCountryObject:CalculateIsAllied(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:CalculateNumberOfActiveInfluences()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountryObject:CalculateReinforcementMultiplier()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CCountryObject:CanCreatePuppet()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CCountryObject:Exists()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
function CCountryObject:GetAbility(category)
	Hoi3Object.assertParameterType(1, category, 'CTechnologyCategory')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CProvince 
function CCountryObject:GetActingCapitalLocation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince> 
function CCountryObject:GetAirBases()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CAlignment 
function CCountryObject:GetAlignment()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CCountryObject:GetAlignmentCord()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetAllowedResearchSlots()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetAvailableIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
function CCountryObject:GetBuildCost(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
function CCountryObject:GetBuildCostIC(pUnit, quantity, buildReserve)
	Hoi3Object.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	Hoi3Object.assertParameterType(2, quantity, 'number')
	Hoi3Object.assertParameterType(3, buildReserve, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
function CCountryObject:GetBuildCostMP(pUnit, quantity, buildReserve)
	Hoi3Object.assertParameterType(1, pUnit, 'CSubUnitDefinition')
	Hoi3Object.assertParameterType(2, quantity, 'number')
	Hoi3Object.assertParameterType(3, buildReserve, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown 
function CCountryObject:GetBuildTime(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @return number  
function CCountryObject:GetCapital()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CProvince 
function CCountryObject:GetCapitalLocation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountryObject:GetControlledProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountryObject:GetCoreProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return table<CConstruction>
function CCountryObject:GetConstructions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountryObject:GetConvoyBuildCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountryObject:GetConvoyBuildTime()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountryObject:GetConvoyedIn()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountryObject:GetConvoyedOut()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CConvoy> 
function CCountryObject:GetConvoys()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountryObject:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag> 
function CCountryObject:GetCurrentAtWarWith()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CTechnology>
function CCountryObject:GetCurrentResearch()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountryObject:GetDailyBalance(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountryObject:GetDailyExpense(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountryObject:GetDailyIncome(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CDiplomacyStatus>
function CCountryObject:GetDiplomacy()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CCountryObject:GetDiplomaticDistance(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetDiplomaticInfluence()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetDissent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetEffectiveNeutrality()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetEscortBuildCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetEscortBuildTime()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetEscorts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFaction
function CCountryObject:GetFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CModifier
function CCountryObject:GetGlobalModifier()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CGovernment
function CCountryObject:GetGovernment()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CCountryObject:GetHighestThreat()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountryObject:GetHomeProduced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
function CCountryObject:GetICPart(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CLawGroup lawGroup
-- @return CLaw
function CCountryObject:GetLaw(lawGroup)
	Hoi3Object.assertParameterType(1, lawGroup, 'CLawGroup')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number groupIndex
-- @return CLaw
function CCountryObject:GetLawFromIndex(groupIndex)
	Hoi3Object.assertParameterType(1, groupIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountryObject:GetLeadershipDistributionAt(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetManpower()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetMaxIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
function CCountryObject:GetMaxNeutralityForWarWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CMinister
function CCountryObject:GetMinister(positionIndex)
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetMoneyBalanceAverage()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetNationalUnity()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountryObject:GetNavalBases()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountryObject:GetNeighbours()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetNeutrality()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetNumberOfControlledProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetNumberOfCurrentResearch()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetNumberOfOwnedProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetNumOfAllies()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountryObject:GetNumOfAirfields()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetNumOfPorts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetOfficerRatio()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CCountryObject:GetOverlord()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<number>
function CCountryObject:GetOwnedProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CGoodsPool
function CCountryObject:GetPool()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountryObject:GetPossibleLiberations()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountryObject:GetPossiblePuppets()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountryObject:GetProductionDistributionAt(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'CDistributionSetting')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
function CCountryObject:GetRelation(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CRule
function CCountryObject:GetRules()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeology
function CCountryObject:GetRulingIdeology()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
function CCountryObject:GetSpyPresence(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return table<CCountryTag>
function CCountryObject:GetSpyingOnUs()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CStrategicWarfare
function CCountryObject:GetStrategicWarfare()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CAIStrategy
function CCountryObject:GetStrategy()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetSupplyBalanceAverage()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetSurrenderLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTechnologyStatus
function CCountryObject:GetTechnologyStatus()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return number 
function CCountryObject:GetTotalConvoyTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
function CCountryObject:GetTotalCoreBuildingLevels(buildingIndex)
	Hoi3Object.assertParameterType(1, buildingIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetTotalIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetTotalLeadership()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetTotalNeededConvoyTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetTotalNeededTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountryObject:GetTotalProduced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountryObject:GetTradedAway()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountryObject:GetTradedAwaySansAlliedSupply()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountryObject:GetTradedFor()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountryObject:GetTradedForSansAlliedSupply()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountryObject:GetTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CUnitList
function CCountryObject:GetUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CUnit>
function CCountryObject:GetUnitsIterator()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountryObject:GetUsedIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param string key
-- @return CFixedPoint
function CCountryObject:GetVariable(key)
	Hoi3Object.assertParameterType(1, key, 'string')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CVariables
function CCountryObject:GetVariables()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountryObject:GetVassals()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:HasConstruction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountryObject:HasDiplomatEnroute(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:HasExtraManpowerLeft()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:HasFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
function CCountryObject:HasNeighborInFaction(faction)
	Hoi3Object.assertParameterType(1, faction, 'CFaction')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsAtWar()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
function CCountryObject:IsBuildingAllowed(building, province)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	Hoi3Object.assertParameterType(2, province, 'CProvince')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountryObject:IsEnemy(otherCountryTag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsFactionLeader()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @param bool unknownFlag
-- @return bool
function CCountryObject:IsFriend(otherCountryTag, unknownFlag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, unknownFlag, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsGovernmentInExile()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsMajor()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsMobilized()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
function CCountryObject:IsNeighbour(otherCountryTag)
	Hoi3Object.assertParameterType(1, otherCountryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFaction  faction
-- @param bool unknownFlag
-- @return bool
function CCountryObject:IsNeighbourToFactionHostile(faction, unknownFlag)
	Hoi3Object.assertParameterType(1, faction, 'CFaction')
	Hoi3Object.assertParameterType(2, unknownFlag, 'boolean')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:isPuppet()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:IsSubject()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
function CCountryObject:NeedConvoyToTradeWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool
function CCountryObject:MayLiberateCountries()
	Hoi3Object.throwNotYetImplemented()
end