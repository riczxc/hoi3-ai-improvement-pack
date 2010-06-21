--[[
	HOI3 fake API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a fake game instance.

	All values returned fully random atm. 
]]


-- Now declare all HOI3 API objects
require('hoi3.api.CAction')
require('hoi3.api.CAI')
require('hoi3.api.CAIAgent')
require('hoi3.api.CAIEspionageMinister')
require('hoi3.api.CAIForeignMinister')
require('hoi3.api.CAIIntel')
require('hoi3.api.CAIPoliticsMinister')
require('hoi3.api.CAIProductionMinister')
require('hoi3.api.CAIStrategy')
require('hoi3.api.CAISubscriber')
require('hoi3.api.CAITechMinister')
require('hoi3.api.CAlignment')
require('hoi3.api.CAllianceAction')
require('hoi3.api.CArrayFix')
require('hoi3.api.CArrayFloat')
require('hoi3.api.CBuilding')
require('hoi3.api.CBuildingDataBase')
require('hoi3.api.CCallAllyAction')
require('hoi3.api.CCancelUnitConstructionCommand')
require('hoi3.api.CChangeInvestmentCommand')
require('hoi3.api.CChangeLawCommand')
require('hoi3.api.CChangeLeadershipCommand')
require('hoi3.api.CChangePriorityCommand')
require('hoi3.api.CChangeSpyMission')
require('hoi3.api.CCommand')
require('hoi3.api.CConstructBuildingCommand')
require('hoi3.api.CConstructConvoyCommand')
require('hoi3.api.CConstruction')
require('hoi3.api.CConstructSingleUnitCommand')
require('hoi3.api.CConstructUnitCommand')
require('hoi3.api.CContinent')
require('hoi3.api.CConvoy')
require('hoi3.api.CCountry')
require('hoi3.api.CCountryDataBase')
require('hoi3.api.CCountryList')
require('hoi3.api.CCountryTag')
require('hoi3.api.CCountryTagList')
require('hoi3.api.CCurrentGameState')
require('hoi3.api.CDate')
require('hoi3.api.CDebtAction')
require('hoi3.api.CDecision')
require('hoi3.api.CDeclareWarAction')
require('hoi3.api.CDiplomacyStatus')
require('hoi3.api.CDiplomaticAction')
require('hoi3.api.CDistributionSetting')
require('hoi3.api.CEmbargoAction')
require('hoi3.api.CFaction')
require('hoi3.api.CFactionAction')
require('hoi3.api.CFixedPoint')
require('hoi3.api.CFlags')
require('hoi3.api.CGoodsPool')
require('hoi3.api.CGovernment')
require('hoi3.api.CGovernmentPosition')
require('hoi3.api.CGuaranteeAction')
require('hoi3.api.CIdeology')
require('hoi3.api.CIdeologyData')
require('hoi3.api.CIdeologyGroup')
require('hoi3.api.CInfluenceAllianceLeader')
require('hoi3.api.CInfluenceNation')
require('hoi3.api.CLaw')
require('hoi3.api.CLawDataBase')
require('hoi3.api.CLawGroup')
require('hoi3.api.CLiberateCountryCommand')
require('hoi3.api.CLicenceTechnologyAction')
require('hoi3.api.CList')
require('hoi3.api.CMilitaryAccessAction')
require('hoi3.api.CMilitaryConstruction')
require('hoi3.api.CMinister')
require('hoi3.api.CModifier')
require('hoi3.api.CNapAction')
require('hoi3.api.CNullTag')
require('hoi3.api.CNullTechnology')
require('hoi3.api.COfferMilitaryAccessAction')
require('hoi3.api.CPeaceAction')
require('hoi3.api.CPersonality')
require('hoi3.api.CProvince')
require('hoi3.api.CProvinceBuilding')
require('hoi3.api.CResearchBonus')
require('hoi3.api.CRule')
require('hoi3.api.CSendExpeditionaryForceAction')
require('hoi3.api.CSetFlagCommand')
require('hoi3.api.CSetVariableCommand')
require('hoi3.api.CSimpleRandom')
require('hoi3.api.CSpyPresence')
require('hoi3.api.CStartResearchCommand')
require('hoi3.api.CStrategicWarfare')
require('hoi3.api.CString')
require('hoi3.api.CSubUnitConstructionEntry')
require('hoi3.api.CSubUnitConstructionEntryList')
require('hoi3.api.CSubUnitDataBase')
require('hoi3.api.CSubUnitDefinition')
require('hoi3.api.CTechnology')
require('hoi3.api.CTechnologyCategory')
require('hoi3.api.CTechnologyDataBase')
require('hoi3.api.CTechnologyFolder')
require('hoi3.api.CTechnologyStatus')
require('hoi3.api.CTheatre')
require('hoi3.api.CToggleMobilizationCommand')
require('hoi3.api.CTradeAction')
require('hoi3.api.CTradeRoute')
require('hoi3.api.CUnit')
require('hoi3.api.CUnitList')
require('hoi3.api.CWar')
require('hoi3.api.SpyMission')