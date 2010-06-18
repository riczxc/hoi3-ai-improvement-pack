--[[
	HOI3 fake API
	
	It is sometimes difficult to code pure LUA features for HOI3
	This package provide basic support for a fake game instance.

	All values returned fully random atm. 
]]


-- Now declare all HOI3 API objects
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
require('hoi3.api.CFactionAction')
require('hoi3.api.CFlags')
require('hoi3.api.CGoodsPool')