require('hoi3.Hoi3Object')

CCountry = Hoi3Object:subclass('hoi3.CCountry')

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyOrganization()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeology 
function CCountry:AccessIdeologyPopularity()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalcDesperation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
function CCountry:CalculateIsAllied(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:CalculateNumberOfActiveInfluences()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:CalculateReinforcementMultiplier()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CCountry:CanCreatePuppet()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CCountry:Exists()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
function CCountry:GetAbility(category)
	Hoi3Object.assertParameterType(1, category, 'CTechnologyCategory')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetActingCapitalLocation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince> 
function CCountry:GetAirBases()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CAlignment 
function CCountry:GetAlignment()
	Hoi3Object.throwNotYetImplemented()
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
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetAvailableIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
function CCountry:GetBuildCost(building)
	Hoi3Object.assertParameterType(1, building, 'CBuilding')
	
	Hoi3Object.throwNotYetImplemented()
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
	
	Hoi3Object.throwNotYetImplemented()
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
	
	Hoi3Object.throwNotYetImplemented()
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
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CProvince 
function CCountry:GetCapitalLocation()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetControlledProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CProvince> 
function CCountry:GetCoreProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return table<CConstruction>
function CCountry:GetConstructions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint 
function CCountry:GetConvoyBuildTime()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedIn()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool 
function CCountry:GetConvoyedOut()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CConvoy> 
function CCountry:GetConvoys()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CCountry:GetCountryTag()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag> 
function CCountry:GetCurrentAtWarWith()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CTechnology>
function CCountry:GetCurrentResearch()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyBalance(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyExpense(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
function CCountry:GetDailyIncome(goodIndex)
	Hoi3Object.assertParameterType(1, goodIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CDiplomacyStatus>
function CCountry:GetDiplomacy()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
function CCountry:GetDiplomaticDistance(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDiplomaticInfluence()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetDissent()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEffectiveNeutrality()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildCost()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetEscortBuildTime()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetEscorts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFaction
function CCountry:GetFaction()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CModifier
function CCountry:GetGlobalModifier()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CGovernment
function CCountry:GetGovernment()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetHighestThreat()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetHomeProduced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
function CCountry:GetICPart(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CLawGroup lawGroup
-- @return CLaw
function CCountry:GetLaw(lawGroup)
	Hoi3Object.assertParameterType(1, lawGroup, 'CLawGroup')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number groupIndex
-- @return CLaw
function CCountry:GetLawFromIndex(groupIndex)
	Hoi3Object.assertParameterType(1, groupIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountry:GetLeadershipDistributionAt(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetManpower()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetMaxIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
function CCountry:GetMaxNeutralityForWarWith(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CMinister
function CCountry:GetMinister(positionIndex)
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetMoneyBalanceAverage()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNationalUnity()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountry:GetNavalBases()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CProvince>
function CCountry:GetNeighbours()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetNeutrality()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfControlledProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfCurrentResearch()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumberOfOwnedProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAllies()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CCountry:GetNumOfAirfields()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetNumOfPorts()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetOfficerRatio()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CCountry:GetOverlord()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<number>
function CCountry:GetOwnedProvinces()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CGoodsPool
function CCountry:GetPool()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossibleLiberations()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CCountry:GetPossiblePuppets()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
function CCountry:GetProductionDistributionAt(distributionSetting)
	Hoi3Object.assertParameterType(1, distributionSetting, 'CDistributionSetting')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
function CCountry:GetRelation(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CRule
function CCountry:GetRules()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CIdeology
function CCountry:GetRulingIdeology()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
function CCountry:GetSpyPresence(countryTag)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return table<CCountryTag>
function CCountry:GetSpyingOnUs()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CStrategicWarfare
function CCountry:GetStrategicWarfare()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CAIStrategy
function CCountry:GetStrategy()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSupplyBalanceAverage()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetSurrenderLevel()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTechnologyStatus
function CCountry:GetTechnologyStatus()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return number 
function CCountry:GetTotalConvoyTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
function CCountry:GetTotalCoreBuildingLevels(buildingIndex)
	Hoi3Object.assertParameterType(1, buildingIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetTotalLeadership()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededConvoyTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetTotalNeededTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTotalProduced()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedAway()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedAwaySansAlliedSupply()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CGoodsPool
function CCountry:GetTradedFor()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CGoodsPool
function CCountry:GetTradedForSansAlliedSupply()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CCountry:GetTransports()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return CUnitList
function CCountry:GetUnits()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @return table<CUnit>
function CCountry:GetUnitsIterator()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CFixedPoint
function CCountry:GetUsedIC()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.4
-- @param string key
-- @return CFixedPoint
function CCountry:GetVariable(key)
	Hoi3Object.assertParameterType(1, key, 'string')
	
	Hoi3Object.throwNotYetImplemented()
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