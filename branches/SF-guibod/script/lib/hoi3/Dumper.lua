require('hoi3.api')

module( "hoi3", package.seeall)

function dump()
	-- Clean the environment
	hoi3.api.MultitonObject.clearInstances()
	
	-- Start by referencing all databased objects
	for d in CBuildingDataBase.GetBuilding() do
		local o = hoi3.api.CBuilding(d:GetName())
	end
end


--[[
Loaded testsuite with 37 tests in 10 testcases.

[] [DEBUG] [] Debug message at init.lua:108(function 'mypcall')
[] [INFO] [] Info message at init.lua:108(function 'mypcall')
[] [WARN] [] Warn message at init.lua:108(function 'mypcall')
[] [ERROR] [] Error message at init.lua:108(function 'mypcall')
[] [FATAL] [] Fatal message at init.lua:108(function 'mypcall')
    .[] [INFO] [] 10000 insertion without transaction : 0 at init.lua:108(function 'mypcall')
[] [INFO] [] 10000 insertion with transaction : 1 at init.lua:108(function 'mypcall')
....................Hello
World
Hello
World
Hello
World
.....F..F.......

133 Assertions checked.

  1) Failure (hoi3.tests.save.testSavedStaticWithoutParam):
...e\workspace\SF-guibod\script\lib\hoi3\tests\save.lua:107: expected 'duvimico_u' but was 'mehodafafa'

  2) Failure (hoi3.tests.save.testRandomStaticWithoutParam):
...e\workspace\SF-guibod\script\lib\hoi3\tests\save.lua:88: expected 'jazisulesi' but was 'cexecasope'

Testsuite finished (35 passed, 2 failed, 0 errors).
[1946-10-17] [INFO] [] Function ForeignMinister_OnWar wrapped to DtoolsWrappedForeignMinister_OnWar at ai_foreign_minister.lua:522(main chunk)
[1944-13-3] [INFO] [] Function ForeignMinister_EvaluateDecision wrapped to DtoolsWrappedForeignMinister_EvaluateDecision at ai_foreign_minister.lua:523(main chunk)
[1942-8-5] [INFO] [] Function ForeignMinister_Tick wrapped to DtoolsWrappedForeignMinister_Tick at ai_foreign_minister.lua:524(main chunk)
[1939-5-22] [INFO] [] Function IntelligenceMinister_Tick wrapped to DtoolsWrappedIntelligenceMinister_Tick at ai_intelligence_minister.lua:259(main chunk)
[1948-9-6] [INFO] [] Function PoliticsMinister_Tick wrapped to DtoolsWrappedPoliticsMinister_Tick at ai_politics_minister.lua:551(main chunk)
[1947-5-12] [INFO] [] Function ProductionMinister_Tick wrapped to DtoolsWrappedProductionMinister_Tick at ai_production_minister.lua:1882(main chunk)
[1943-11-31] [INFO] [] Function BalanceProductionSliders wrapped to DtoolsWrappedBalanceProductionSliders at ai_production_minister.lua:1883(main chunk)
[1945-4-10] [INFO] [] Function TechMinister_Tick wrapped to DtoolsWrappedTechMinister_Tick at ai_tech_minister.lua:915(main chunk)
[1944-6-3] [INFO] [] Function DiploScore_OfferTrade wrapped to DtoolsWrappedDiploScore_OfferTrade at ai_trade.lua:911(main chunk)
[1936-6-18] [INFO] [] Function ForeignMinister_ManageTrade wrapped to DtoolsWrappedForeignMinister_ManageTrade at ai_trade.lua:912(main chunk)
HOI3 lua API
-----------------------
CAI
hoi3.api.CAI.GetReqProdQueueIter()
hoi3.api.CAI.HasTradeGoneStale()
hoi3.api.CAI.PostAction()
hoi3.api.CAI.HasFilledProdQueue()
hoi3.api.CAI.EvaluateCancelTrades()
hoi3.api.CAI.RequestSubUnit()
hoi3.api.CAI.MoveUnit()
hoi3.api.CAI.IsInfluencing()
hoi3.api.CAI.AlreadyTradingDisabledResource()
hoi3.api.CAI.IsAIControlledForPlayer()
hoi3.api.CAI.GetNormalizedAlignmentDistance()
hoi3.api.CAI.CanTradeFreeResources()
hoi3.api.CAI.GetReqProdQueue()
hoi3.api.CAI.GetCountry()
hoi3.api.CAI.GetAmountTradedFrom()
hoi3.api.CAI.GetDeployedSubUnitCounts()
hoi3.api.CAI.GetProductionSubUnitCounts()
hoi3.api.CAI.PrintConsole()
hoi3.api.CAI.GetNumberOfOwnedProvinces()
hoi3.api.CAI.GetRelation()
hoi3.api.CAI.IsTradeingAwayNeededResource()
hoi3.api.CAI.MoveToNeighbor()
hoi3.api.CAI.Post()
hoi3.api.CAI.GetCurrentDate()
hoi3.api.CAI.GetModDirectory()
hoi3.api.CAI.HasCommonExtension()
hoi3.api.CAI.GetSpamPenalty()
hoi3.api.CAI.HasUserExtension()
hoi3.api.CAI.GetTheatreSubUnitNeedCounts()
hoi3.api.CAI.CanDeclareWar()
hoi3.api.CAI.AlreadyTradingResourceOtherWay()
hoi3.api.CAI.GetCountryAlignmentDistance()

-----------------------
CAIAgent
hoi3.api.CAIAgent.GetOwnerAI()
hoi3.api.CAIAgent.GetCountryTag()
hoi3.api.CAIAgent.GetCountry()

-----------------------
CAIEspionageMinister
hoi3.api.CAIEspionageMinister.IsAligningToFaction()

-----------------------
CAIForeignMinister
hoi3.api.CAIForeignMinister.ExecuteDiploDecisions()
hoi3.api.CAIForeignMinister.ClearWarProposal()
hoi3.api.CAIForeignMinister.GetProposedWarTarget()
hoi3.api.CAIForeignMinister.PercOccupied()
hoi3.api.CAIForeignMinister.ProposeWar()
hoi3.api.CAIForeignMinister.Propose()

-----------------------
CAIIntel
hoi3.api.CAIIntel.GetFactor()
hoi3.api.CAIIntel.CalculateOurMilitaryStrength()
hoi3.api.CAIIntel.CalculateTheirPercievedMilitaryStrengh()
hoi3.api.CAIIntel.GetUncertaintyFactor()
hoi3.api.CAIIntel.GetTheirFactor()
hoi3.api.CAIIntel.HasNoIntel()

-----------------------
CAIPoliticsMinister
hoi3.api.CAIPoliticsMinister.GetPossibleMinisters()
hoi3.api.CAIPoliticsMinister.IsCapitalSafeToLiberate()

-----------------------
CAIProductionMinister
hoi3.api.CAIProductionMinister.CountEscortsUnderConstruction()
hoi3.api.CAIProductionMinister.CountTotalDesiredEscorts()
hoi3.api.CAIProductionMinister.CountTransportsUnderConstruction()
hoi3.api.CAIProductionMinister.PrioritizeBuildQueue()
hoi3.api.CAIProductionMinister.GetDesperation()

-----------------------
CAIStrategy
hoi3.api.CAIStrategy.IsPreparingWarWith()
hoi3.api.CAIStrategy.PrepareWarDecision()
hoi3.api.CAIStrategy.PrepareWar()
hoi3.api.CAIStrategy.IsPreparingWar()
hoi3.api.CAIStrategy.GetWarScoreWith()
hoi3.api.CAIStrategy.GetCountryTag()
hoi3.api.CAIStrategy.IsIndustrialist()
hoi3.api.CAIStrategy.IsDiplomat()
hoi3.api.CAIStrategy.GetPersonality()
hoi3.api.CAIStrategy.GetWarTargets()
hoi3.api.CAIStrategy.GetTheatres()
hoi3.api.CAIStrategy.GetWarTarget()
hoi3.api.CAIStrategy.IsMilitarist()
hoi3.api.CAIStrategy.GetAccessScore()
hoi3.api.CAIStrategy.GetThreat()
hoi3.api.CAIStrategy.GetProtectionism()
hoi3.api.CAIStrategy.IsBalanced()
hoi3.api.CAIStrategy.GetFriendliness()
hoi3.api.CAIStrategy.GetAntagonism()
hoi3.api.CAIStrategy.AddSubUnit()
hoi3.api.CAIStrategy.GetWantedSubUnits()
hoi3.api.CAIStrategy.CancelPrepareWar()
hoi3.api.CAIStrategy.GetCountry()

-----------------------
CAISubscriber
hoi3.api.CAISubscriber.WantTicks()

-----------------------
CAITechMinister
hoi3.api.CAITechMinister.GetLastDrift()
hoi3.api.CAITechMinister.CanResearch()
hoi3.api.CAITechMinister.GetFolderModifers()
hoi3.api.CAITechMinister.GetTechModifers()
hoi3.api.CAITechMinister.GetDistanceFrom()

-----------------------
CAction
hoi3.api.CAction.Create()

-----------------------
CAlignment

-----------------------
CAllianceAction

-----------------------
CArrayFix
hoi3.api.CArrayFix.SetAt()
hoi3.api.CArrayFix.GetAt()

-----------------------
CArrayFloat
hoi3.api.CArrayFloat.SetAt()
hoi3.api.CArrayFloat.GetAt()

-----------------------
CBrigade
hoi3.api.CBrigade.GetType()

-----------------------
CBuildingDataBase
hoi3.api.CBuildingDataBase.GetBuildingFromIndex()
hoi3.api.CBuildingDataBase.GetBuilding()

-----------------------
CCallAllyAction
hoi3.api.CCallAllyAction.SetVersus()
hoi3.api.CCallAllyAction.GetVersus()

-----------------------
CCancelUnitConstructionCommand

-----------------------
CChangeInvestmentCommand

-----------------------
CChangeLawCommand

-----------------------
CChangeLeadershipCommand

-----------------------
CChangePriorityCommand

-----------------------
CChangeSpyMission

-----------------------
CChangeSpyPriority

-----------------------
CCommand
hoi3.api.CCommand.IsValid()
hoi3.api.CCommand.Clone()

-----------------------
CConstructBuildingCommand

-----------------------
CConstructConvoyCommand
CConstructConvoyCommand(
CCountryTag, 
boolean, 
number, 
)

-----------------------
CConstructSingleUnitCommand

-----------------------
CConstructUnitCommand

-----------------------
CConstruction
hoi3.api.CConstruction.IsMilitary()
hoi3.api.CConstruction.GetMilitary()
hoi3.api.CConstruction.GetCost()

-----------------------
CContinent
hoi3.api.CContinent.GetName()
hoi3.api.CContinent.GetTag()

-----------------------
CConvoy
hoi3.api.CConvoy.GetDesiredTransports()
hoi3.api.CConvoy.GetEfficiency()
hoi3.api.CConvoy.GetDesiredEscorts()
hoi3.api.CConvoy.IsForTradeRoute()

-----------------------
CCountry
hoi3.api.CCountry.GetNumOfAllies()
hoi3.api.CCountry.GetVassals()
hoi3.api.CCountry.GetVariables()
hoi3.api.CCountry.GetUnitsIterator()
hoi3.api.CCountry.AccessIdeologyPopularity()
hoi3.api.CCountry.GetConvoyedIn()
hoi3.api.CCountry.GetAirBases()
hoi3.api.CCountry.GetNumOfAirfields()
hoi3.api.CCountry.IsFriend()
hoi3.api.CCountry.GetTradedFor()
hoi3.api.CCountry.GetAlignmentCord()
hoi3.api.CCountry.GetNumberOfOwnedProvinces()
hoi3.api.CCountry.GetTradedForSansAlliedSupply()
hoi3.api.CCountry.GetCurrentAtWarWith()
hoi3.api.CCountry.GetNationalUnity()
hoi3.api.CCountry.HasNeighborInFaction()
hoi3.api.CCountry.IsAtWar()
hoi3.api.CCountry.GetDiplomaticDistance()
hoi3.api.CCountry.GetAbility()
hoi3.api.CCountry.Exists()
hoi3.api.CCountry.GetNumOfPorts()
hoi3.api.CCountry.GetOfficerRatio()
hoi3.api.CCountry.GetAlignment()
hoi3.api.CCountry.GetEscorts()
hoi3.api.CCountry.GetRulingIdeology()
hoi3.api.CCountry.GetConvoyBuildCost()
hoi3.api.CCountry.GetDailyBalance()
hoi3.api.CCountry.GetCapital()
hoi3.api.CCountry.GetAvailableIC()
hoi3.api.CCountry.GetHighestThreat()
hoi3.api.CCountry.GetDiplomaticInfluence()
hoi3.api.CCountry.GetBuildTime()
hoi3.api.CCountry.isPuppet()
hoi3.api.CCountry.GetActingCapitalLocation()
hoi3.api.CCountry.GetConvoyedOut()
hoi3.api.CCountry.GetSpyPresence()
hoi3.api.CCountry.AIGetTradeRoutes()
hoi3.api.CCountry.GetStrategy()
hoi3.api.CCountry.GetOwnedProvinces()
hoi3.api.CCountry.GetTradedAwaySansAlliedSupply()
hoi3.api.CCountry.GetNavalBases()
hoi3.api.CCountry.GetOverlord()
hoi3.api.CCountry.HasFaction()
hoi3.api.CCountry.GetTechnologyStatus()
hoi3.api.CCountry.GetAllies()
hoi3.api.CCountry.GetSupplyBalanceAverage()
hoi3.api.CCountry.GetTradedAway()
hoi3.api.CCountry.GetPool()
hoi3.api.CCountry.GetNeighbours()
hoi3.api.CCountry.GetStrategicWarfare()
hoi3.api.CCountry.GetGovernment()
hoi3.api.CCountry.GetManpower()
hoi3.api.CCountry.GetNeutrality()
hoi3.api.CCountry.IsMajor()
hoi3.api.CCountry.GetRules()
hoi3.api.CCountry.GetMoneyBalanceAverage()
hoi3.api.CCountry.IsFactionLeader()
hoi3.api.CCountry.IsGovernmentInExile()
hoi3.api.CCountry.GetTotalProduced()
hoi3.api.CCountry.HasConstruction()
hoi3.api.CCountry.GetCountryTag()
hoi3.api.CCountry.GetRelation()
hoi3.api.CCountry.GetICPart()
hoi3.api.CCountry.GetEscortBuildTime()
hoi3.api.CCountry.GetPossiblePuppets()
hoi3.api.CCountry.GetTotalNeededTransports()
hoi3.api.CCountry.GetBuildCost()
hoi3.api.CCountry.MayLiberateCountries()
hoi3.api.CCountry.GetLawFromIndex()
hoi3.api.CCountry.NeedConvoyToTradeWith()
hoi3.api.CCountry.GetEffectiveNeutrality()
hoi3.api.CCountry.IsSubject()
hoi3.api.CCountry.IsNeighbourToFactionHostile()
hoi3.api.CCountry.GetNumberOfCurrentResearch()
hoi3.api.CCountry.GetBuildCostMP()
hoi3.api.CCountry.IsNeighbour()
hoi3.api.CCountry.AccessIdeologyOrganization()
hoi3.api.CCountry.GetControlledProvinces()
hoi3.api.CCountry.GetDiplomacy()
hoi3.api.CCountry.IsMobilized()
hoi3.api.CCountry.GetFaction()
hoi3.api.CCountry.GetDailyIncome()
hoi3.api.CCountry.GetUsedIC()
hoi3.api.CCountry.GetDissent()
hoi3.api.CCountry.IsBuildingAllowed()
hoi3.api.CCountry.GetTotalConvoyTransports()
hoi3.api.CCountry.GetCapitalLocation()
hoi3.api.CCountry.HasExtraManpowerLeft()
hoi3.api.CCountry.HasDiplomatEnroute()
hoi3.api.CCountry.IsEnemy()
hoi3.api.CCountry.CanCreatePuppet()
hoi3.api.CCountry.GetTotalNeededConvoyTransports()
hoi3.api.CCountry.GetNumberOfControlledProvinces()
hoi3.api.CCountry.GetSurrenderLevel()
hoi3.api.CCountry.CalculateNumberOfActiveInfluences()
hoi3.api.CCountry.CalcDesperation()
hoi3.api.CCountry.GetVariable()
hoi3.api.CCountry.GetLaw()
hoi3.api.CCountry.GetCoreProvinces()
hoi3.api.CCountry.GetCurrentResearch()
hoi3.api.CCountry.GetGlobalModifier()
hoi3.api.CCountry.GetMaxIC()
hoi3.api.CCountry.GetEscortBuildCost()
hoi3.api.CCountry.GetConvoyBuildTime()
hoi3.api.CCountry.GetTotalLeadership()
hoi3.api.CCountry.GetTransports()
hoi3.api.CCountry.GetTotalIC()
hoi3.api.CCountry.GetTotalCoreBuildingLevels()
hoi3.api.CCountry.GetHomeProduced()
hoi3.api.CCountry.GetMaxNeutralityForWarWith()
hoi3.api.CCountry.GetBuildCostIC()
hoi3.api.CCountry.GetUnits()
hoi3.api.CCountry.GetSpyingOnUs()
hoi3.api.CCountry.GetAllowedResearchSlots()
hoi3.api.CCountry.CalculateIsAllied()
hoi3.api.CCountry.GetPossibleMinisters()
hoi3.api.CCountry.GetConstructions()
hoi3.api.CCountry.CalculateReinforcementMultiplier()
hoi3.api.CCountry.GetDailyExpense()
hoi3.api.CCountry.GetProductionDistributionAt()
hoi3.api.CCountry.GetPossibleLiberations()
hoi3.api.CCountry.GetMinister()
hoi3.api.CCountry.GetLeadershipDistributionAt()
hoi3.api.CCountry.GetConvoys()

-----------------------
CCountryDataBase
hoi3.api.CCountryDataBase.GetTag()

-----------------------
CCountryList
hoi3.api.CCountryList.IsEnemy()

-----------------------
CCountryTag
hoi3.api.CCountryTag.IsValid()
hoi3.api.CCountryTag.GetIndex()
hoi3.api.CCountryTag.IsReal()
hoi3.api.CCountryTag.GetTag()
hoi3.api.CCountryTag.GetCountry()

-----------------------
CCountryTagList
hoi3.api.CCountryTagList.IsEnemy()

-----------------------
CCurrentGameState
hoi3.api.CCurrentGameState.GetFactions()
hoi3.api.CCurrentGameState.GetCurrentDate()
hoi3.api.CCurrentGameState.GetCountries()
hoi3.api.CCurrentGameState.GetProvince()
hoi3.api.CCurrentGameState.IsGlobalFlagSet()
hoi3.api.CCurrentGameState.GetPlayer()
hoi3.api.CCurrentGameState.GetFaction()
hoi3.api.CCurrentGameState.GetInstance()
hoi3.api.CCurrentGameState.GetAIRand()

-----------------------
CDate
hoi3.api.CDate.GetYear()
hoi3.api.CDate.GetMonthOfYear()
hoi3.api.CDate.GetDayOfMonth()
hoi3.api.CDate.AddDays()
hoi3.api.CDate.GetTotalDays()

-----------------------
CDebtAction

-----------------------
CDecision
hoi3.api.CDecision.IsPotential()
hoi3.api.CDecision.GetKey()

-----------------------
CDeclareWarAction

-----------------------
CDiplomacyStatus
hoi3.api.CDiplomacyStatus.HasHostileAgreement()
hoi3.api.CDiplomacyStatus.HasEmbargo()
hoi3.api.CDiplomacyStatus.HasNap()
hoi3.api.CDiplomacyStatus.HasAnyAgreement()
hoi3.api.CDiplomacyStatus.GetWar()
hoi3.api.CDiplomacyStatus.IsGuaranteed()
hoi3.api.CDiplomacyStatus.GetTradeRoutes()
hoi3.api.CDiplomacyStatus.IsBeingInfluenced()
hoi3.api.CDiplomacyStatus.GetValue()
hoi3.api.CDiplomacyStatus.AllowDebts()
hoi3.api.CDiplomacyStatus.IsGuaranting()
hoi3.api.CDiplomacyStatus.HasFriendlyAgreement()
hoi3.api.CDiplomacyStatus.HasTruce()
hoi3.api.CDiplomacyStatus.IsFightingWarTogether()
hoi3.api.CDiplomacyStatus.HasWar()
hoi3.api.CDiplomacyStatus.HasMilitaryAccess()
hoi3.api.CDiplomacyStatus.GetThreat()
hoi3.api.CDiplomacyStatus.HasAlliance()
hoi3.api.CDiplomacyStatus.SetValue()

-----------------------
CDiplomaticAction
hoi3.api.CDiplomaticAction.IsValid()
hoi3.api.CDiplomaticAction.GetAIAcceptance()
hoi3.api.CDiplomaticAction.GetValue()
hoi3.api.CDiplomaticAction.IsSelectable()
hoi3.api.CDiplomaticAction.GetType()
hoi3.api.CDiplomaticAction.SetValue()

-----------------------
CDistributionSetting
hoi3.api.CDistributionSetting.GetNeeded()
hoi3.api.CDistributionSetting.GetPercentage()

-----------------------
CEmbargoAction

-----------------------
CFaction
hoi3.api.CFaction.GetMembers()
hoi3.api.CFaction.GetProgress()
hoi3.api.CFaction.GetNormalizedProgress()
hoi3.api.CFaction.GetFactionLeader()
hoi3.api.CFaction.GetTag()
hoi3.api.CFaction.GetIdeologyGroup()
hoi3.api.CFaction.GetNumberOfMembers()
hoi3.api.CFaction.IsValid()

-----------------------
CFactionAction

-----------------------
CFixedPoint
hoi3.api.CFixedPoint.GetTruncated()
hoi3.api.CFixedPoint.GetRounded()
hoi3.api.CFixedPoint.Get()

-----------------------
CFlags
hoi3.api.CFlags.IsFlagSet()

-----------------------
CGoodsPool
hoi3.api.CGoodsPool.GetFloat()
hoi3.api.CGoodsPool.Get()

-----------------------
CGovernment
hoi3.api.CGovernment.IsValid()

-----------------------
CGovernmentPosition

-----------------------
CGovernmentPositionDataBase
hoi3.api.CGovernmentPositionDataBase.GetGovernmentPositionByIndex()

-----------------------
CGuaranteeAction

-----------------------
CID

-----------------------
CIdeology
hoi3.api.CIdeology.GetGroup()

-----------------------
CIdeologyData
hoi3.api.CIdeologyData.CalculateTotalSum()
hoi3.api.CIdeologyData.GetValue()

-----------------------
CIdeologyGroup
hoi3.api.CIdeologyGroup.GetFaction()
hoi3.api.CIdeologyGroup.GetPosition()

-----------------------
CInfluenceAllianceLeader

-----------------------
CInfluenceNation

-----------------------
CLaw
hoi3.api.CLaw.IsValid()
hoi3.api.CLaw.GetKey()
hoi3.api.CLaw.GetIndex()
hoi3.api.CLaw.GetGroup()
hoi3.api.CLaw.ValidFor()

-----------------------
CLawDataBase
hoi3.api.CLawDataBase.GetNumberOfLawGroups()
hoi3.api.CLawDataBase.GetLawGroup()
hoi3.api.CLawDataBase.GetLaw()
hoi3.api.CLawDataBase.GetGroups()
hoi3.api.CLawDataBase.GetNumberOfLaws()
hoi3.api.CLawDataBase.GetLawList()

-----------------------
CLawGroup
hoi3.api.CLawGroup.IsValid()
hoi3.api.CLawGroup.GetKey()
hoi3.api.CLawGroup.GetIndex()

-----------------------
CLiberateCountryCommand

-----------------------
CLicenceTechnologyAction
hoi3.api.CLicenceTechnologyAction.GetParalell()
hoi3.api.CLicenceTechnologyAction.GetSubunit()
hoi3.api.CLicenceTechnologyAction.GetSerial()
hoi3.api.CLicenceTechnologyAction.GetMoney()

-----------------------
CList

-----------------------
CMilitaryAccessAction

-----------------------
CMilitaryConstruction
hoi3.api.CMilitaryConstruction.GetBrigades()
hoi3.api.CMilitaryConstruction.IsAir()
hoi3.api.CMilitaryConstruction.IsNaval()
hoi3.api.CMilitaryConstruction.IsLand()

-----------------------
CMinister
hoi3.api.CMinister.CanTakePosition()
hoi3.api.CMinister.GetValue()
hoi3.api.CMinister.GetIdeology()
hoi3.api.CMinister.GetPersonality()

-----------------------
CModifier

-----------------------
CNapAction

-----------------------
CNullFaction
hoi3.api.CNullFaction.GetMembers()
hoi3.api.CNullFaction.GetProgress()
hoi3.api.CNullFaction.GetFactionLeader()
hoi3.api.CNullFaction.GetTag()
hoi3.api.CNullFaction.IsValid()
hoi3.api.CNullFaction.GetIdeologyGroup()
hoi3.api.CNullFaction.GetNumberOfMembers()
hoi3.api.CNullFaction.GetNormalizedProgress()

-----------------------
CNullTag

-----------------------
CNullTechnology

-----------------------
COfferMilitaryAccessAction

-----------------------
CPeaceAction

-----------------------
CPersonality
hoi3.api.CPersonality.GetKey()
hoi3.api.CPersonality.GetIndex()

-----------------------
CProvince
hoi3.api.CProvince.GetOwner()
hoi3.api.CProvince.GetContinent()
hoi3.api.CProvince.HasBuilding()
hoi3.api.CProvince.GetUnits()
hoi3.api.CProvince.GetNumberOfUnits()
hoi3.api.CProvince.IsFrontProvince()
hoi3.api.CProvince.GetBuilding()
hoi3.api.CProvince.GetMaxInfrastructure()
hoi3.api.CProvince.GetController()
hoi3.api.CProvince.GetProvinceID()
hoi3.api.CProvince.HasAdjacentEnemyOrCB()
hoi3.api.CProvince.GetIntelLevel()
hoi3.api.CProvince.GetInfrastructure()
hoi3.api.CProvince.GetCoastalFortLevel()
hoi3.api.CProvince.GetFortLevel()
hoi3.api.CProvince.GetCurrentConstructionLevel()

-----------------------
CProvinceBuilding
hoi3.api.CProvinceBuilding.GetMax()
hoi3.api.CProvinceBuilding.GetCurrent()

-----------------------
CResearchBonus

-----------------------
CResourceValues
hoi3.api.CResourceValues.GetResourceValues()

-----------------------
CRule

-----------------------
CSendExpeditionaryForceAction
hoi3.api.CSendExpeditionaryForceAction.GetTag()
hoi3.api.CSendExpeditionaryForceAction.GetClaimType()
hoi3.api.CSendExpeditionaryForceAction.GetUnit()

-----------------------
CSetFlagCommand

-----------------------
CSetVariableCommand

-----------------------
CSimpleRandom
hoi3.api.CSimpleRandom.GetNumber()
hoi3.api.CSimpleRandom.GetFixedPoint()
hoi3.api.CSimpleRandom.Seed()
hoi3.api.CSimpleRandom.GetInteger()

-----------------------
CSpyPresence
hoi3.api.CSpyPresence.GetPriority()
hoi3.api.CSpyPresence.MissionAllowed()
hoi3.api.CSpyPresence.GetLevel()
hoi3.api.CSpyPresence.GetMission()
hoi3.api.CSpyPresence.GetLastMissionChangeDate()

-----------------------
CStartResearchCommand

-----------------------
CStrategicWarfare
hoi3.api.CStrategicWarfare.GetConvoyImpact()
hoi3.api.CStrategicWarfare.GetAlliesImpact()
hoi3.api.CStrategicWarfare.GetBombingImpact()

-----------------------
CString
hoi3.api.CString.GetCharPtr()
hoi3.api.CString.GetString()

-----------------------
CSubUnitConstructionEntry

-----------------------
CSubUnitConstructionEntryList
hoi3.api.CSubUnitConstructionEntryList.GetSize()
hoi3.api.CSubUnitConstructionEntryList.IsEmpty()
hoi3.api.CSubUnitConstructionEntryList.GetHeadData()
hoi3.api.CSubUnitConstructionEntryList.RemoveHead()
hoi3.api.CSubUnitConstructionEntryList.RemoveTail()
hoi3.api.CSubUnitConstructionEntryList.Remove()
hoi3.api.CSubUnitConstructionEntryList.GetTailData()

-----------------------
CSubUnitDataBase
hoi3.api.CSubUnitDataBase.GetSubUnitList()

-----------------------
CSubUnitDefinition
hoi3.api.CSubUnitDefinition.IsRegiment()
hoi3.api.CSubUnitDefinition.CanParadrop()
hoi3.api.CSubUnitDefinition.GetDefensivness()
hoi3.api.CSubUnitDefinition.GetKey()
hoi3.api.CSubUnitDefinition.GetIndex()
hoi3.api.CSubUnitDefinition.IsCarrier()
hoi3.api.CSubUnitDefinition.IsTransport()
hoi3.api.CSubUnitDefinition.GetBuildCostMP()
hoi3.api.CSubUnitDefinition.IsShip()
hoi3.api.CSubUnitDefinition.IsSecondRank()
hoi3.api.CSubUnitDefinition.GetCombatWidth()
hoi3.api.CSubUnitDefinition.IsBuildable()
hoi3.api.CSubUnitDefinition.IsValid()
hoi3.api.CSubUnitDefinition.GetDefaultStrength()
hoi3.api.CSubUnitDefinition.IsCapitalShip()
hoi3.api.CSubUnitDefinition.IsCag()
hoi3.api.CSubUnitDefinition.GetToughness()
hoi3.api.CSubUnitDefinition.GetName()
hoi3.api.CSubUnitDefinition.IsBomber()
hoi3.api.CSubUnitDefinition.GetCompletionSize()
hoi3.api.CSubUnitDefinition.GetBuildTime()
hoi3.api.CSubUnitDefinition.GetSoftness()
hoi3.api.CSubUnitDefinition.GetBuildCostIC()
hoi3.api.CSubUnitDefinition.IsSub()

-----------------------
CTechnology
hoi3.api.CTechnology.IsValid()
hoi3.api.CTechnology.GetOnCompletion()
hoi3.api.CTechnology.IsOneLevelOnly()
hoi3.api.CTechnology.GetResearchBonus()
hoi3.api.CTechnology.GetFolder()
hoi3.api.CTechnology.CanUpgrade()
hoi3.api.CTechnology.GetIndex()
hoi3.api.CTechnology.GetKey()
hoi3.api.CTechnology.GetDifficulty()
hoi3.api.CTechnology.CanResearch()
hoi3.api.CTechnology.GetEnableUnit()

-----------------------
CTechnologyCategory
hoi3.api.CTechnologyCategory.GetKey()
hoi3.api.CTechnologyCategory.GetIndex()

-----------------------
CTechnologyDataBase
hoi3.api.CTechnologyDataBase.GetFolderIndex()
hoi3.api.CTechnologyDataBase.GetTechnology()
hoi3.api.CTechnologyDataBase.GetCategories()

-----------------------
CTechnologyFolder
hoi3.api.CTechnologyFolder.IsValid()
hoi3.api.CTechnologyFolder.GetKey()
hoi3.api.CTechnologyFolder.GetIndex()

-----------------------
CTechnologyStatus
hoi3.api.CTechnologyStatus.GetYear()
hoi3.api.CTechnologyStatus.GetLevel()
hoi3.api.CTechnologyStatus.IsBuildingAvailable()
hoi3.api.CTechnologyStatus.IsUnitAvailable()
hoi3.api.CTechnologyStatus.GetEffectiveYear()
hoi3.api.CTechnologyStatus.CanResearch()
hoi3.api.CTechnologyStatus.GetCost()

-----------------------
CTheatre
hoi3.api.CTheatre.GetPriority()

-----------------------
CToggleMobilizationCommand

-----------------------
CTradeAction
hoi3.api.CTradeAction.GetTrading()
hoi3.api.CTradeAction.SetTrading()
hoi3.api.CTradeAction.GetRoute()
hoi3.api.CTradeAction.SetRoute()
hoi3.api.CTradeAction.IsConvoyPossible()

-----------------------
CTradeRoute
hoi3.api.CTradeRoute.IsValid()
hoi3.api.CTradeRoute.GetLastInactive()
hoi3.api.CTradeRoute.GetTo()
hoi3.api.CTradeRoute.GetTradedToOf()
hoi3.api.CTradeRoute.GetTradedFromOf()
hoi3.api.CTradeRoute.GetFrom()
hoi3.api.CTradeRoute.GetConvoyResponsible()
hoi3.api.CTradeRoute.IsInactive()
hoi3.api.CTradeRoute.GetCost()

-----------------------
CUnit
hoi3.api.CUnit.GetChildren()
hoi3.api.CUnit.IsMoving()
hoi3.api.CUnit.GetName()

-----------------------
CUnitList
hoi3.api.CUnitList.GetCount()
hoi3.api.CUnitList.GetTotalStrength()
hoi3.api.CUnitList.GetTotalNumOfTransports()
hoi3.api.CUnitList.GetTotalNumOfPlanes()
hoi3.api.CUnitList.GetTotalNumOfShips()
hoi3.api.CUnitList.GetTotalAmountOfArmies()
hoi3.api.CUnitList.GetTotalNumOfRegiments()
hoi3.api.CUnitList.GetTotalAmountOfDivisions()
hoi3.api.CUnitList.GetTotalNumOfWarShips()

-----------------------
CWar
hoi3.api.CWar.GetAttackers()
hoi3.api.CWar.GetDefenders()
hoi3.api.CWar.GetStartDate()
hoi3.api.CWar.IsLimited()
hoi3.api.CWar.IsPartOfWar()
hoi3.api.CWar.GetCurrentRunningTimeInMonths()

-----------------------
SpyMission

-----------------------
SubUnitList

]]