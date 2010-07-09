require('hoi3')

module("hoi3.api", package.seeall)

CCountry = hoi3.MultitonObject:subclass('hoi3.api.CCountry')

---
-- @param CCountryTag countryTag
function CCountry:initialize(tag)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	
	self.tag = tag
end

---
-- @since 1.3
-- @return CIdeology 
hoi3.f(CCountry, 'AccessIdeologyOrganization', 'CIdeologyData')

---
-- @since 1.3
-- @return CIdeology 
hoi3.f(CCountry, 'AccessIdeologyPopularity', 'CIdeologyData')

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'CalcDesperation', 'CFixedPoint')

---
-- @since 2.0
-- @param CCountryTag  countryTag
-- @return bool 
hoi3.f(CCountry, 'CalculateIsAllied', hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'CalculateNumberOfActiveInfluences', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'CalculateReinforcementMultiplier', 'CFixedPoint')

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountry, 'CanCreatePuppet', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool 
hoi3.f(CCountry, 'Exists', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CTechnologyCategory  category
-- @return bool 
hoi3.f(CCountry, 'GetAbility', hoi3.TYPE_BOOLEAN, 'CTechnologyCategory')

---
-- @since 1.3
-- @return CProvince 
hoi3.f(CCountry, 'GetActingCapitalLocation', 'CProvince')

---
-- @since 1.3
-- @return iterator<CProvince> 
hoi3.f(CCountry, 'GetAirBases', 'iterator<CProvince>')

---
-- @since 1.3
-- @return CAlignment 
hoi3.f(CCountry, 'GetAlignment', 'CAlignment')

---
-- @since 1.3
-- @return unknown 
hoi3.f(CCountry, 'GetAlignmentCord', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetAllowedResearchSlots', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetAvailableIC', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CBuilding  building
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetBuildCost', 'CFixedPoint', 'CBuilding')

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetBuildCostIC', 'CFixedPoint', 'CSubUnitDefinition', hoi3.TYPE_NUMBER, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint
hoi3.f(CCountry, 'GetBuildCostMP', 'CFixedPoint', 'CSubUnitDefinition', hoi3.TYPE_NUMBER, hoi3.TYPE_BOOLEAN)
 
---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetBuildTime', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number  
hoi3.f(CCountry, 'GetCapital', hoi3.TYPE_NUMBER)

function CCountry:GetCapitalImpl()
	return self:GetCapitalLocation():GetProvinceID()
end

---
-- @since 1.3
-- @return CProvince
hoi3.f(CCountry, 'GetCapitalLocation', 'CProvince')

function CCountry:GetCapitalLocationImpl()
	return CProvince(hoi3.randomIteratorMember(self:GetCoreProvinces()))
end

---
-- @since 1.4
-- @return iterator<CProvince> 
hoi3.f(CCountry, 'GetControlledProvinces', 'iterator<number>')

function CCountry:GetControlledProvincesImpl()
	local t = {}
	for k,v in pairs(CProvince:getInstances()) do
		if v:GetController() == self.tag then
			t[v:GetProvinceID()] = v:GetProvinceID()
		end
	end
	return t
end

---
-- @since 1.4
-- @return iterator<CProvince>
hoi3.f(CCountry, 'GetCoreProvinces', 'iterator<number>') 

function CCountry:GetCoreProvincesImpl()
	local t = {}
	for k,v in pairs(CProvince:getInstances()) do
		if v:GetOwner() == self.tag then
			t[v:GetProvinceID()] = v:GetProvinceID()
		end
	end
	return t
end

---
-- @since 2.0
-- @return iterator<CConstruction>
hoi3.f(CCountry, 'GetConstructions', 'iterator<CConstruction>') 

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetConvoyBuildCost', 'CFixedPoint') 

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetConvoyBuildTime', 'CFixedPoint')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetConvoyedIn', 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetConvoyedOut', 'CGoodsPool')

---
-- @since 1.3
-- @return iterator<CConvoy> 
hoi3.f(CCountry, 'GetConvoys', 'iterator<CConvoy>')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetCountryTag', 'CCountryTag')

function CCountry:GetCountryTagImpl()
	return self.tag
end

---
-- @since 1.3
-- @return iterator<CCountryTag> 
hoi3.f(CCountry, 'GetCurrentAtWarWith', 'iterator<CCountryTag>')

---
-- @since 1.4
-- @return iterator<CTechnology>
hoi3.f(CCountry, 'GetCurrentResearch', 'iterator<CTechnology>')

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyBalance', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyExpense', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyIncome', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return iterator<CDiplomacyStatus>
hoi3.f(CCountry, 'GetDiplomacy', 'iterator<CDiplomacyStatus>')

function CCountry:GetDiplomacyImpl()
	local dtable = {}
	for _, tag in pairs(CCountryTag:getInstances()) do
		local diplo = CDiplomacyStatus(self.tag, tag)
		dtable[diplo] = diplo
	end
	return dtable
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDiplomaticDistance', 'CFixedPoint','CCountryTag')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDiplomaticInfluence', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDissent', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEffectiveNeutrality', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEscortBuildCost', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEscortBuildTime', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetEscorts', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFaction
hoi3.f(CCountry, 'GetFaction', 'CFaction')

function CCountry:GetFactionImpl()
	if self:HasFaction() then
		return CFaction.random()
	else
		return nil
	end
end

---
-- @since 1.3
-- @return CModifier
hoi3.f(CCountry, 'GetGlobalModifier', 'CModifier')

---
-- @since 1.3
-- @return CGovernment
hoi3.f(CCountry, 'GetGovernment', 'CGovernment')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetHighestThreat', 'CCountryTag')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetHomeProduced', 'CGoodsPool')

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
hoi3.f(CCountry, 'GetICPart', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CLawGroup lawGroup
-- @return CLaw
hoi3.f(CCountry, 'GetLaw', 'CLaw', 'CLawGroup')

---
-- @since 1.3
-- @param number groupIndex
-- @return CLaw
hoi3.f(CCountry, 'GetLawFromIndex', 'CLaw', hoi3.TYPE_NUMBER)

function CCountry:GetLawFromIndexImpl(index)	
	return hoi3.fromIndexTableMember(CLaw:getInstances(), index)
end

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
hoi3.f(CCountry, 'GetLeadershipDistributionAt', 'CDistributionSetting', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetManpower', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetMaxIC', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
hoi3.f(CCountry, 'GetMaxNeutralityForWarWith', 'CFixedPoint', 'CCountryTag')

---
-- @since 2.0
-- @param number positionIndex
-- @return CMinister
hoi3.f(CCountry, 'GetMinister', 'CMinister', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetMoneyBalanceAverage', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetNationalUnity', 'CFixedPoint')

---
-- @since 1.3
-- @return iterator<CProvince>
hoi3.f(CCountry, 'GetNavalBases', 'iterator<CProvince>')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetNeighbours', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetNeutrality', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumberOfControlledProvinces', hoi3.TYPE_NUMBER)
 
function CCountry:GetNumberOfControlledProvincesImpl()
	return hoi3.countIteratorMember(self:GetControlledProvinces())
end

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumberOfCurrentResearch', hoi3.TYPE_NUMBER)

function CCountry:GetNumberOfCurrentResearchImpl()
	return hoi3.countIteratorMember(self:GetCurrentResearch())
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumberOfOwnedProvinces', hoi3.TYPE_NUMBER)
 
function CCountry:GetNumberOfOwnedProvincesImpl()
	return hoi3.countIteratorMember(self:GetOwnedProvinces())
end

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumOfAllies', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumOfAirfields', hoi3.TYPE_NUMBER)

function CCountry:GetNumOfAirfieldsImpl()
	return hoi3.countIteratorMember(self:GetAirBases())
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumOfPorts', hoi3.TYPE_NUMBER)

function CCountry:GetNumOfPortsImpl()
	return hoi3.countIteratorMember(self:GetNavalBases())
end

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetOfficerRatio', 'CFixedPoint')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetOverlord', 'CCountryTag')

function CCountry:GetOverlordImpl()
	if self:IsPuppet() then
		return CCountryTag.random()
	end
end

---
-- @since 1.3
-- @return iterator<number>
-- TODO: make impl method for Navalbases etc. that use this.
hoi3.f(CCountry, 'GetOwnedProvinces', 'iterator<number>')

---
-- @since 1.3
-- @return CGoodsPool
hoi3.f(CCountry, 'GetPool', 'CGoodsPool')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetPossibleLiberations', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetPossiblePuppets', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
hoi3.f(CCountry, 'GetProductionDistributionAt', 'CDistributionSetting', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
hoi3.f(CCountry, 'GetRelation', 'CDiplomacyStatus', 'CCountryTag')

function CCountry:GetRelationImpl(tag)
	return CDiplomacyStatus(self.tag,tag)
end

---
-- @since 1.3
-- @return CRule
hoi3.f(CCountry, 'GetRules', 'CRule')

---
-- @since 1.3
-- @return CIdeology
hoi3.f(CCountry, 'GetRulingIdeology', 'CIdeology')

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
hoi3.f(CCountry, 'GetSpyPresence', 'CSpyPresence', 'CCountryTag')

---
-- @since 2.0
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetSpyingOnUs', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return CStrategicWarfare
hoi3.f(CCountry, 'GetStrategicWarfare', 'CStrategicWarfare')

---
-- @since 1.3
-- @return CAIStrategy
hoi3.f(CCountry, 'GetStrategy', 'CAIStrategy')

function CCountry:GetStrategyImpl()
	return CAIStrategy(self:GetCountryTag())
end


---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetSupplyBalanceAverage', 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetSurrenderLevel', 'CFixedPoint')

---
-- @since 1.3
-- @return CTechnologyStatus
hoi3.f(CCountry, 'GetTechnologyStatus', 'CTechnologyStatus')

---
-- @since 2.0
-- @return number
hoi3.f(CCountry, 'GetTotalConvoyTransports', hoi3.TYPE_NUMBER)

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
hoi3.f(CCountry, 'GetTotalCoreBuildingLevels', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalIC', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetTotalLeadership', 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalNeededConvoyTransports', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalNeededTransports', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTotalProduced', 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedAway', 'CGoodsPool')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedAwaySansAlliedSupply', 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedFor', 'CGoodsPool')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedForSansAlliedSupply', 'CGoodsPool')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTransports', hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return CUnitList
hoi3.f(CCountry, 'GetUnits', 'CUnitList')

---
-- @since 1.4
-- @return iterator<CUnit>
-- TODO: synchronize impl for GetUnits and GetUnitsIterator
hoi3.f(CCountry, 'GetUnitsIterator', 'iterator<CUnit>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetUsedIC', 'CFixedPoint')

---
-- @since 1.4
-- @return CVariables
hoi3.f(CCountry, 'GetVariables', 'CVariables')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetVassals', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasConstruction', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CCountry, 'HasDiplomatEnroute', hoi3.RAND_BOOL_VUNLIKELY, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasExtraManpowerLeft', hoi3.RAND_BOOL_VLIKELY)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasFaction', hoi3.RAND_BOOL_VUNLIKELY)

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
hoi3.f(CCountry, 'HasNeighborInFaction', hoi3.TYPE_BOOLEAN, 'CFaction')

function CCountry:HasNeighborInFactionImpl(faction)
	for k, v in self:GetNeighbours() do
		if v:GetCountry():HasFaction() and v:GetCountry():GetFaction() == faction then
			return true
		end
	end
	return false
end

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsAtWar', hoi3.RAND_BOOL_UNLIKELY)

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
hoi3.f(CCountry, 'IsBuildingAllowed', hoi3.TYPE_BOOLEAN, 'CBuilding', 'CProvince')

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
hoi3.f(CCountry, 'IsEnemy', hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsFactionLeader', hoi3.TYPE_BOOLEAN)

function CCountry:IsFactionLeaderImpl()
	for faction in CFaction:getInstances() do
		if faction:GetFactionLeader() == self:GetCountryTag() then
			return true
		end
	end
	return false
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @param bool unknownFlag
-- @return bool
hoi3.f(CCountry, 'IsFriend', hoi3.TYPE_BOOLEAN, 'CCountryTag', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsGovernmentInExile', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsMajor', hoi3.TYPE_BOOLEAN)

function CCountry:IsMajorImpl()
	return self:GetTotalIC() >= 60
end

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsMobilized', hoi3.TYPE_BOOLEAN)

function CCountry:IsMobilizedImpl()
	return self:IsAtWar() or hoi3.RAND_BOOL_VUNLIKELY:compute()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
hoi3.f(CCountry, 'IsNeighbour', hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @param CFaction  faction
-- @param bool unknownFlag
-- @return bool
hoi3.f(CCountry, 'IsNeighbourToFactionHostile', hoi3.TYPE_BOOLEAN, 'CFaction', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsPuppet', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsSubject', hoi3.TYPE_BOOLEAN)

function CCountry:IsSubjectImpl()
	return self:isPuppet()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CCountry, 'NeedConvoyToTradeWith', hoi3.RAND_BOOL_VUNLIKELY, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'MayLiberateCountries', hoi3.TYPE_BOOLEAN)

function CCountry:MayLiberateCountriesImpl()
	return hoi3.countIteratorMember(self:GetPossibleLiberations()) > 0
end


---
-- @since 1.3
-- @return iterator<CTradeRoute>
hoi3.f(CCountry, 'AIGetTradeRoutes', 'iterator<CTradeRoute>')

---
-- @since 2.0
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetAllies', 'iterator<CCountryTag>')

---
-- @since 2.0
-- @return iterator<CMinister>
hoi3.f(CCountry, 'GetPossibleMinisters', 'iterator<CMinister>')

function CCountry.random()
	return hoi3.randomTableMember(CCountry:getInstances())
end

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetDailyNeed', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetNumberOfFreeSpies', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'CanBreakNAPWith', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)


---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetFlags', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'HasIncomingTradeOffer', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return iterator<unknown>
hoi3.f(CCountry, 'GetHistoricalMinisters', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return iterator<unknown>
hoi3.f(CCountry, 'GetMinisters', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'AICalculateExpense', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 2.0
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetAreActingCapitalsOnSameContinent', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)
