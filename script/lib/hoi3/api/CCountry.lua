require('hoi3')

module("hoi3.api", package.seeall)

CCountry = hoi3.MultitonObject:subclass('hoi3.CCountry')

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
-- @return iterator<CProvince> 
hoi3.f(CCountry, 'GetAirBases', false, 'iterator<CProvince>')

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
hoi3.f(CCountry, 'GetBuildCostIC', false, 'CFixedPoint', 'CSubUnitDefinition', hoi3.TYPE_NUMBER, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CSubUnitDefinition  pUnit
-- @param number quantity
-- @param bool buildReserve
-- @return CFixedPoint
hoi3.f(CCountry, 'GetBuildCostMP', false, 'CFixedPoint', 'CSubUnitDefinition', hoi3.TYPE_NUMBER, hoi3.TYPE_BOOLEAN)
 
---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CCountry, 'GetBuildTime', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return number  
hoi3.f(CCountry, 'GetCapital', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CProvince
hoi3.f(CCountry, 'GetCapitalLocation', false, 'CProvince')

---
-- @since 1.4
-- @return iterator<CProvince> 
hoi3.f(CCountry, 'GetControlledProvinces', false, 'iterator<CProvince>')

---
-- @since 1.4
-- @return iterator<CProvince>
hoi3.f(CCountry, 'GetCoreProvinces', false, 'iterator<CProvince>') 

---
-- @since 2.0
-- @return iterator<CConstruction>
hoi3.f(CCountry, 'GetConstructions', false, 'iterator<CConstruction>') 

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetConvoyBuildCost', false, 'CFixedPoint') 

---
-- @since 1.3
-- @return CFixedPoint 
hoi3.f(CCountry, 'GetConvoyBuildTime', false, 'CFixedPoint')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetConvoyedIn', false, 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetConvoyedOut', false, 'CGoodsPool')

---
-- @since 1.3
-- @return iterator<CConvoy> 
hoi3.f(CCountry, 'GetConvoys', false, 'iterator<CConvoy>')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetCountryTag', false, 'CCountryTag')

function CCountry:GetCountryTagImpl()
	return self.tag
end

---
-- @since 1.3
-- @return iterator<CCountryTag> 
hoi3.f(CCountry, 'GetCurrentAtWarWith', false, 'iterator<CCountryTag>')

---
-- @since 1.4
-- @return iterator<CTechnology>
hoi3.f(CCountry, 'GetCurrentResearch', false, 'iterator<CTechnology>')

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyBalance', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyExpense', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodIndex
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDailyIncome', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return iterator<CDiplomacyStatus>
hoi3.f(CCountry, 'GetDiplomacy', false, 'iterator<CDiplomacyStatus>')

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
hoi3.f(CCountry, 'GetDiplomaticDistance', false, 'CFixedPoint','CCountryTag')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDiplomaticInfluence', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetDissent', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEffectiveNeutrality', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEscortBuildCost', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetEscortBuildTime', false, 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetEscorts', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFaction
hoi3.f(CCountry, 'GetFaction', false, 'CFaction')

function CCountry:GetFactionImpl()
	if self:HasFaction() then
		return CFaction.random()
	end
end

---
-- @since 1.3
-- @return CModifier
hoi3.f(CCountry, 'GetGlobalModifier', false, 'CModifier')

---
-- @since 1.3
-- @return CGovernment
hoi3.f(CCountry, 'GetGovernment', false, 'CGovernment')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetHighestThreat', false, 'CCountryTag')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetHomeProduced', false, 'CGoodsPool')

---
-- @since 1.3
-- @param number distributionSetting
-- @return CFixedPoint
hoi3.f(CCountry, 'GetICPart', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CLawGroup lawGroup
-- @return CLaw
hoi3.f(CCountry, 'GetLaw', false, 'CLaw', 'CLawGroup')

---
-- @since 1.3
-- @param number groupIndex
-- @return CLaw
hoi3.f(CCountry, 'GetLawFromIndex', false, 'CLaw', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
hoi3.f(CCountry, 'GetLeadershipDistributionAt', false, 'CDistributionSetting', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetManpower', false, 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetMaxIC', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CFixedPoint
hoi3.f(CCountry, 'GetMaxNeutralityForWarWith', false, 'CFixedPoint', 'CCountryTag')

---
-- @since 2.0
-- @param number positionIndex
-- @return CMinister
hoi3.f(CCountry, 'GetMinister', false, 'CMinister', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetMoneyBalanceAverage', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetNationalUnity', false, 'CFixedPoint')

---
-- @since 1.3
-- @return iterator<CProvince>
hoi3.f(CCountry, 'GetNavalBases', false, 'iterator<CProvince>')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetNeighbours', false, 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetNeutrality', false, 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumberOfControlledProvinces', false, hoi3.TYPE_NUMBER)
 
function CCountry:GetNumberOfControlledProvincesImpl()
	return #self:GetControlledProvinces()
end

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumberOfCurrentResearch', false, hoi3.TYPE_NUMBER)

function CCountry:GetNumberOfCurrentResearchImpl()
	local f, s = self:GetCurrentResearch()
	return #s
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumberOfOwnedProvinces', false, hoi3.TYPE_NUMBER)
 
function CCountry:GetNumberOfOwnedProvincesImpl()
	local f, s = self:GetOwnedProvinces()
	return #s
end

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumOfAllies', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number 
hoi3.f(CCountry, 'GetNumOfAirfields', false, hoi3.TYPE_NUMBER)

function CCountry:GetNumOfAirfieldsImpl()
	local f, s = self:GetAirBases()
	return #s
end

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetNumOfPorts', false, hoi3.TYPE_NUMBER)

function CCountry:GetNumOfPortsImpl()
	local f, s = self:GetNavalBases()
	return #s
end

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetOfficerRatio', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CCountry, 'GetOverlord', false, 'CCountryTag')

function CCountry:GetOverlordImpl()
	if self:isPuppet() then
		return CCountryTag.random()
	end
end

---
-- @since 1.3
-- @return iterator<number>
-- TODO: make impl method for Navalbases etc. that use this.
hoi3.f(CCountry, 'GetOwnedProvinces', false, 'iterator<number>')

---
-- @since 1.3
-- @return CGoodsPool
hoi3.f(CCountry, 'GetPool', false, 'CGoodsPool')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetPossibleLiberations', false, 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetPossiblePuppets', false, 'iterator<CCountryTag>')

---
-- @since 1.3
-- @param number distributionSetting
-- @return CDistributionSetting
hoi3.f(CCountry, 'GetProductionDistributionAt', false, 'CDistributionSetting', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CDiplomacyStatus
hoi3.f(CCountry, 'GetRelation', false, 'CDiplomacyStatus', 'CCountryTag')

function CCountry:GetRelationImpl(tag)
	return CDiplomacyStatus(self.tag,tag)
end

---
-- @since 1.3
-- @return CRule
hoi3.f(CCountry, 'GetRules', false, 'CRule')

---
-- @since 1.3
-- @return CIdeology
hoi3.f(CCountry, 'GetRulingIdeology', false, 'CIdeology')

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return CSpyPresence
hoi3.f(CCountry, 'GetSpyPresence', false, 'CSpyPresence', 'CCountryTag')

---
-- @since 2.0
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetSpyingOnUs', false, 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return CStrategicWarfare
hoi3.f(CCountry, 'GetStrategicWarfare', false, 'CStrategicWarfare')

---
-- @since 1.3
-- @return CAIStrategy
hoi3.f(CCountry, 'GetStrategy', false, 'CAIStrategy')

function CCountry:GetStrategyImpl()
	return CAIStrategy(self:GetCountryTag())
end


---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetSupplyBalanceAverage', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetSurrenderLevel', false, 'CFixedPoint')

---
-- @since 1.3
-- @return CTechnologyStatus
hoi3.f(CCountry, 'GetTechnologyStatus', false, 'CTechnologyStatus')

---
-- @since 2.0
-- @return number
hoi3.f(CCountry, 'GetTotalConvoyTransports', false, hoi3.TYPE_NUMBER)

---
-- @since 2.0
-- @param number buildingIndex
-- @return number 
hoi3.f(CCountry, 'GetTotalCoreBuildingLevels', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalIC', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetTotalLeadership', false, 'CFixedPoint')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalNeededConvoyTransports', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTotalNeededTransports', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTotalProduced', false, 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedAway', false, 'CGoodsPool')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedAwaySansAlliedSupply', false, 'CGoodsPool')

---
-- @since 1.4
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedFor', false, 'CGoodsPool')

---
-- @since 2.0
-- @return CGoodsPool
hoi3.f(CCountry, 'GetTradedForSansAlliedSupply', false, 'CGoodsPool')

---
-- @since 1.3
-- @return number
hoi3.f(CCountry, 'GetTransports', false, hoi3.TYPE_NUMBER)

---
-- @since 1.4
-- @return CUnitList
hoi3.f(CCountry, 'GetUnits', false, 'CUnitList')

---
-- @since 1.4
-- @return iterator<CUnit>
-- TODO: synchronize impl for GetUnits and GetUnitsIterator
hoi3.f(CCountry, 'GetUnitsIterator', false, 'iterator<CUnit>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CCountry, 'GetUsedIC', false, 'CFixedPoint')

---
-- @since 1.4
-- @param string key
-- @return CFixedPoint
hoi3.f(CCountry, 'GetVariable', false, 'CFixedPoint', hoi3.TYPE_STRING)

---
-- @since 1.4
-- @return CVariables
hoi3.f(CCountry, 'GetVariables', false, 'CVariables')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetVassals', false, 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasConstruction', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CCountry, 'HasDiplomatEnroute', false, hoi3.RAND_BOOL_VUNLIKELY, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasExtraManpowerLeft', false, hoi3.RAND_BOOL_VLIKELY)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'HasFaction', false, hoi3.RAND_BOOL_VUNLIKELY)

---
-- @since 1.3
-- @param CFaction faction
-- @return bool
hoi3.f(CCountry, 'HasNeighborInFaction', false, hoi3.TYPE_BOOLEAN, 'CFaction')

function HasNeighborInFactionImpl(faction)
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
hoi3.f(CCountry, 'IsAtWar', false, hoi3.RAND_BOOL_UNLIKELY)

---
-- @since 1.3
-- @param CBuilding  building
-- @param CProvince  province
-- @return bool
hoi3.f(CCountry, 'IsBuildingAllowed', false, hoi3.TYPE_BOOLEAN, 'CBuilding', 'CProvince')

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
hoi3.f(CCountry, 'IsEnemy', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsFactionLeader', false, hoi3.TYPE_BOOLEAN)

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
hoi3.f(CCountry, 'IsFriend', false, hoi3.TYPE_BOOLEAN, 'CCountryTag', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsGovernmentInExile', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsMajor', false, hoi3.TYPE_BOOLEAN)

function CCountry:IsMajorImpl()
	return self:GetTotalIC() >= 60
end

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsMobilized', false, hoi3.TYPE_BOOLEAN)

function CCountry:IsMobilized()
	return self:IsAtWar() or hoi3.RAND_BOOL_VUNLIKELY:compute()
end

---
-- @since 1.3
-- @param CCountryTag  otherCountryTag
-- @return bool
hoi3.f(CCountry, 'IsNeighbour', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 1.3
-- @param CFaction  faction
-- @param bool unknownFlag
-- @return bool
hoi3.f(CCountry, 'IsNeighbourToFactionHostile', false, hoi3.TYPE_BOOLEAN, 'CFaction', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'isPuppet', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'IsSubject', false, hoi3.TYPE_BOOLEAN)

function CCountry:IsSubjectImpl()
	return self:isPuppet()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @return bool
hoi3.f(CCountry, 'NeedConvoyToTradeWith', false, hoi3.RAND_BOOL_VUNLIKELY, 'CCountryTag')

---
-- @since 1.3
-- @return bool
hoi3.f(CCountry, 'MayLiberateCountries', false, hoi3.TYPE_BOOLEAN)

function CCountry:MayLiberateCountriesImpl()
	return #self:GetPossibleLiberations() > 0
end


---
-- @since 1.3
-- @return iterator<TradeRoute>
hoi3.f(CCountry, 'AIGetTradeRoutes', false, 'iterator<CTradeRoute>')

---
-- @since 2.0
-- @return iterator<CCountryTag>
hoi3.f(CCountry, 'GetAllies', false, 'iterator<CCountryTag>')


function CCountry.random()
	return hoi3.randomTableMember(CCountry:getInstances())
end