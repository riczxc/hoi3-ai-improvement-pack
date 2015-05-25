This matches version 2.0.

```
// **************************************************************************
// *
// * lua_ai.cpp
// *
// * (C)opyright Paradox Interactive AB 2009
// *
// *  Release date 7/9/2010
// **************************************************************************


class_< CID >("CID")
	.def( constructor<>() ),

class_< CArray<float> >("CArrayFloat")
	.def( constructor< unsigned int >() )
	.def( "SetAt", &CArray<float>::SetAt )
	.def( "GetAt", &CArray<float>::GetAt ),

class_< CArray<CFixedPoint> >("CArrayFix")
	.def( constructor< unsigned int >() )
	.def( "SetAt", &CArray<CFixedPoint>::SetAt )
	.def( "GetAt", &CArray<CFixedPoint>::GetAt ),

class_< CArray<CFixedPoint64> >("CArrayFix64")
	.def( constructor< unsigned int >() )
	.def( "SetAt", &CArray<CFixedPoint64>::SetAt )
	.def( "GetAt", &CArray<CFixedPoint64>::GetAt ),

class_< CArray<int> >("CArrayInt")
	.def( constructor< unsigned int >() )
	.def( "SetAt", &CArray<int>::SetAt )
	.def( "GetAt", &CArray<int>::GetAt ),

class_< CList< CSubUnitConstructionEntry > >("CList_CSubUnitConstructionEntry")
	.def( "IsEmpty", &CList< CSubUnitConstructionEntry >::IsEmpty )
	.def( "RemoveHead", &CList< CSubUnitConstructionEntry >::RemoveHead )
	.def( "GetHeadData", &CList< CSubUnitConstructionEntry >::GetHeadData )
	.def( "RemoveTail", &CList< CSubUnitConstructionEntry >::RemoveTail )
	.def( "GetTailData", &CList< CSubUnitConstructionEntry >::GetTailData )
	.def( "Remove", &CList< CSubUnitConstructionEntry >::RemoveData )
	.def( "GetSize", &CList< CSubUnitConstructionEntry >::GetSize ),

class_< CResourceValues >( "CResourceValues" )
	.def( constructor<>() )
	.def( "GetResourceValues", &CResourceValues::GetResourceValues )
	.def_readwrite( "vDailyExpense", &CResourceValues::vDailyExpense )
	.def_readwrite( "vDailyHome", &CResourceValues::vDailyHome )
	.def_readwrite( "vConvoyedIn", &CResourceValues::vConvoyedIn )
	.def_readwrite( "vPool", &CResourceValues::vPool )
	.def_readwrite( "vDailyIncome", &CResourceValues::vDailyIncome )
	.def_readwrite( "vDailyBalance", &CResourceValues::vDailyBalance ),

class_< CGoodsValues >( "CGoodsValues" )
	.def( constructor<>() )
	.def_readwrite( "vMoney", &CGoodsValues::vMoney )
	.def_readwrite( "vFuel", &CGoodsValues::vFuel )
	.def_readwrite( "vCrudeOil", &CGoodsValues::vCrudeOil )
	.def_readwrite( "vMetal", &CGoodsValues::vMetal )
	.def_readwrite( "vEnergy", &CGoodsValues::vEnergy )
	.def_readwrite( "vSupplies", &CGoodsValues::vSupplies )
	.def_readwrite( "vRareMaterials", &CGoodsValues::vRareMaterials ),

class_< CEU3AI >("CAI")
	.def( "GetCountry", &CEU3AI::GetCountry )
	.def( "MoveToNeighbor", &CEU3AI::MoveToNeighbor )
	.def( "MoveUnit", &CEU3AI::MoveUnit )
	.def( "GetReqProdQueue", &CEU3AI::GetReqProdQueue )
	.def( "GetReqProdQueueIter", &CEU3AI::GetReqProdQueue, return_clausewitz_iterator )
	.def( "RequestSubUnit", &CEU3AI::RequestSubUnit)
	.def( "GetCurrentDate", &CEU3AI::GetCurrentDate )
	.def( "GetRelation", &CEU3AI::GetRelation)
	.def( "GetNumberOfOwnedProvinces", &CEU3AI::GetNumberOfOwnedProvinces )
	.def( "GetNormalizedAlignmentDistance", &CEU3AI::GetNormalizedAlignmentDistance )
	.def( "CalculateFriendOfFaction", &CEU3AI::CalculateFriendOfFaction )
	.def( "GetCountryAlignmentDistance", &CEU3AI::GetCountryAlignmentDistance )
	.def( "PrintConsole", &CEU3AI::PrintConsole )
	.def( "Post", &CEU3AI::Post )
	.def( "PostAction", &CEU3AI::PostAction )
	.def( "CanDeclareWar", &CEU3AI::CanDeclareWar )
	.def( "GetAmountTradedFrom", &CEU3AI::GetAmountTradedFrom )
	.def( "AlreadyTradingResourceOtherWay", &CEU3AI::AlreadyTradingResourceOtherWay )
	.def( "AlreadyTradingDisabledResource", &CEU3AI::AlreadyTradingDisabledResource )
	.def( "IsTradeingAwayNeededResource", &CEU3AI::IsTradeingAwayNeededResource )
	.def( "GetSpamPenalty", &CEU3AI::GetSpamPenalty )
	.def( "HasTradeGoneStale", &CEU3AI::HasTradeGoneStale )
	.def( "CanTradeFreeResources", &CEU3AI::CanTradeFreeResources )
	.def( "IsInfluencing", &CEU3AI::IsInfluencing )
	.def( "HasFilledProdQueue", &CEU3AI::HasFilledProdQueue )
	.def( "GetDeployedSubUnitCounts", &CEU3AI::GetDeployedSubUnitCounts )
	.def( "GetProductionSubUnitCounts", &CEU3AI::GetProductionSubUnitCounts )
	.def( "GetTheatreSubUnitNeedCounts", &CEU3AI::GetTheatreSubUnitNeedCounts )
	.def( "EvaluateCancelTrades", &CEU3AI::EvaluateCancelTrades )
	.enum_("AUTOMATIONTYPE")
	[
		value( "_DIPLOMACY_", CHuman::_DIPLOMACY_ ),
		value( "_PRODUCTION_", CHuman::_PRODUCTION_ ),
		value( "_TECHNOLOGY_", CHuman::_TECHNOLOGY_ ),
		value( "_POLITICS_", CHuman::_POLITICS_ ),
		value( "_INTELLIGENCE_", CHuman::_INTELLIGENCE_ )
	]
	.scope
	[
		def( "HasUserExtension", &CAI_HasUserExtension ),
		def( "GetModDirectory", &CAI_GetModDirectory ),
		def( "GetCommonModDirectory", &CAI_GetCommonModDirectory ),
		def( "HasCommonExtension", &CAI_HasCommonExtension ),
		def( "IsAIControlledForPlayer", &CAI_IsAIControlled )
	],
	



class_< CFixedPoint >("CFixedPoint")
	.def( constructor<>() )
	.def( constructor<float>() )
	.def( "Get", &CFixedPoint::Get )
	.def( "GetTruncated", &CFixedPoint::GetTruncated )
	.def( const_self + const_self )
	.def( const_self - const_self )
	.def( const_self * const_self )
	.def( const_self / const_self )
	.def( const_self == const_self )
	.def( const_self < const_self )
	.def( const_self <= const_self )
	.def( const_self + float() )
	.def( const_self - float() )
	.def( const_self * float() )
	.def( const_self / float() )
	.def( const_self == float() )
	.def( const_self < float() )
	.def( const_self <= float() )
	.def( float() + const_self )
	.def( float() - const_self )
	.def( float() * const_self )
	.def( float() / const_self )
	.def( float() == const_self )
	.def( float() < const_self )
	.def( float() <= const_self )
	.def( tostring(const_self) ),



	class_< CFixedPoint64 >("CFixedPoint64")
	.def( constructor<>() )
	.def( constructor<float>() )
	.def( "Get", &CFixedPoint64::Get )
	.def( "GetTruncated", &CFixedPoint64::GetTruncated )
	.def( "GetRounded", &CFixedPoint64::GetRounded )
	.def( const_self + const_self )
	.def( const_self - const_self )
	.def( const_self * const_self )
	.def( const_self / const_self )
	.def( const_self == const_self )
	.def( const_self < const_self )
	.def( const_self <= const_self )
	.def( tostring(const_self) ),


class_< CString >("CString")
	.def( constructor<const char*>() )
	.def( "GetCharPtr", &CString::GetCharPtr  )
	.def( "GetString", &CString::GetString )
	.def( tostring(const_self) )
	.def( const_self == const_self ),

class_< CEU3Date >("CEU3Date")
	.def( "GetYear", &CEU3Date::GetYear )
	.def( "GetDayOfMonth", &CEU3Date::GetDayOfMonth )
	.def( "GetMonthOfYear", &CEU3Date::GetMonthOfYear )
	.def( "GetTotalDays", &CEU3Date::GetTotalDays )
	.def( "AddDays", &CEU3Date::AddDays ),

class_< CCountryTag >("CCountryTag")
	.def( "GetCountry", &CCountryTag::GetCountry)
	.def( self == self )
	.def( const_self == const_self )
	.def( "GetTag", &CCountryTag::GetTag )
	.def( "IsReal", &CCountryTag::IsReal )
	.def( "GetIndex", &CCountryTag::GetIndex )
	.def( "IsValid",  &CCountryTag::IsValid )
	.def( tostring(const_self) ),

class_< CNullTag, CCountryTag >("CNullTag")
	.def( constructor<>() ),

class_< CCountryDataBase >("CCountryDataBase")
	.scope
	[
		def( "GetTag", &CCountryDataBase_GetTag )
	],

class_< CCountry >("CCountry")
	.def( "Exists", &CCountry::Exists )
	.def( "GetStrategy", &CCountry::GetStrategy)
	.def( "GetCountryTag", &CCountry::GetCountryTag )
	.def( "GetUnits", &CCountry::GetUnits )
	.def( "GetUnitsIterator", &CCountry::GetUnits, return_clausewitz_iterator)
	.def( "GetOwnedProvinces", &CCountry::GetOwnedProvinces, return_clausewitz_iterator )
	.def( "GetControlledProvinces", &CCountry::GetControlledProvinces, return_clausewitz_iterator )
	.def( "GetCoreProvinces", &CCountry::GetCoreProvinces, return_clausewitz_iterator )
	.def( "GetAlignmentCord", &CCountry::GetAlignmentCord )
	.def( "GetAlignment", &CCountry::GetAlignment )
	.def( "GetDissent",  &CCountry::GetDissent )
	.def( "GetNationalUnity", &CCountry::GetNationalUnity )
	.def( "GetDailyNeed", &CCountry::GetDailyNeed )
	.def( "GetDailyExpense", &CCountry::GetDailyExpense )
	.def( "GetDailyBalance", &CCountry::GetDailyBalance )
	.def( "GetDailyIncome", &CCountry::GetDailyIncome )
	.def( "GetOfficerRatio", &CCountry::GetOfficerRatio )
	.def( "GetDiplomaticInfluence", &CCountry::GetDiplomaticInfluence )
	.def( "IsNeighbour", &CCountry::IsNeighbour )
	.def( "GetNeighbours", &CCountry::GetNeighbours, return_clausewitz_iterator )
	.def( "GetActingCapitalLocation", &CCountry::GetActingCapitalLocation )
	.def( "GetCapitalLocation", &CCountry::GetCapitalLocation )
	.def( "GetCurrentAtWarWith", &CCountry::GetCurrentAtWarWith, return_clausewitz_iterator )
	.def( "GetSpyingOnUs", &CCountry::GetSpyingOnUs, return_clausewitz_iterator )
	.def( "IsAtWar", &CCountry::IsAtWar )
	.def( "IsEnemy", &CCountry::IsEnemy )
	.def( "IsFriend", &CCountry::IsFriend )
	.def( "GetManpower", &CCountry::GetManpower )
	.def( "GetDiplomaticDistance", &CCountry::GetDiplomaticDistance )
	.def( "GetNumOfAllies", &CCountry::GetNumOfAllies )
	.def( "GetAllies", &CCountry::GetAllies, return_clausewitz_iterator )
	.def( "GetCapital", &CCountry::GetActingCapital )
	.def( "GetRules", &CCountry::GetRules )
	.def( "GetNumberOfControlledProvinces", &CCountry::GetNumberOfControlledProvinces )
	.def( "GetNumberOfOwnedProvinces", &CCountry::GetNumberOfOwnedProvinces )
	.def( "HasDiplomatEnroute", &CCountry::HasDiplomatEnroute )
	.def( "GetRelation", &CCountry::GetRelation )
	.def( "GetFaction", &CCountry::GetFaction )
	.def( "HasFaction", &CCountry::HasFaction )
	.def( "IsFactionLeader", &CCountry::IsFactionLeader )
	.def( "GetGovernment", &CCountry::GetGovernment )
	.def( "IsMajor", &CCountry::IsMajor )
	.def( "HasConstruction", &CCountry::HasConstruction )
	.def( "GetProductionDistributionAt", &CCountry::GetProductionDistributionAt )
	.def( "GetLeadershipDistributionAt", &CCountry::GetLeadershipDistributionAt )
	.def( "GetTotalIC", &CCountry::GetTotalIC )
	.def( "CalculateIsAllied", &CCountry::CalculateIsAllied )
	.def( "GetAvailableIC", &CCountry::GetAvailableIC )
	.def( "GetPool", &CCountry::GetPool )
	.def( "GetBuildCostMP", &CCountry::GetBuildCostMP )
	.def( "GetBuildCostIC", &CCountry::GetBuildCostIC )
	.def( "GetBuildTime", &CCountry::GetBuildTime )
	.def( "GetBuildCost", &CCountry::GetBuildCost )
	.def( "IsBuildingAllowed", &CCountry::IsBuildingAllowed )
	.def( "GetUsedIC", &CCountry::GetUsedIC )
	.def( "GetICPart", &CCountry::GetICPart )
	.def( "GetStrategicWarfare", &CCountry::GetStrategicWarfare )
	.def( "GetNavalBases", &CCountry::GetNavalBases, return_clausewitz_iterator )
	.def( "GetAirBases", &CCountry::GetAirBases, return_clausewitz_iterator )
	.def( "GetSpyPresence", &CCountry::GetSpyPresence )
	.def( "GetNumberOfFreeSpies", &CCountry::GetNumberOfFreeSpies )
	.def( "GetRulingIdeology", &CCountry::GetRulingIdeology )
	.def( "AccessIdeologyPopularity", &CCountry::AccessIdeologyPopularity )
	.def( "AccessIdeologyOrganization", &CCountry::AccessIdeologyOrganization )
	.def( "IsGovernmentInExile", &CCountry::IsGovernmentInExile )
	.def( "GetSurrenderLevel", &CCountry::GetSurrenderLevel )
	.def( "GetGlobalModifier", &CCountry::GetGlobalModifier )
	.def( "GetAbility", &CCountry::GetAbility )
	.def( "GetTechnologyStatus", &CCountry::GetTechnologyStatus )
	.def( "GetAllowedResearchSlots", &CCountry::GetAllowedResearchSlots )
	.def( "GetNumberOfCurrentResearch", &CCountry::GetNumberOfCurrentResearch )
	.def( "GetLaw", static_cast< const CLaw* (CCountry::*)(const CLawGroup*) const >(&CCountry::GetLaw) )
	.def( "GetLawFromIndex", static_cast< const CLaw* (CCountry::*)(int) const >(&CCountry::GetLaw) )
	.def( "IsMobilized", &CCountry::IsMobilized )
	.def( "MayLiberateCountries", &CCountry::MayLiberateCountries )
	.def( "GetPossibleLiberations", &CCountry::GetPossibleLiberations, return_clausewitz_iterator )
	.def( "CanCreatePuppet", &CCountry::MayReleaseVassals )
	.def( "CanBreakNAPWith", &CCountry::CanBreakNAPWith )
	.def( "GetPossiblePuppets", &CCountry::GetPossibleVassals, return_clausewitz_iterator )
	.def( "GetTotalLeadership", &CCountry::GetTotalLeadership )
	.def( "GetConvoyBuildCost", &CCountry::GetConvoyBuildCost )
	.def( "GetConvoyBuildTime", &CCountry::GetConvoyBuildTime )
	.def( "GetEscortBuildCost", &CCountry::GetEscortBuildCost )
	.def( "GetEscortBuildTime", &CCountry::GetEscortBuildTime )
	.def( "GetConvoys", &CCountry::GetConvoys, return_clausewitz_iterator )
	.def( "NeedConvoyToTradeWith", &CCountry::NeedConvoyToTradeWith )
	.def( "GetTotalNeededTransports", &CCountry::GetTotalNeededTransports )
	.def( "GetTransports", &CCountry::GetTransports )
	.def( "GetTotalConvoyTransports", &CCountry::GetTotalConvoyTransports )
	.def( "GetTotalNeededConvoyTransports", &CCountry::GetTotalNeededConvoyTransports )
	.def( "GetEscorts", &CCountry::GetEscorts )
	.def( "GetMaxNeutralityForWarWith", &CCountry::GetMaxNeutralityForWarWith )
	.def( "GetNumOfPorts", &CCountry::GetNumOfPorts )
	.def( "GetNumOfAirfields", &CCountry::GetNumOfAirfields )
	.def( "GetDiplomacy", &CCountry::GetDiplomacy, return_clausewitz_iterator )
	.def( "GetOverlord", &CCountry::GetOverlord )
	.def( "GetVassals", &CCountry::GetVassals, return_clausewitz_iterator )
	.def( "GetMaxIC", &CCountry::GetMaxIC )
	.def( "GetNeutrality", &CCountry::GetNeutrality )
	.def( "GetEffectiveNeutrality", &CCountry::GetEffectiveNeutrality )
	.def( "GetHighestThreat", &CCountry::GetHighestThreat )
	.def( "GetSupplyBalanceAverage", &CCountry::GetSupplyBalanceAverage )
	.def( "GetMoneyBalanceAverage", &CCountry::GetMoneyBalanceAverage )
	.def( "IsSubject", &CCountry::IsSubject )
	.def( "IsPuppet", &CCountry::IsSubject )
	.def( "IsNeighbourToFactionHostile", &CCountry::IsNeighbourToFactionHostile )
	.def( "HasNeighborInFaction", &CCountry::HasNeighborInFaction )
	.def( "CalcDesperation", &CCountry::CalcDesperation )
	.def( "CalculateReinforcementMultiplier", &CCountry::CalculateReinforcementMultiplier )
	.def( "HasExtraManpowerLeft", &CCountry::HasExtraManpowerLeft )
	.def( "CalculateNumberOfActiveInfluences", &CCountry::CalculateNumberOfActiveInfluences )
	.def( "GetFlags", &CCountry::GetFlags )
	.def( "GetVariables", &CCountry::GetVariables )
	.def( "GetTotalProduced", &CCountry::GetTotalProduced )
	.def( "GetHomeProduced", &CCountry::GetHomeProduced )
	.def( "GetConvoyedIn", &CCountry::GetConvoyedIn )
	.def( "GetConvoyedOut", &CCountry::GetConvoyedOut )
	.def( "GetTradedAway", &CCountry::GetTradedAway )
	.def( "GetTradedFor", &CCountry::GetTradedFor )
	.def( "GetTradedAwaySansAlliedSupply", &CCountry::GetTradedAwaySansAlliedSupply )
	.def( "GetTradedForSansAlliedSupply", &CCountry::GetTradedForSansAlliedSupply )
	.def( "GetMinister", &CCountry::GetMinister )
	.def( "GetTotalCoreBuildingLevels", &CCountry::GetTotalCoreBuildingLevels )
	.def( "HasIncomingTradeOffer", &CCountry::HasIncomingTradeOffer )
	.def( "GetCurrentResearch", &CCountry::GetCurrentResearch, return_clausewitz_iterator )
	.def( "GetConstructions", &CCountry::GetConstructions, return_clausewitz_iterator )
	.def( "GetPossibleMinisters", &CCountry::GetPossibleMinisters, return_clausewitz_iterator )
	.def( "GetHistoricalMinisters", &CCountry::GetHistoricalMinisters, return_clausewitz_iterator )
	.def( "GetMinisters", &CCountry::GetMinisters, return_clausewitz_iterator )
	.def( "AICalculateExpense", &CCountry::AICalculateExpense )
	.def( "AIGetTradeRoutes", &CCountry::AIGetTradeRoutes, return_clausewitz_iterator )
	.def( "GetAreActingCapitalsOnSameContinent", &CCountry::GetAreActingCapitalsOnSameContinent ),

class_< CConstruction >("CConstruction")
	.def( "IsMilitary", &CConstruction::IsMilitary )
	.def( "GetMilitary", &CConstruction::GetMilitary )
	.def( "IsConvoy", &CConstruction::IsConvoy )
	.def( "IsBuilding", &CConstruction::IsBuilding )
	.def( "GetCost", &CConstruction::GetCost )
	.def( "GetSize", &CConstruction::GetSize ),

class_< CMilitaryConstruction, CConstruction >("CMilitaryConstruction")
	.def( "IsLand", &CMilitaryConstruction::IsLand )
	.def( "IsAir", &CMilitaryConstruction::IsAir )
	.def( "IsNaval", &CMilitaryConstruction::IsNaval )
	.def( "GetBrigades", &CMilitaryConstruction::GetBrigades, return_clausewitz_iterator ),

class_< CBrigadeConstructionDefinition >("CBrigadeConstructionDefinition")
	.def( "GetType", &CBrigadeConstructionDefinition::GetType ),

class_< CVariables >("CVariables")
	.def( "GetVariable", &CVariables::GetVariable ),

class_< CFlags >("CFlags")
	.def( "IsFlagSet", &CFlags::IsFlagSet ),

class_< CLawGroup >("CLawGroup")
	.def( "IsValid", &CLawGroup::IsValid )	
	.def( "GetIndex", &CLawGroup::GetIndex )
	.def( "GetKey", &CLawGroup::GetKey ),

class_< CLaw >("CLaw")
	.def( "IsValid", &CLaw::IsValid )
	.def( "GetKey", &CLaw::GetKey )
	.def( "GetIndex", &CLaw::GetIndex )
	.def( "ValidFor", &CLaw::ValidFor )
	.def( "GetGroup", &CLaw::GetGroup ),

class_< CIdeologyData >("CIdeologyData")
	.def("GetValue", &CIdeologyData::GetValue )
	.def("CalculateTotalSum", &CIdeologyData::CalculateTotalSum ),

class_< CGovernment >("CGovernment")
	.def( "IsValid", &CGovernment::IsValid )
	.def( const_self == const_self ),

class_< CModifier >("CModifier")
	.def( "GetValue", &CModifier::GetValue )
	.enum_("ModifierType")
	[
		value("_MODIFIER_MINIMUM_REVOLT_RISK_", _MODIFIER_MINIMUM_REVOLT_RISK_),
		value("_MODIFIER_LOCAL_REVOLT_RISK_", _MODIFIER_LOCAL_REVOLT_RISK_),
		value("_MODIFIER_GLOBAL_REVOLT_RISK_", _MODIFIER_GLOBAL_REVOLT_RISK_),
		value("_MODIFIER_LOCAL_MANPOWER_", _MODIFIER_LOCAL_MANPOWER_),
		value("_MODIFIER_GLOBAL_MANPOWER_", _MODIFIER_GLOBAL_MANPOWER_),
		value("_MODIFIER_LOCAL_MANPOWER_MODIFIER_", _MODIFIER_LOCAL_MANPOWER_MODIFIER_),
		value("_MODIFIER_GLOBAL_MANPOWER_MODIFIER_", _MODIFIER_GLOBAL_MANPOWER_MODIFIER_),
		value("_MODIFIER_ATTRITION_", _MODIFIER_ATTRITION_),
		value("_MODIFIER_WAR_EXHAUSTION_", _MODIFIER_WAR_EXHAUSTION_),
		value("_MODIFIER_MAX_WAR_EXHAUSTION_", _MODIFIER_MAX_WAR_EXHAUSTION_),
		value("_MODIFIER_FORT_LEVEL_", _MODIFIER_FORT_LEVEL_),
		value("_MODIFIER_COASTAL_FORT_LEVEL_", _MODIFIER_COASTAL_FORT_LEVEL_),
		value("_MODIFIER_INFRASTRUCTURE_", _MODIFIER_INFRASTRUCTURE_),
		value("_MODIFIER_LOCAL_INFRASTRUCTURE_", _MODIFIER_LOCAL_INFRASTRUCTURE_),
		value("_MODIFIER_GLOBAL_INFRASTRUCTURE_", _MODIFIER_GLOBAL_INFRASTRUCTURE_),
		value("_MODIFIER_IC_", _MODIFIER_IC_),
		value("_MODIFIER_LOCAL_IC_", _MODIFIER_LOCAL_IC_),
		value("_MODIFIER_GLOBAL_IC_", _MODIFIER_GLOBAL_IC_),
		value("_MODIFIER_LOCAL_CRUDE_OIL_", _MODIFIER_LOCAL_CRUDE_OIL_),
		value("_MODIFIER_GLOBAL_CRUDE_OIL_", _MODIFIER_GLOBAL_CRUDE_OIL_),
		value("_MODIFIER_LOCAL_ENERGY_", _MODIFIER_LOCAL_ENERGY_),
		value("_MODIFIER_GLOBAL_ENERGY_", _MODIFIER_GLOBAL_ENERGY_),
		value("_MODIFIER_LOCAL_METAL_", _MODIFIER_LOCAL_METAL_),
		value("_MODIFIER_GLOBAL_METAL_", _MODIFIER_GLOBAL_METAL_),
		value("_MODIFIER_LOCAL_RARE_MATERIALS_", _MODIFIER_LOCAL_RARE_MATERIALS_),
		value("_MODIFIER_GLOBAL_RARE_MATERIALS_", _MODIFIER_GLOBAL_RARE_MATERIALS_),
		value("_MODIFIER_LOCAL_SUPPLIES_", _MODIFIER_LOCAL_SUPPLIES_),
		value("_MODIFIER_GLOBAL_SUPPLIES_", _MODIFIER_GLOBAL_SUPPLIES_),
		value("_MODIFIER_LOCAL_FUEL_", _MODIFIER_LOCAL_FUEL_),
		value("_MODIFIER_GLOBAL_FUEL_", _MODIFIER_GLOBAL_FUEL_),
		value("_MODIFIER_LOCAL_MONEY_", _MODIFIER_LOCAL_MONEY_),
		value("_MODIFIER_GLOBAL_MONEY_", _MODIFIER_GLOBAL_MONEY_),
		value("_MODIFIER_LOCAL_LEADERSHIP_", _MODIFIER_LOCAL_LEADERSHIP_),
		value("_MODIFIER_GLOBAL_LEADERSHIP_", _MODIFIER_GLOBAL_LEADERSHIP_),
		value("_MODIFIER_LOCAL_LEADERSHIP_MODIFIER_", _MODIFIER_LOCAL_LEADERSHIP_MODIFIER_),
		value("_MODIFIER_GLOBAL_LEADERSHIP_MODIFIER_", _MODIFIER_GLOBAL_LEADERSHIP_MODIFIER_),
		value("_MODIFIER_DRIFT_SPEED_", _MODIFIER_DRIFT_SPEED_),
		value("_MODIFIER_SUSEPTIBILITY_", _MODIFIER_SUSEPTIBILITY_),
		value("_MODIFIER_INCORPORATE_COST_", _MODIFIER_INCORPORATE_COST_),
		value("_MODIFIER_TERRITORIAL_PRIDE_", _MODIFIER_TERRITORIAL_PRIDE_),
		value("_MODIFIER_WAR_CONSUMER_GOODS_DEMAND_", _MODIFIER_WAR_CONSUMER_GOODS_DEMAND_),
		value("_MODIFIER_PEACE_CONSUMER_GOODS_DEMAND_", _MODIFIER_PEACE_CONSUMER_GOODS_DEMAND_),
		value("_MODIFIER_ESPIONAGE_BONUS_", _MODIFIER_ESPIONAGE_BONUS_),
		value("_MODIFIER_DISSENT_", _MODIFIER_DISSENT_),
		value("_MODIFIER_NATIONAL_UNITY_", _MODIFIER_NATIONAL_UNITY_),
		value("_MODIFIER_NAVAL_CAPACITY_", _MODIFIER_NAVAL_CAPACITY_),
		value("_MODIFIER_AIR_CAPACITY_", _MODIFIER_AIR_CAPACITY_),
		value("_MODIFIER_ALIGN_TOWARDS_", _MODIFIER_ALIGN_TOWARDS_),
		value("_MODIFIER_RADAR_LEVEL_", _MODIFIER_RADAR_LEVEL_),
		value("_MODIFIER_SUPPLY_CONSUMPTION_", _MODIFIER_SUPPLY_CONSUMPTION_),
		value("_MODIFIER_PEACETIME_MANPOWER_ROTATION_", _MODIFIER_PEACETIME_MANPOWER_ROTATION_),
		value("_MODIFIER_UNIT_RECRUITMENT_TIME_", _MODIFIER_UNIT_RECRUITMENT_TIME_),
		value("_MODIFIER_UNIT_START_EXPERIENCE_", _MODIFIER_UNIT_START_EXPERIENCE_),
		value("_MODIFIER_UNIT_REPAIR_", _MODIFIER_UNIT_REPAIR_),
		value("_MODIFIER_COUNTER_INTELLIGENCE_", _MODIFIER_COUNTER_INTELLIGENCE_),
		value("_MODIFIER_COUNTER_ESPIONAGE_", _MODIFIER_COUNTER_ESPIONAGE_),
		value("_MODIFIER_THREAT_IMPACT_", _MODIFIER_THREAT_IMPACT_),
		value("_MODIFIER_PEACE_OFFMAP_INTEL_", _MODIFIER_PEACE_OFFMAP_INTEL_),
		value("_MODIFIER_OFFMAP_LAND_INTEL_", _MODIFIER_OFFMAP_LAND_INTEL_),
		value("_MODIFIER_OFFMAP_NAVAL_INTEL_", _MODIFIER_OFFMAP_NAVAL_INTEL_),
		value("_MODIFIER_OFFMAP_INDUSTRY_INTEL_", _MODIFIER_OFFMAP_INDUSTRY_INTEL_),
		value("_MODIFIER_OFFMAP_POLITICAL_INTEL_", _MODIFIER_OFFMAP_POLITICAL_INTEL_),
		value("_MODIFIER_COMBAT_MOVEMENT_SPEED_", _MODIFIER_COMBAT_MOVEMENT_SPEED_),
		value("_MODIFIER_ATTACK_REINFORCE_CHANCE_", _MODIFIER_ATTACK_REINFORCE_CHANCE_),
		value("_MODIFIER_DEFEND_REINFORCE_CHANCE_", _MODIFIER_DEFEND_REINFORCE_CHANCE_),
		value("_MODIFIER_COMBAT_WIDTH_", _MODIFIER_COMBAT_WIDTH_),
		value("_MODIFIER_ORG_REGAIN_", _MODIFIER_ORG_REGAIN_),
		value("_MODIFIER_NATIONAL_UNITY_EFFECT_", _MODIFIER_NATIONAL_UNITY_EFFECT_),
		value("_MODIFIER_RULING_PARTY_SUPPORT_", _MODIFIER_RULING_PARTY_SUPPORT_),
		value("_MODIFIER_LAND_ORGANISATION_", _MODIFIER_LAND_ORGANISATION_),
		value("_MODIFIER_AIR_ORGANISATION_", _MODIFIER_AIR_ORGANISATION_),
		value("_MODIFIER_NAVAL_ORGANISATION_", _MODIFIER_NAVAL_ORGANISATION_),
		value("_MODIFIER_RESEARCH_EFFICIENCY_", _MODIFIER_RESEARCH_EFFICIENCY_),
		value("_MODIFIER_INDUSTRIAL_EFFICIENCY_", _MODIFIER_INDUSTRIAL_EFFICIENCY_),
		value("_MODIFIER_LOCAL_ANTI_AIR_", _MODIFIER_LOCAL_ANTI_AIR_),
		value("_MODIFIER_LOCAL_PARTISAN_SUPPORT_", _MODIFIER_LOCAL_PARTISAN_SUPPORT_),
		value("_MODIFIER_RESERVES_PENALTY_SIZE_", _MODIFIER_RESERVES_PENALTY_SIZE_),
		value("_MODIFIER_NEUTRALITY_CHANGE_", _MODIFIER_NEUTRALITY_CHANGE_),
		value("_MODIFIER_PARTISAN_EFFICENCY_", _MODIFIER_PARTISAN_EFFICENCY_),
		value("_MODIFIER_NAVAL_BASE_EFFICIENCY_", _MODIFIER_NAVAL_BASE_EFFICIENCY_),
		value("_MODIFIER_SUPPLY_THROUGHPUT_",_MODIFIER_SUPPLY_THROUGHPUT_),
		value("_MODIFIER_OFFICER_RECRUITMENT_",_MODIFIER_OFFICER_RECRUITMENT_)

	],

class_< CRule >("CRule")
	.enum_("RuleType")
	[
		value( "_RULE_NONE_", _RULE_NONE_ ),
		value( "_RULE_LIMITED_WAR_", _RULE_LIMITED_WAR_ ),
		value( "_RULE_ALLIANCE_GUARANTEE_", _RULE_ALLIANCE_GUARANTEE_ ),
		value( "_RULE_FREE_RESOURCE_GIFTS_", _RULE_FREE_RESOURCE_GIFTS_ )
	]
	.def( "GetValue", &CRule::GetValue ),

class_< CList<CCountryTag> >("CCountryTagList"),
class_< CCountryList, CList<CCountryTag> >("CCountryList")
	.def( "IsEnemy", &CCountryList::IsEnemy ),

class_< CAIStrategy >("CAIStrategy")
	.enum_("AIPersonality")
	[
		value( "_AI_UNDEFINED_", CAIStrategy::_AI_UNDEFINED_ ),
		value( "_AI_MILITARIST_", CAIStrategy::_AI_MILITARIST_ ),
		value( "_AI_INDUSTRIALIST_", CAIStrategy::_AI_INDUSTRIALIST_ ),
		value( "_AI_DIPLOMAT_", CAIStrategy::_AI_DIPLOMAT_ ),
		value( "_AI_BALANCED_", CAIStrategy::_AI_BALANCED_ )
	]
	.def( "GetCountry", &CAIStrategy::GetCountry )
	.def( "GetCountryTag", &CAIStrategy::GetCountryTag )
	.def( "GetFriendliness", &CAIStrategy::GetFriendliness )
	.def( "GetThreat", &CAIStrategy::GetThreat )
	.def( "GetAntagonism", &CAIStrategy::GetAntagonism )
	.def( "GetProtectionism", &CAIStrategy::GetProtectionism )
	.def( "GetPersonality", &CAIStrategy::GetPersonality)
	.def( "IsMilitarist", &CAIStrategy::IsMilitarist )
	.def( "IsDiplomat", &CAIStrategy::IsDiplomat )
	.def( "IsIndustrialist", &CAIStrategy::IsIndustrialist )
	.def( "IsBalanced", &CAIStrategy::IsBalanced )
	.def( "GetAccessScore", &CAIStrategy::GetAccessScore )
	.def( "GetTheatres", &CAIStrategy::GetTheatres, return_clausewitz_iterator)
	.def( "GetWantedSubUnits", &CAIStrategy::GetWantedSubUnits )
	.def( "AddSubUnit", &CAIStrategy::AddSubUnit )
	.def( "PrepareWar", &CAIStrategy::PrepareWar )
	.def( "PrepareLimitedWar", &CAIStrategy::PrepareLimitedWar )
	.def( "PrepareWarDecision", &CAIStrategy::PrepareWarDecision )
	.def( "CancelPrepareWar", &CAIStrategy::CancelPrepareWar )
	.def( "IsPreparingWar", &CAIStrategy::IsPreparingWar )
	.def( "IsPreparingWarWith", &CAIStrategy::IsPreparingWarWith )
	.def( "GetWarScoreWith", &CAIStrategy::GetWarScoreWith )
	.def( "GetWarTarget", &CAIStrategy::GetWarTarget )
	.def( "GetWarTargets", &CAIStrategy::GetWarTargets ),

class_< CSubUnitDataBase >("CSubUnitDataBase")
	.scope // adaptored methods so we wont have to fetch instance  all the time
	[
		def( "GetSubUnitList", &CSubUnitDataBase_GetSubUnitList, return_clausewitz_iterator),
		def( "GetNumberOfSubUnits", &CSubUnitDataBase_GetNumberOfSubUnits ),
		def( "GetSubUnit", &CSubUnitDataBase_GetSubUnit ),
		def( "GetSubUnitByIndex", &CSubUnitDataBase_GetSubUnitByIndex )
	],

class_< CSubUnitDefinition >("CSubUnitDefinition")
	.def( "GetName", &CSubUnitDefinition::GetName )
	.def( "GetKey", &CSubUnitDefinition::GetKey )
	.def( "IsShip", &CSubUnitDefinition::IsShip )
	.def( "IsRegiment", &CSubUnitDefinition::IsRegiment )
	.def( "IsCag", &CSubUnitDefinition::IsCag )
	.def( "IsBuildable", &CSubUnitDefinition::IsBuildable )
	.def( "IsTransport", &CSubUnitDefinition::IsTransport )
	.def( "IsCapitalShip", &CSubUnitDefinition::IsCapitalShip )
	.def( "IsSub", &CSubUnitDefinition::IsSub )
	.def( "CanParadrop", &CSubUnitDefinition::CanParadrop )
	.def( "IsBomber", &CSubUnitDefinition::IsBomber )
	.def( "IsCarrier", &CSubUnitDefinition::IsCarrier )
	.def( "IsValid", &CSubUnitDefinition::IsValid )
	.def( "GetIndex", &CSubUnitDefinition::GetIndex )
	.def( "IsSecondRank", &CSubUnitDefinition::IsSecondRank )
	.def( "GetCompletionSize", &CSubUnitDefinition::GetCompletionSize )
	.def( "GetBuildCostIC", &CSubUnitDefinition::GetBuildCostIC )
	.def( "GetBuildCostMP", &CSubUnitDefinition::GetBuildCostMP )
	.def( "GetBuildTime", &CSubUnitDefinition::GetBuildTime )
	.def( "GetDefaultStrength", &CSubUnitDefinition::GetDefaultStrength )
	.def( "GetCombatWidth", &CSubUnitDefinition::GetCombatWidth )
	.def( "GetDefensivness", &CSubUnitDefinition::GetDefensivness )
	.def( "GetToughness", &CSubUnitDefinition::GetToughness )
	.def( "GetSoftness", &CSubUnitDefinition::GetSoftness )
	.def( "GetCombatWidth", &CSubUnitDefinition::GetCombatWidth ),


class_< CUnit >("CUnit")
	.def( "GetName", &CUnit::GetName )
	.def( "IsMoving", &CUnit::IsMoving )
	.def( "GetChildren", &CUnit::GetChildren, return_clausewitz_iterator),

class_< CContinent >("CContinent")
	.def( "GetName", &CContinent::GetName )
	.def( "GetTag", &CContinent::GetTag )
	.def( const_self == const_self ),

class_< CProvince >("CProvince")
	.def( "GetProvinceID", &CProvince::GetProvinceID )
	.def( "GetUnits", &CProvince::GetUnits, return_clausewitz_iterator )
	.def( "GetNumberOfUnits", &CProvince::GetNumberOfUnits )
	.def( "GetContinent", &CProvince::GetContinent )
	.def( "GetInfrastructure", &CProvince::GetInfrastructure )
	.def( "GetMaxInfrastructure", &CProvince::GetMaxInfrastructure )
	.def( "GetBuilding", &CProvince::GetBuilding )
	.def( "HasBuilding", &CProvince::HasBuilding )
	.def( "GetCurrentConstructionLevel", &CProvince::GetCurrentConstructionLevel )
	.def( "IsFrontProvince", &CProvince::IsFrontProvince )
	.def( "HasAdjacentEnemyOrCB", &CProvince::HasAdjacentEnemyOrCB )
	.def( "GetController", &CProvince::GetController ) 
	.def( "GetOwner", &CProvince::GetOwner )
	.def( "GetIntelLevel", &CProvince::GetIntelLevel )
	.def( "GetFortLevel", &CProvince::GetFortLevel )
	.def( "GetCoastalFortLevel", &CProvince::GetCoastalFortLevel ),

class_< CDiplomacyStatus >("CDiplomacyStatus")
	.def( "GetValue", &CDiplomacyStatus::GetValue )
	.def( "GetFloatValue", &CDiplomacyStatus::GetFloatValue )
	.def( "IsGuaranting", &CDiplomacyStatus::IsGuaranting)
	.def( "IsGuaranteed", &CDiplomacyStatus::IsGuaranteed)
	.def( "HasNap", &CDiplomacyStatus::HasNap)
	.def( "HasEmbargo", &CDiplomacyStatus::HasEmbargo)
	.def( "IsBeingInfluenced", &CDiplomacyStatus::IsBeingInfluenced)
	.def( "HasAlliance", &CDiplomacyStatus::HasAlliance)
	.def( "GetThreat", &CDiplomacyStatus::GetThreat)
	.def( "HasMilitaryAccess", &CDiplomacyStatus::HasMilitaryAccess)
	.def( "IsFightingWarTogether", &CDiplomacyStatus::IsFightingWarTogether)
	.def( "HasWar", &CDiplomacyStatus::HasWar)
	.def( "HasTruce", &CDiplomacyStatus::HasTruce)
	.def( "AllowDebts", &CDiplomacyStatus::AllowDebts )
	.def( "HasAnyAgreement", &CDiplomacyStatus::HasAnyAgreement)
	.def( "HasFriendlyAgreement", &CDiplomacyStatus::HasFriendlyAgreement)
	.def( "HasHostileAgreement", &CDiplomacyStatus::HasHostileAgreement)
	.def( "GetTarget", &CDiplomacyStatus::GetTarget )
	.def( "GetWar", &CDiplomacyStatus::GetWar )
	.def( "GetTradeRoutes", &CDiplomacyStatus::GetTradeRoutes, return_clausewitz_iterator ),

class_< CWar >("CWar")
	.def( "IsLimited", &CWar::IsLimited )
	.def( "GetAttackers", &CWar::GetAttackers )
	.def( "GetDefenders", &CWar::GetDefenders )
	.def( "IsPartOfWar", &CWar::IsPartOfWar )
	.def( "GetStartDate", &CWar::GetStartDate )
	.def( "GetCurrentRunningTimeInMonths", &CWar::GetCurrentRunningTimeInMonths ),

class_< CIdeologyGroup >("CIdeologyGroup")
	.def( "GetPosition", &CIdeologyGroup::GetPosition )
	.def( "GetFaction", &CIdeologyGroup::GetFaction )
	.def( "GetKey", &CIdeologyGroup::GetKey )
	.def( const_self == const_self ),

class_< CIdeology >("CIdeology")
	.def( "GetKey", &CIdeology::GetKey )
	.def( "GetGroup", &CIdeology::GetGroup ),

class_< CFaction >("CFaction")
	.def( "IsValid", &CFaction::IsValid )
	.def( "GetFactionLeader", &CFaction::GetFactionLeader )
	.def( "GetProgress", &CFaction::GetProgress )
	.def( "GetNormalizedProgress", &CFaction::GetNormalizedProgress )
	.def( "GetIdeologyGroup", &CFaction::GetIdeologyGroup )
	.def( "GetNumberOfMembers", &CFaction::GetNumberOfMembers )
	.def( "GetMembers", &CFaction::GetMembers, return_clausewitz_iterator )
	.def( "GetTag", &CFaction::GetTag)
	.def( self == self )
	.def( const_self == const_self ),

class_< CAlignment >("CAlignment")
	.def( "GetLastDrift", &CAlignment::GetLastDrift )
	.def( "GetDistanceFrom", &CAlignment::GetDistanceFrom ),

class_< CGoodsPool >("CGoodsPool")
	.enum_("GoodsCategory")
	[
		value( "_SUPPLIES_", _SUPPLIES_ ),
		value( "_FUEL_", _FUEL_ ),
		value( "_MONEY_", _MONEY_ ),
		value( "_CRUDE_OIL_", _CRUDE_OIL_ ),
		value( "_METAL_", _METAL_ ),
		value( "_ENERGY_", _ENERGY_ ),
		value( "_RARE_MATERIALS_", _RARE_MATERIALS_ ),
		value( "_GC_NUMOF_", _GC_NUMOF_ )
	]
	.def( "GetFloat", &CGoodsPool::GetFloat )
	.def( "Get", &CGoodsPool::Get ),

class_< CCurrentGameState >("CCurrentGameState")
	.def( "GetInstance", &CCurrentGameState::GetInstance )
	.scope // adaptored methods so we wont have to fetch instance  all the time
	[
		def( "GetCurrentDate", &CCurrentGameState_GetCurrentDate ),
		def( "GetCountries", &CCurrentGameState_GetCountries, return_clausewitz_iterator ),
		def( "GetFactions", &CCurrentGameState_GetFactions, return_clausewitz_iterator ),
		def( "GetFaction", &CCurrentGameState_GetFaction ),
		def( "GetAIRand", &CCurrentGameState_GetAIRand ),
		def( "GetProvince", &CCurrentGameState_GetProvince ),
		def( "GetPlayer", &CCurrentGameState_GetPlayer ),
		def( "IsGlobalFlagSet", &CCurrentGameState_IsGlobalFlagSet )
	],

class_< CTradeRoute >("CTradeRoute")
	.def( "GetTradedFromOf", &CTradeRoute::GetTradedFromOf )
	.def( "GetTradedToOf", &CTradeRoute::GetTradedToOf )
	.def( "GetFrom", &CTradeRoute::GetFrom )
	.def( "GetTo", &CTradeRoute::GetTo )
	.def( "IsValid", &CTradeRoute::IsValid )
	.def( "IsInactive", &CTradeRoute::IsInactive )
	.def( "GetConvoyResponsible", &CTradeRoute::GetConvoyResponsible )
	.def( "GetLastInactive", &CTradeRoute::GetLastInactive )
	.scope
	[
		def( "GetCost", &CTradeRoute::GetCost )
	],

class_< CDiplomaticAction >("CDiplomaticAction")
	.enum_("EType")
	[
		value( "PROPOSE", CDiplomaticAction::PROPOSE ),
		value( "DECLINE", CDiplomaticAction::DECLINE ),
		value( "ACCEPT", CDiplomaticAction::ACCEPT )
	]
	.def( "GetValue", &CDiplomaticAction::GetValue )
	.def( "SetValue", &CDiplomaticAction::SetValue )
	.def( "GetType", &CDiplomaticAction::GetType )
	.def( "IsValid", &CDiplomaticAction::IsValid )
	.def( "IsSelectable", &CDiplomaticAction::IsSelecable )
	.def( "GetAIAcceptance", &CDiplomaticAction::GetAIAcceptance ),

class_< CTradeAction, CDiplomaticAction >("CTradeAction")
	.scope
	[
		def( "Create", &CTradeAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() )
	.def( "GetRoute", &CTradeAction::GetRoute )
	.def( "GetTrading", &CTradeAction::GetTrading )
	.def( "SetTrading", &CTradeAction::SetTrading )
	.def( "SetRoute", &CTradeAction::SetRoute )
	.def( "IsConvoyPossible", &CTradeAction::IsConvoyPossible ),

class_< CDeclareWarAction, CDiplomaticAction >("CDeclareWarAction")
	.scope
	[
		def( "Create", &CDeclareWarAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CGuaranteeAction, CDiplomaticAction >("CGuaranteeAction")
	.scope
	[
		def( "Create", &CGuaranteeAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CInfluenceNation, CDiplomaticAction >("CInfluenceNation")
	.scope
	[
		def( "Create", &CInfluenceNation::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CMilitaryAccessAction, CDiplomaticAction >("CMilitaryAccessAction")
	.scope
	[
		def( "Create", &CMilitaryAccessAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CAllianceAction, CDiplomaticAction >("CAllianceAction")
	.scope
	[
		def( "Create", &CAllianceAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< COfferMilitaryAccessAction, CDiplomaticAction >("COfferMilitaryAccessAction")
	.scope
	[
		def( "Create", &COfferMilitaryAccessAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CCallAllyAction, CDiplomaticAction >("CCallAllyAction")
	.scope
	[
		def( "Create", &CCallAllyAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag, CCountryTag >() )
	.def( "GetVersus", &CCallAllyAction::GetVersus )
	.def( "SetVersus", &CCallAllyAction::SetVersus )
	,

class_< CNapAction, CDiplomaticAction >("CNapAction")
	.scope
	[
		def( "Create", &CNapAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CInfluenceAllianceLeader, CDiplomaticAction >("CInfluenceAllianceLeader")
	.scope
	[
		def( "Create", &CInfluenceAllianceLeader::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CEmbargoAction, CDiplomaticAction >("CEmbargoAction")
	.scope
	[
		def( "Create", &CEmbargoAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CFactionAction, CDiplomaticAction >("CFactionAction")
	.scope
	[
		def( "Create", &CFactionAction::Create )
	]
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CAISubscriber >("CAISubscriber")
	.def( "WantTicks", &CAISubscriber::WantTicks ),

class_< CAIAgent, CAISubscriber >("CAIAgent")
	.def( "GetCountry", &CAIAgent::GetCountry )
	.def( "GetCountryTag", &CAIAgent::GetCountryTag ),

class_< CAIForeignMinister, CAIAgent >("CAIForeignMinister")
	.def( "Propose", &CAIForeignMinister::Propose )
	.def( "ProposeWar", &CAIForeignMinister::ProposeWar )
	.def( "ExecuteDiploDecisions", &CAIForeignMinister::ExecuteDiploDecisions )
	.def( "GetOwnerAI", &CAIForeignMinister::GetOwnerAI )
	.def( "PercOccupied", &CAIForeignMinister::PercOccupied )
	.def( "ClearWarProposal", &CAIForeignMinister::ClearWarProposal )
	.def( "GetProposedWarTarget", &CAIForeignMinister::GetProposedWarTarget ),

class_< CAIProductionMinister, CAIAgent >("CAIProductionMinister")
	.def( "GetOwnerAI", &CAIProductionMinister::GetOwnerAI )
	.def( "CountTransportsUnderConstruction", &CAIProductionMinister::CountTransportsUnderConstruction )
	.def( "CountEscortsUnderConstruction", &CAIProductionMinister::CountEscortsUnderConstruction )
	.def( "CountTotalDesiredEscorts", &CAIProductionMinister::CountTotalDesiredEscorts)
	.def( "GetDesperation", &CAIProductionMinister::GetDesperation)
	.def( "PrioritizeBuildQueue", &CAIProductionMinister::PrioritizeBuildQueue ),

class_< CAIEspionageMinister, CAIAgent  >("CAIEspionageMinister")
	.def( "IsAligningToFaction", &CAIEspionageMinister::IsAligningToFaction )
	.def( "GetOwnerAI", &CAIEspionageMinister::GetOwnerAI ),

class_< CAITechMinister, CAIAgent  >("CAITechMinister")
	.def( "GetOwnerAI", &CAITechMinister::GetOwnerAI )
	.def( "CanResearch", &CAITechMinister::CanResearch )
	.def( "GetTechModifers", &CAITechMinister::GetTechModifers )
	.def( "GetFolderModifers", &CAITechMinister::GetFolderModifers ),

class_< CAIPoliticsMinister, CAIAgent  >("CAIPoliticsMinister")
	.def( "GetOwnerAI", &CAIPoliticsMinister::GetOwnerAI )
	.def( "IsCapitalSafeToLiberate", &CAIPoliticsMinister::IsCapitalSafeToLiberate ),

class_< CEventScope >("CEventScope")
	.def_readwrite("_Country", &CEventScope::_Country)
	.def_readwrite("_nProvince", &CEventScope::_nProvince),
	
class_< CDecision >("CDecision")
	.def( "GetKey", &CDecision::GetKey )
	.def( "IsPotential", &CDecision::IsPotential )
	.def( "IsAllowed", &CDecision::IsAllowed ),

class_< CSimpleRandom >("CSimpleRandom")
	.def( constructor<>() )
	.def( "Seed", static_cast< void(CSimpleRandom::*)(unsigned int) >(&CSimpleRandom::Seed) )
	.def( "GetInteger", &CSimpleRandom::GetInteger )
	.def( "GetFixedPoint", &CSimpleRandom::GetFixedPoint )
	.def( "GetNumber", &CSimpleRandom::GetNumber ),

class_< CAIIntel >("CAIIntel")
	.def( constructor< const CCountryTag&, const CCountryTag& >() )
	.def( "GetFactor", &CAIIntel::GetFactor )
	.def( "GetTheirFactor", &CAIIntel::GetTheirFactor )
	.def( "GetUncertaintyFactor", &CAIIntel::GetUncertaintyFactor )
	.def( "HasNoIntel", &CAIIntel::HasNoIntel )
	.def( "CalculateTheirPercievedMilitaryStrengh", &CAIIntel::CalculateTheirPercievedMilitaryStrengh )
	.def( "CalculateOurMilitaryStrength", &CAIIntel::CalculateOurMilitaryStrength ),

class_< CUnitList >("CUnitList")
	.def( "GetTotalStrength", &CUnitList::GetTotalStrength )
	.def( "GetTotalAmountOfDivisions", &CUnitList::GetTotalAmountOfDivisions )
	.def( "GetTotalAmountOfArmies", &CUnitList::GetTotalAmountOfArmies )
	.def( "GetTotalNumOfRegiments", &CUnitList::GetTotalNumOfRegiments )
	.def( "GetTotalNumOfPlanes", &CUnitList::GetTotalNumOfPlanes )
	.def( "GetTotalNumOfShips", &CUnitList::GetTotalNumOfShips )
	.def( "GetTotalNumOfWarShips", &CUnitList::GetTotalNumOfWarShips )
	.def( "GetTotalNumOfTransports", &CUnitList::GetTotalNumOfTransports )
	.def( "GetCount", &CUnitList::GetCount ),

class_< CDistributionSetting >("CDistributionSetting")
	.def( "GetNeeded", &CDistributionSetting::GetNeeded )
	.def( "GetPercentage", &CDistributionSetting::GetBasePercentage )
	//.def( "GetPercentage", &CDistributionSetting::GetPercentage )
	.enum_("ProductionCategory")
	[
		value( "_PRODUCTION_CONSUMER_", _PRODUCTION_CONSUMER_ ),
		value( "_PRODUCTION_PRODUCTION_", _PRODUCTION_PRODUCTION_ ),
		value( "_PRODUCTION_SUPPLY_", _PRODUCTION_SUPPLY_ ),
		value( "_PRODUCTION_REINFORCEMENT_", _PRODUCTION_REINFORCEMENT_ ),
		value( "_PRODUCTION_UPGRADE_", _PRODUCTION_UPGRADE_ ),
		value( "_PRODUCTION_numof_", _PRODUCTION_numof_ )
	]
	.enum_("LeadershipCategory")
	[
		value( "_LEADERSHIP_NCO_", _LEADERSHIP_NCO_ ),
		value( "_LEADERSHIP_DIPLOMACY_", _LEADERSHIP_DIPLOMACY_ ),
		value( "_LEADERSHIP_ESPIONAGE_", _LEADERSHIP_ESPIONAGE_ ),
		value( "_LEADERSHIP_RESEARCH_", _LEADERSHIP_RESEARCH_ ),
		value( "_LEADERSHIP_numof_", _LEADERSHIP_numof_ )
	],

class_< CCommand >("CCommand")
	.def( "IsValid", &CCommand::IsValid ),

class_< CConstructSingleUnitCommand, CCommand >("CConstructSingleUnitCommand")
	//.def( constructor< CCountryTag, CList<const CSubUnitDefinition*>&, int, int, bool, CCountryTag >() )
	.def("Clone", &CConstructSingleUnitCommand::Clone),

class_< CConstructUnitCommand, CCommand >("CConstructUnitCommand")
	.def( constructor< CCountryTag, CList<const CSubUnitDefinition*>&, int, int, bool, CCountryTag, CID >() )
	.def("Clone", &CConstructUnitCommand::Clone),

class_< CCancelUnitConstructionCommand, CCommand >("CCancelUnitConstructionCommand")
	.def( constructor< CCountryTag, CID >() )
	.def("Clone", &CCancelUnitConstructionCommand::Clone),

class_< CChangePriorityCommand, CCommand >("CChangePriorityCommand")
	.def( constructor< CCountryTag, CID, int >() )
	.def("Clone", &CChangePriorityCommand::Clone),

class_< CUpgradeRegimentCommand, CCommand >("CUpgradeRegimentCommand")
	.def( constructor< CSubUnit*, int >() )
	.def("Clone", &CUpgradeRegimentCommand::Clone),

class_< SubUnitList >("SubUnitList")
	.def( constructor<>() )
	.def( "GetSize", &SubUnitList::GetSize )
	.def( "IsEmpty", &SubUnitList::IsEmpty )
	.scope
	[
		def("Append", &AppendSubUnit), // cant get the template magic to work with method :/
		def("RemoveAll", &RemoveSubUnits )
	],

class_< CSetFlagCommand, CCommand >("CSetFlagCommand")
	.def( constructor< CCountryTag, const CString&, bool>() )
	.def("Clone", &CSetFlagCommand::Clone),

class_< CSetVariableCommand, CCommand >("CSetVariableCommand")
	.def( constructor< CCountryTag, const CString&, CFixedPoint>() )
	.def("Clone", &CSetVariableCommand::Clone),

class_< CChangeInvestmentCommand, CCommand >("CChangeInvestmentCommand")
	.def( constructor< CCountryTag, float, float, float, float, float >() ),

class_< CChangeLeadershipCommand, CCommand >("CChangeLeadershipCommand")
	.def( constructor< CCountryTag, float, float, float, float >() ),

class_< CSubUnitConstructionEntry >("CSubUnitConstructionEntry")
	.def( constructor< const CSubUnitDefinition*, int, int >() )
	.def_readonly( "pUnit", &CSubUnitConstructionEntry::_pUnit )
	.def_readonly( "nPrio", &CSubUnitConstructionEntry::_nPrio )
	.def_readonly( "nSequence", &CSubUnitConstructionEntry::_nSequence ),

class_< CBuilding >("CBuilding")
	.def( "GetName", &CBuilding::GetName )
	.def( "GetIndex", &CBuilding::GetIndex ),

class_< CProvinceBuilding >("CProvinceBuilding")
	.def( "GetCurrent", &CProvinceBuilding::GetCurrent )
	.def( "GetMax", &CProvinceBuilding::GetMax ),

class_< CConstructBuildingCommand, CCommand  >("CConstructBuildingCommand")
	.def( constructor< CCountryTag, CBuilding*, int, int >() ),

class_< CBuildingDataBase >("CBuildingDataBase")
	.scope
	[
		def( "GetBuilding", &CBuildingDataBase_GetBuilding ),
		def( "GetBuildingFromIndex", &CBuildingDataBase_GetBuildingFromIndex )
	],

class_< CStrategicWarfare >("CStrategicWarfare")
	.def( "GetBombingImpact", &CStrategicWarfare::GetBombingImpact )
	.def( "GetAlliesImpact", &CStrategicWarfare::GetAlliesImpact )
	.def( "GetConvoyImpact", &CStrategicWarfare::GetConvoyImpact ),

class_< CChangeSpyPriority, CCommand >("CChangeSpyPriority")
	.def( constructor< CCountryTag, CCountryTag, int >() ),

class_< CChangeSpyMission, CCommand >("CChangeSpyMission")
	.def( constructor< CCountryTag, CCountryTag, SpyMission >() ),

class_< SpyMission >("SpyMission")
	.enum_("constants")
	[
		value( "SPYMISSION_NONE", SPYMISSION_NONE ),
		value( "SPYMISSION_COUNTER_ESPIONAGE", SPYMISSION_COUNTER_ESPIONAGE ),
		value( "SPYMISSION_MILITARY", SPYMISSION_MILITARY ),
		value( "SPYMISSION_TECH", SPYMISSION_TECH ),
		value( "SPYMISSION_POLITICAL", SPYMISSION_POLITICAL ),
		value( "SPYMISSION_BOOST_RULING_PARTY", SPYMISSION_BOOST_RULING_PARTY ),
		value( "SPYMISSION_BOOST_OUR_PARTY", SPYMISSION_BOOST_OUR_PARTY ),
		value( "SPYMISSION_LOWER_NATIONAL_UNITY", SPYMISSION_LOWER_NATIONAL_UNITY ),
		value( "SPYMISSION_SUPPORT_RESISTANCE", SPYMISSION_SUPPORT_RESISTANCE ),
		value( "SPYMISSION_DISRUPT_RESEARCH", SPYMISSION_DISRUPT_RESEARCH ),
		value( "SPYMISSION_DISRUPT_PRODUCTION", SPYMISSION_DISRUPT_PRODUCTION ),
		value( "SPYMISSION_INCREASE_THREAT", SPYMISSION_INCREASE_THREAT ),
		value( "SPYMISSION_LOWER_NEUTRALITY", SPYMISSION_LOWER_NEUTRALITY ),
		value( "SPYMISSION_RAISE_NATIONAL_UNITY", SPYMISSION_RAISE_NATIONAL_UNITY ),
		value( "SPYMISSION_MAX", SPYMISSION_MAX )
	],

class_< CSpyPresence >("CSpyPresence")
	.def( "GetLevel", &CSpyPresence::GetLevel )
	.def( "GetPriority", &CSpyPresence::GetPriority )
	.def( "GetMission", &CSpyPresence::GetMission )
	.def( "GetLastMissionChangeDate", &CSpyPresence::GetLastMissionChangeDate )
	.scope
	[
		def( "MissionAllowed", &CSpyPresence::MissionAllowed)
	]
	.enum_("constants")
	[
		value( "MAX_SPY_PRIORITY", MAX_SPY_PRIORITY ),
		value( "MAX_SPY_LEVEL", 10 )
	],

class_< CTechnologyCategory >("CTechnologyCategory")
	.def( "GetKey", &CTechnologyCategory::GetKey )
	.def( "GetIndex", &CTechnologyCategory::GetIndex )
	.def( const_self == const_self ),

class_< CTechnologyStatus >("CTechnologyStatus")
	.def( "CanResearch", &CTechnologyStatus::CanResearch )
	.def( "GetEffectiveYear", &CTechnologyStatus::GetEffectiveYear )
	.def( "GetLevel", &CTechnologyStatus::GetLevel )
	.def( "GetCost", &CTechnologyStatus::GetCost )
	.def( "IsUnitAvailable", &CTechnologyStatus::IsUnitAvailable )
	.def( "IsSubUnitAvailable", &CTechnologyStatus::IsSubUnitAvailable )
	.def( "IsBuildingAvailable", &CTechnologyStatus::IsBuildingAvailable )
	.def( "GetIcModifier", &CTechnologyStatus::GetIcModifier )
	.def( "GetYear", &CTechnologyStatus::GetYear ),

class_< CResearchBonus >("CResearchBonus")
	.def_readonly( "_pCategory", &CResearchBonus::_pCategory )
	.def_readonly( "_vWeight", &CResearchBonus::_vWeight ),

class_< CTechnologyFolder >("CTechnologyFolder")
	.def( "GetKey", &CTechnologyFolder::GetKey )
	.def( "GetIndex", &CTechnologyFolder::GetIndex )
	.def( "IsValid", &CTechnologyFolder::IsValid ),

class_< CTechnology >("CTechnology")
	.def( "GetKey", &CTechnology::GetKey )
	.def( "GetIndex", &CTechnology::GetIndex )
	.def( "IsValid", &CTechnology::IsValid )
	.def( "IsOneLevelOnly", &CTechnology::IsOneLevelOnly )
	.def( "CanUpgrade", &CTechnology::CanUpgrade )
	.def( "GetFolder", &CTechnology::GetFolder )
	.def( "GetDifficulty", &CTechnology::GetDifficulty )
	.def( "GetEnableUnit", &CTechnology::GetEnableUnit )
	.def( "CanResearch", &CTechnology::CanResearch )
	.def( "CanUpgrade", &CTechnology::CanUpgrade )
	.def( "GetResearchBonus", &CTechnology::GetResearchBonus, return_clausewitz_iterator )
	.def( "GetOnCompletion", &CTechnology::GetOnCompletion )
	.def( const_self == const_self ),

class_< CNullTechnology, CTechnology >("CNullTechnology"),

class_< CTechnologyDataBase >("CTechnologyDataBase")
	.scope // adaptored methods so we wont have to fetch instance  all the time
	[
		def( "GetTechnologies", &CTechnologyDataBase_GetTechnologies, return_clausewitz_iterator ),
		def( "GetCategories", &CTechnologyDataBase_GetCategories, return_clausewitz_iterator ),
		def( "GetFolderIndex", &CTechnologyDataBase_GetFolderIndex ),
		def( "GetTechnology", &CTechnologyDataBase_GetTechnology )
	],
class_< CStartResearchCommand, CCommand >("CStartResearchCommand")
	.def( constructor< CCountryTag, const CTechnology* >() ),

class_< CLawDataBase >("CLawDataBase")
	.scope
	[
		def( "GetLawList", CLawDataBase_GetLawList, return_clausewitz_iterator ),
		def( "GetGroups", CLawDataBase_GetGroups, return_clausewitz_iterator ),
		def( "GetNumberOfLaws", CLawDataBase_GetNumberOfLaws ),
		def( "GetNumberOfLawGroups", CLawDataBase_GetNumberOfLawGroups ),
		def( "GetLawGroup", CLawDataBase_GetLawGroup ),
		def( "GetLaw", CLawDataBase_GetLaw )
	],

class_< CChangeLawCommand, CCommand >("CChangeLawCommand")
	.def( constructor< CCountryTag, const CLaw*, const CLawGroup* >() ),

class_< CMinisterType >("CMinisterType")
	.def( "GetKey", &CMinisterType::GetKey )
	.def( "GetIndex", &CMinisterType::GetIndex )
	.def( "GetDecay", &CMinisterType::GetDecay ),

class_< CGovernmentPosition >("CGovernmentPosition")
	.def( "GetKey", &CGovernmentPosition::GetKey )
	.def( "GetIndex", &CGovernmentPosition::GetIndex )
	.def( "IsChangeable", &CGovernmentPosition::IsChangeable ),

class_< CGovernmentPositionDataBase >("CGovernmentPositionDataBase")
	.scope
	[
		def( "GetGovernmentPositionList", &CGovernmentPositionDataBase_GetGovernmentPositionList, return_clausewitz_iterator ),
		def( "GetNumberOfGovernmentPositions", &CGovernmentPositionDataBase_GetNumberOfGovernmentPositions ),
		def( "GetGovernmentPosition", &CGovernmentPositionDataBase_GetGovernmentPosition ),
		def( "GetGovernmentPositionByIndex", &CGovernmentPositionDataBase_GetGovernmentPositionByIndex )
	],

class_< CMinisterTypeDataBase >("CMinisterTypeDataBase")
	.scope 
	[
		def( "GetMinisterTypeList", &CMinisterTypeDataBase_GetMinisterTypeList, return_clausewitz_iterator ),
		def( "GetMinisterType", &CMinisterTypeDataBase_GetMinisterType ),
		def( "GetNumberOfMinisterTypes", &CMinisterTypeDataBase_GetNumberOfMinisterTypes )
	],

class_< CMinister >("CMinister")
	.def( "IsValid", &CMinister::IsValid )
	.def( "GetPersonality", &CMinister::GetPersonality )
	.def( "CanTakePosition", &CMinister::CanTakePosition )
	.def( "GetIdeology", &CMinister::GetIdeology )
	.def( self == self ),

class_< CChangeMinisterCommand, CCommand >("CChangeMinisterCommand")
	.def( constructor< CCountryTag, CMinister*, const CGovernmentPosition*>() ),

class_< CLiberateCountryCommand, CCommand>("CLiberateCountryCommand")
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CCreateVassalCommand, CCommand>("CCreateVassalCommand")
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CToggleMobilizationCommand, CCommand>("CToggleMobilizationCommand")
	.def( constructor< CCountryTag, bool >() ),

class_< CConstructConvoyCommand, CCommand >("CConstructConvoyCommand")
	.def( constructor< CCountryTag, bool, int >() ),

class_< CConvoy >("CConvoy")
	.def( "GetDesiredTransports", &CConvoy::GetDesiredTransports )
	.def( "GetDesiredEscorts", &CConvoy::GetDesiredEscorts )
	.def( "GetEfficiency", &CConvoy::GetEfficiency )
	.def( "IsForTradeRoute", &CConvoy::IsForTradeRoute ),

class_< CPeaceAction, CDiplomaticAction >("CPeaceAction")
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CSendExpeditionaryForceAction, CDiplomaticAction>("CSendExpeditionaryForceAction")
	.enum_("ClaimType")
	[
		value( "TAKE", CSendExpeditionaryForceAction::TAKE ),
		value( "SEND", CSendExpeditionaryForceAction::SEND )
	]
	.def( constructor< CCountryTag, CCountryTag >() )
	.def( "GetTag", &CSendExpeditionaryForceAction::GetTag )
	.def( "GetUnit", &CSendExpeditionaryForceAction::GetUnit )
	.def( "GetClaimType", &CSendExpeditionaryForceAction::GetClaimType ),

class_< CLicenceTechnologyAction, CDiplomaticAction >("CLicenceTechnologyAction")
	.def( constructor< CCountryTag, CCountryTag >() )
	.def( "GetSubunit", &CLicenceTechnologyAction::GetSubunit )
	.def( "GetSerial", &CLicenceTechnologyAction::GetSerial )
	.def( "GetParalell", &CLicenceTechnologyAction::GetParalell )
	.def( "GetMoney", &CLicenceTechnologyAction::GetMoney ),

class_< CDebtAction, CDiplomaticAction >("CDebtAction")
	.def( constructor< CCountryTag, CCountryTag >() ),

class_< CTheatre >("CTheatre")
	.def( "GetPriority", &CTheatre::GetPriority )
```