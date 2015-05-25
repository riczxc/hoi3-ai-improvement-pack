# Introduction #

Below list list all LUA functions called by HOI3 executable. Some are well known, others as known as hooks thanks to Lothos annotations. Below list is for Semper Fi.

# Details #

  * `ForeignMinister_OnWar(`[CAIAgent](LUAClassReference#CAIAgent.md)` agent,`[CCountryTag](LUAClassReference#CCountryTag.md)` countryTag1,`[CCountryTag](LUAClassReference#CCountryTag.md)` countryTag2,  `[CCWar](LUAClassReference#CWar.md)`? war )`
  * `ForeignMinister_EvaluateDecision(`[CAIAgent](LUAClassReference#CAIAgent.md)` agent, `[CDecision](LUAClassReference#CDecision.md)` decision, ??? scope)`
  * `ForeignMinister_Tick(`[CAIForeignMinister](LUAClassReference#CAIForeignMinister.md)` minister)`
  * `IntelligenceMinister_Tick(`[CAIEspionageMinister](LUAClassReference#CAIEspionageMinister.md)` minister)`
  * `PoliticsMinister_Tick(`[CAIPoliticsMinister](LUAClassReference#CAIPoliticsMinister.md)` minister)`
  * `ProductionMinister_Tick(`[CAIProductionMinister](LUAClassReference#CAIProductionMinister.md)` minister)`
  * `BalanceProductionSliders(`[CAI](LUAClassReference#CAI.md)` ai, `[CCountry](LUAClassReference#CCountry.md)` ministerCountry, number prioSelection)`
  * `TechMinister_Tick(`[CAITechMinister](LUAClassReference#CAITechMinister.md)` minister, bool set_sliders, bool set_research)`
  * `ForeignMinister_ManageTrade(`[CAI](LUAClassReference#CAI.md)` ai, `[CCountryTag](LUAClassReference#CCountryTag.md)` ministerTag)
  * `DiploScore_OfferTrade(`[CAI](LUAClassReference#CAI.md)` ai, `[CCountryTag](LUAClassReference#CCountryTag.md)` actor, `[CCountryTag](LUAClassReference#CCountryTag.md)` recipient, `[CCountryTag](LUAClassReference#CCountryTag.md)` observer, `[CTradeAction](LUAClassReference#CTradeAction.md)` voTradeAction, table voTradedFrom, table voTradedTo)`

### DiploScore\_OfferTrade note ###
Both voTradedFrom and voTradedTo parameter seems to be either dictionaries or object with following keys/properties :
  * voTradedTo.vMoney
  * voTradedTo.vMetal
  * voTradedTo.vEnergy
  * voTradedTo.vRareMaterials
  * voTradedTo.vCrudeOil
  * voTradedTo.vSupplies
  * voTradedTo.vFuel