# Hearts of Iron III - LUA class reference #

---

## AbstractObject ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

This object does not exist in HOI3, and is only used in hoi3 fake api.

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAI ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>AlreadyTradingDisabledResource</code>(<a href='#CTradeRoute.md'>CTradeRoute</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>AlreadyTradingResourceOtherWay</code>(<a href='#CTradeRoute.md'>CTradeRoute</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>CalculateFriendOfFaction</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanDeclareWar</code>(<a href='#CCountryTag.md'>CCountryTag</a>, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanTradeFreeResources</code>(<a href='#CCountryTag.md'>CCountryTag</a>, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>EvaluateCancelTrades</code>(number, number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetAmountTradedFrom</code>(number, <a href='#CCountryTag.md'>CCountryTag</a>, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>static string</font></td><td><font face='monospace'><code>GetCommonModDirectory</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountry.md'>CCountry</a></font></td><td><font face='monospace'><code>GetCountry</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetCountryAlignmentDistance</code>(<a href='#CCountry.md'>CCountry</a>, <a href='#CCountry.md'>CCountry</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CEU3Date.md'>CEU3Date</a></font></td><td><font face='monospace'><code>GetCurrentDate</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CArrayFloat.md'>CArrayFloat</a></font></td><td><font face='monospace'><code>GetDeployedSubUnitCounts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static string</font></td><td><font face='monospace'><code>GetModDirectory</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetNormalizedAlignmentDistance</code>(<a href='#CCountry.md'>CCountry</a>, <a href='#CFaction.md'>CFaction</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfOwnedProvinces</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CArrayFloat.md'>CArrayFloat</a></font></td><td><font face='monospace'><code>GetProductionSubUnitCounts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CDiplomacyStatus.md'>CDiplomacyStatus</a></font></td><td><font face='monospace'><code>GetRelation</code>(<a href='#CCountryTag.md'>CCountryTag</a>, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CSubUnitConstructionEntryList.md'>CSubUnitConstructionEntryList</a></font></td><td><font face='monospace'><code>GetReqProdQueue</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CSubUnitConstructionEntry.md'>CSubUnitConstructionEntry</a>></font></td><td><font face='monospace'><code>GetReqProdQueueIter</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetSpamPenalty</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CArrayFloat.md'>CArrayFloat</a></font></td><td><font face='monospace'><code>GetTheatreSubUnitNeedCounts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static boolean</font></td><td><font face='monospace'><code>HasCommonExtension</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasFilledProdQueue</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasTradeGoneStale</code>(<a href='#CTradeRoute.md'>CTradeRoute</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>static boolean</font></td><td><font face='monospace'><code>HasUserExtension</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>IsAIControlledForPlayer</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsInfluencing</code>(<a href='#CCountryTag.md'>CCountryTag</a>, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsTradeingAwayNeededResource</code>(<a href='#CTradeRoute.md'>CTradeRoute</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>MoveToNeighbor</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>MoveUnit</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>Post</code>(<a href='#CCommand.md'>CCommand</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>PostAction</code>(<a href='#CAction.md'>CAction</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>PrintConsole</code>(string)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>RequestSubUnit</code>(unknown)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CAI._DIPLOMACY_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAI._INTELLIGENCE_</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAI._POLITICS_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAI._PRODUCTION_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAI._TECHNOLOGY_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIAgent ##
Implements [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CCountry.md'>CCountry</a></font></td><td><font face='monospace'><code>GetCountry</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetCountryTag</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIEspionageMinister ##
Implements [CAIAgent](#CAIAgent.md), [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountryTag.md'>CCountryTag</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountryTag</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAI.md'>CAI</a></font></td><td><font face='monospace'><code>GetOwnerAI</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsAligningToFaction</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIForeignMinister ##
Implements [CAIAgent](#CAIAgent.md), [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>ClearWarProposal</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>ExecuteDiploDecisions</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountryTag.md'>CCountryTag</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountryTag</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAI.md'>CAI</a></font></td><td><font face='monospace'><code>GetOwnerAI</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetProposedWarTarget</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>PercOccupied</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>Propose</code>(<a href='#CDiplomaticAction.md'>CDiplomaticAction</a>, number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>ProposeWar</code>(<a href='#CCountryTag.md'>CCountryTag</a>, number)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIIntel ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CAIIntel(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CalculateOurMilitaryStrength</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CalculateTheirPercievedMilitaryStrengh</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFactor</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetTheirFactor</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetUncertaintyFactor</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasNoIntel</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIPoliticsMinister ##
Implements [CAIAgent](#CAIAgent.md), [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountryTag.md'>CCountryTag</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountryTag</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAI.md'>CAI</a></font></td><td><font face='monospace'><code>GetOwnerAI</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsCapitalSafeToLiberate</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIProductionMinister ##
Implements [CAIAgent](#CAIAgent.md), [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CountEscortsUnderConstruction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CountTotalDesiredEscorts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CountTransportsUnderConstruction</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountryTag.md'>CCountryTag</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountryTag</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetDesperation</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAI.md'>CAI</a></font></td><td><font face='monospace'><code>GetOwnerAI</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>PrioritizeBuildQueue</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAIStrategy ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>AddSubUnit</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>CancelPrepareWar</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAccessScore</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAntagonism</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountry.md'>CCountry</a></font></td><td><font face='monospace'><code>GetCountry</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetCountryTag</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFriendliness</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetPersonality</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetProtectionism</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTheatre.md'>CTheatre</a>></font></td><td><font face='monospace'><code>GetTheatres</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetThreat</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetWantedSubUnits</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetWarScoreWith</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetWarTarget</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetWarTargets</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBalanced</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsDiplomat</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsIndustrialist</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsMilitarist</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsPreparingWar</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsPreparingWarWith</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>PrepareLimitedWar</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>PrepareWar</code>(<a href='#CCountryTag.md'>CCountryTag</a>, number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>PrepareWarDecision</code>(<a href='#CCountryTag.md'>CCountryTag</a>, number, <a href='#CDecision.md'>CDecision</a>)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CAIStrategy._AI_BALANCED_</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAIStrategy._AI_DIPLOMAT_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAIStrategy._AI_INDUSTRIALIST_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAIStrategy._AI_MILITARIST_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CAIStrategy._AI_UNDEFINED_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAISubscriber ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>WantTicks</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAITechMinister ##
Implements [CAIAgent](#CAIAgent.md), [CAISubscriber](#CAISubscriber.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanResearch</code>(<a href='#CTechnology.md'>CTechnology</a>)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountryTag.md'>CCountryTag</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountryTag</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CArrayFloat.md'>CArrayFloat</a></font></td><td><font face='monospace'><code>GetFolderModifers</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAI.md'>CAI</a></font></td><td><font face='monospace'><code>GetOwnerAI</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CArrayFloat.md'>CArrayFloat</a></font></td><td><font face='monospace'><code>GetTechModifers</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>WantTicks</code>(unknown)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAction ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static unknown</font></td><td><font face='monospace'><code>Create</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAlignment ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetDistanceFrom</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetLastDrift</code>(<a href='#CIdeologyGroup.md'>CIdeologyGroup</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CAllianceAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CAllianceAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CArrayFix ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CArrayFix(number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetAt</code>(number, <a href='#CFixedPoint.md'>CFixedPoint</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CArrayFix64 ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CArrayFix64(number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetAt</code>(number, <a href='#CFixedPoint.md'>CFixedPoint</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CArrayFloat ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CArrayFloat(number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetAt</code>(number, number)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CArrayInt ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CArrayInt(number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetAt</code>(number, number)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CBrigadeConstructionDefinition ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetType</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CBuilding ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetName</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CBuildingDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static <a href='#CBuilding.md'>CBuilding</a></font></td><td><font face='monospace'><code>GetBuilding</code>(string)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CBuilding.md'>CBuilding</a></font></td><td><font face='monospace'><code>GetBuildingFromIndex</code>(number)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCallAllyAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CCallAllyAction(CCountryTag, CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetVersus</code>(unknown)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>SetVersus</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCancelUnitConstructionCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CCancelUnitConstructionCommand(CCountryTag, CID)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeInvestmentCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeInvestmentCommand(CCountryTag, number, number, number, number, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeLawCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeLawCommand(CCountryTag, CLaw, CLawGroup)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeLeadershipCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeLeadershipCommand(CCountryTag, number, number, number, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeMinisterCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeMinisterCommand(CCountryTag, CMinister, CGovernmentPosition)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangePriorityCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangePriorityCommand(CCountryTag, CID, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeSpyMission ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeSpyMission(CCountryTag, CCountryTag, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CChangeSpyPriority ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CChangeSpyPriority(CCountryTag, CCountryTag, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCommand ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CCommand.md'>CCommand</a></font></td><td><font face='monospace'><code>Clone</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConstructBuildingCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CConstructBuildingCommand(CCountryTag, CBuilding, number, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConstructConvoyCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CConstructConvoyCommand(CCountryTag, boolean, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConstructSingleUnitCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConstructUnitCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CConstructUnitCommand(CCountryTag, SubUnitList, number, number, boolean, CCountryTag, CID)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConstruction ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCost</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CMilitaryConstruction.md'>CMilitaryConstruction</a></font></td><td><font face='monospace'><code>GetMilitary</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetSize</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBuilding</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsConvoy</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsMilitary</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CContinent ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetName</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetTag</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CConvoy ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetDesiredEscorts</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetDesiredTransports</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetEfficiency</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>IsForTradeRoute</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCountry ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>AICalculateExpense</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTradeRoute.md'>CTradeRoute</a>></font></td><td><font face='monospace'><code>AIGetTradeRoutes</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CIdeologyData.md'>CIdeologyData</a></font></td><td><font face='monospace'><code>AccessIdeologyOrganization</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CIdeologyData.md'>CIdeologyData</a></font></td><td><font face='monospace'><code>AccessIdeologyPopularity</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>CalcDesperation</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CalculateIsAllied</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>CalculateNumberOfActiveInfluences</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>CalculateReinforcementMultiplier</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>CanBreakNAPWith</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanCreatePuppet</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>Exists</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>GetAbility</code>(<a href='#CTechnologyCategory.md'>CTechnologyCategory</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CProvince.md'>CProvince</a></font></td><td><font face='monospace'><code>GetActingCapitalLocation</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CProvince.md'>CProvince</a>></font></td><td><font face='monospace'><code>GetAirBases</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAlignment.md'>CAlignment</a></font></td><td><font face='monospace'><code>GetAlignment</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetAlignmentCord</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetAllies</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAllowedResearchSlots</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetAreActingCapitalsOnSameContinent</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAvailableIC</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetBuildCost</code>(<a href='#CBuilding.md'>CBuilding</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetBuildCostIC</code>(<a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>, number, boolean)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetBuildCostMP</code>(<a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>, number, boolean)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetBuildTime</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCapital</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CProvince.md'>CProvince</a></font></td><td><font face='monospace'><code>GetCapitalLocation</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CConstruction.md'>CConstruction</a>></font></td><td><font face='monospace'><code>GetConstructions</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code>number></font></td><td><font face='monospace'><code>GetControlledProvinces</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetConvoyBuildCost</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetConvoyBuildTime</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetConvoyedIn</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetConvoyedOut</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CConvoy.md'>CConvoy</a>></font></td><td><font face='monospace'><code>GetConvoys</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code>number></font></td><td><font face='monospace'><code>GetCoreProvinces</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetCountryTag</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetCurrentAtWarWith</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTechnology.md'>CTechnology</a>></font></td><td><font face='monospace'><code>GetCurrentResearch</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDailyBalance</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDailyExpense</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDailyIncome</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDailyNeed</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CDiplomacyStatus.md'>CDiplomacyStatus</a>></font></td><td><font face='monospace'><code>GetDiplomacy</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDiplomaticDistance</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDiplomaticInfluence</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetDissent</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetEffectiveNeutrality</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetEscortBuildCost</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetEscortBuildTime</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetEscorts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFaction.md'>CFaction</a></font></td><td><font face='monospace'><code>GetFaction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetFlags</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CModifier.md'>CModifier</a></font></td><td><font face='monospace'><code>GetGlobalModifier</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGovernment.md'>CGovernment</a></font></td><td><font face='monospace'><code>GetGovernment</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetHighestThreat</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetHistoricalMinisters</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetHomeProduced</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetICPart</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CLaw.md'>CLaw</a></font></td><td><font face='monospace'><code>GetLaw</code>(<a href='#CLawGroup.md'>CLawGroup</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CLaw.md'>CLaw</a></font></td><td><font face='monospace'><code>GetLawFromIndex</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CDistributionSetting.md'>CDistributionSetting</a></font></td><td><font face='monospace'><code>GetLeadershipDistributionAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetManpower</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetMaxIC</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetMaxNeutralityForWarWith</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CMinister.md'>CMinister</a></font></td><td><font face='monospace'><code>GetMinister</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetMinisters</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetMoneyBalanceAverage</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetNationalUnity</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CProvince.md'>CProvince</a>></font></td><td><font face='monospace'><code>GetNavalBases</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetNeighbours</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetNeutrality</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumOfAirfields</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumOfAllies</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumOfPorts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfControlledProvinces</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfCurrentResearch</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetNumberOfFreeSpies</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfOwnedProvinces</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetOfficerRatio</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetOverlord</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code>number></font></td><td><font face='monospace'><code>GetOwnedProvinces</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetPool</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetPossibleLiberations</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CMinister.md'>CMinister</a>></font></td><td><font face='monospace'><code>GetPossibleMinisters</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetPossiblePuppets</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CDistributionSetting.md'>CDistributionSetting</a></font></td><td><font face='monospace'><code>GetProductionDistributionAt</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CDiplomacyStatus.md'>CDiplomacyStatus</a></font></td><td><font face='monospace'><code>GetRelation</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CRule.md'>CRule</a></font></td><td><font face='monospace'><code>GetRules</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CIdeology.md'>CIdeology</a></font></td><td><font face='monospace'><code>GetRulingIdeology</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CSpyPresence.md'>CSpyPresence</a></font></td><td><font face='monospace'><code>GetSpyPresence</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetSpyingOnUs</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CStrategicWarfare.md'>CStrategicWarfare</a></font></td><td><font face='monospace'><code>GetStrategicWarfare</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CAIStrategy.md'>CAIStrategy</a></font></td><td><font face='monospace'><code>GetStrategy</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetSupplyBalanceAverage</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetSurrenderLevel</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CTechnologyStatus.md'>CTechnologyStatus</a></font></td><td><font face='monospace'><code>GetTechnologyStatus</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalConvoyTransports</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetTotalCoreBuildingLevels</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalIC</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetTotalLeadership</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNeededConvoyTransports</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNeededTransports</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetTotalProduced</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetTradedAway</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetTradedAwaySansAlliedSupply</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetTradedFor</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CGoodsPool.md'>CGoodsPool</a></font></td><td><font face='monospace'><code>GetTradedForSansAlliedSupply</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTransports</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CUnitList.md'>CUnitList</a></font></td><td><font face='monospace'><code>GetUnits</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CUnit.md'>CUnit</a>></font></td><td><font face='monospace'><code>GetUnitsIterator</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetUsedIC</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CVariables.md'>CVariables</a></font></td><td><font face='monospace'><code>GetVariables</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetVassals</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasConstruction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasDiplomatEnroute</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasExtraManpowerLeft</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasFaction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>HasIncomingTradeOffer</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasNeighborInFaction</code>(<a href='#CFaction.md'>CFaction</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsAtWar</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBuildingAllowed</code>(<a href='#CBuilding.md'>CBuilding</a>, <a href='#CProvince.md'>CProvince</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsEnemy</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsFactionLeader</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsFriend</code>(<a href='#CCountryTag.md'>CCountryTag</a>, boolean)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsGovernmentInExile</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsMajor</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsMobilized</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsNeighbour</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsNeighbourToFactionHostile</code>(<a href='#CFaction.md'>CFaction</a>, boolean)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsPuppet</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsSubject</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>MayLiberateCountries</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>NeedConvoyToTradeWith</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCountryDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static <a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetTag</code>(string)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCountryList ##
Implements <font color='grey'><em><a href='#CList.md'>CList</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsEnemy</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCountryTag ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.
#### Metamethod summary ####
This object support LUA special features :
  * Special operators : supports tostring() operator


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CCountry.md'>CCountry</a></font></td><td><font face='monospace'><code>GetCountry</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetTag</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsReal</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCountryTagList ##
Implements <font color='grey'><em><a href='#CList.md'>CList</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCreateVassalCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CCreateVassalCommand(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CCurrentGameState ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetAIRand</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CCountry.md'>CCountry</a>></font></td><td><font face='monospace'><code>GetCountries</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CEU3Date.md'>CEU3Date</a></font></td><td><font face='monospace'><code>GetCurrentDate</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CFaction.md'>CFaction</a></font></td><td><font face='monospace'><code>GetFaction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CFaction.md'>CFaction</a>></font></td><td><font face='monospace'><code>GetFactions</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static unknown</font></td><td><font face='monospace'><code>GetInstance</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetPlayer</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CProvince.md'>CProvince</a></font></td><td><font face='monospace'><code>GetProvince</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>static boolean</font></td><td><font face='monospace'><code>IsGlobalFlagSet</code>(string)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDebtAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CDebtAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDecision ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>nil</font></td><td><font face='monospace'><code>IsPotential</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDeclareWarAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CDeclareWarAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDiplomacyStatus ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>AllowDebts</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFloatValue</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetThreat</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTradeRoute.md'>CTradeRoute</a>></font></td><td><font face='monospace'><code>GetTradeRoutes</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetValue</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CWar.md'>CWar</a></font></td><td><font face='monospace'><code>GetWar</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasAlliance</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasAnyAgreement</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasEmbargo</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasFriendlyAgreement</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasHostileAgreement</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasMilitaryAccess</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasNap</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasTruce</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasWar</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBeingInfluenced</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsFightingWarTogether</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsGuaranteed</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsGuaranting</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDiplomaticAction ##
Implements [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetAIAcceptance</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetType</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetValue</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsSelectable</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetValue</code>(boolean)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CDiplomaticAction.ACCEPT</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDiplomaticAction.DECLINE</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDiplomaticAction.PROPOSE</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CDistributionSetting ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetNeeded</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetPercentage</code>(unknown)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._LEADERSHIP_DIPLOMACY_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._LEADERSHIP_ESPIONAGE_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._LEADERSHIP_NCO_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._LEADERSHIP_RESEARCH_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._PRODUCTION_CONSUMER_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._PRODUCTION_PRODUCTION_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._PRODUCTION_REINFORCEMENT_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._PRODUCTION_SUPPLY_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CDistributionSetting._PRODUCTION_UPGRADE_</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CEU3Date ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>AddDays</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetDayOfMonth</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetMonthOfYear</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalDays</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetYear</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CEmbargoAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CEmbargoAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CEventScope ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Properties summary ####
<table width='100%' border='1'>
<tr><th>Property</th><th>Type</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>read/write unknown</code></font></td><td><font face='monospace'><code>_Country</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>_nProvince</code></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CFaction ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetFactionLeader</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CIdeologyGroup.md'>CIdeologyGroup</a></font></td><td><font face='monospace'><code>GetIdeologyGroup</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CCountryTag.md'>CCountryTag</a>></font></td><td><font face='monospace'><code>GetMembers</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetNormalizedProgress</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfMembers</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetProgress</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetTag</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CFactionAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CFactionAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CFixedPoint ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CFixedPoint()```
#### Metamethod summary ####
This object support LUA special features :
  * Mathematical operators : `<=,<,==,-,*,/,+`
  * Special operators : supports tostring() operator


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>Get</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTruncated</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CFixedPoint64 ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CFixedPoint64(number)```
#### Metamethod summary ####
This object support LUA special features :
  * Mathematical operators : `==,*,<=,<,/,+,-`


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>Get</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetRounded</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTruncated</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CFlags ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsFlagSet</code>(string)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGoodsPool ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>Get</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFloat</code>(number)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CGoodsPool._CRUDE_OIL_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._ENERGY_</code></font></td><td><font face='monospace'>5</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._FUEL_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._GC_NUMOF_</code></font></td><td><font face='monospace'>7</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._METAL_</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._MONEY_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._RARE_MATERIALS_</code></font></td><td><font face='monospace'>6</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CGoodsPool._SUPPLIES_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGoodsValues ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CGoodsValues()```


#### Properties summary ####
<table width='100%' border='1'>
<tr><th>Property</th><th>Type</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vCrudeOil</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vEnergy</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vFuel</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vMetal</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vMoney</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vRareMaterials</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vSupplies</code></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGovernment ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGovernmentPosition ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsChangeable</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGovernmentPositionDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static <a href='#CGovernmentPosition.md'>CGovernmentPosition</a></font></td><td><font face='monospace'><code>GetGovernmentPosition</code>(string)</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CGovernmentPosition.md'>CGovernmentPosition</a></font></td><td><font face='monospace'><code>GetGovernmentPositionByIndex</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CGovernmentPosition.md'>CGovernmentPosition</a>></font></td><td><font face='monospace'><code>GetGovernmentPositionList</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetNumberOfGovernmentPositions</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CGuaranteeAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CGuaranteeAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CID ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CID()```


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CIdeology ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CIdeologyGroup.md'>CIdeologyGroup</a></font></td><td><font face='monospace'><code>GetGroup</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CIdeologyData ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>CalculateTotalSum</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetValue</code>(<a href='#CIdeology.md'>CIdeology</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CIdeologyGroup ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFaction.md'>CFaction</a></font></td><td><font face='monospace'><code>GetFaction</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetPosition</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CInfluenceAllianceLeader ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CInfluenceAllianceLeader(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CInfluenceNation ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CInfluenceNation(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CLaw ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CLawGroup.md'>CLawGroup</a></font></td><td><font face='monospace'><code>GetGroup</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>ValidFor</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CLawDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CLawGroup.md'>CLawGroup</a>></font></td><td><font face='monospace'><code>GetGroups</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CLaw.md'>CLaw</a></font></td><td><font face='monospace'><code>GetLaw</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CLawGroup.md'>CLawGroup</a></font></td><td><font face='monospace'><code>GetLawGroup</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CLaw.md'>CLaw</a>></font></td><td><font face='monospace'><code>GetLawList</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetNumberOfLawGroups</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetNumberOfLaws</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CLawGroup ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CLiberateCountryCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CLiberateCountryCommand(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CLicenceTechnologyAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CLicenceTechnologyAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetMoney</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetParalell</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetSerial</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a></font></td><td><font face='monospace'><code>GetSubunit</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CMilitaryAccessAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CMilitaryAccessAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CMilitaryConstruction ##
Implements [CConstruction](#CConstruction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CBrigadeConstructionDefinition.md'>CBrigadeConstructionDefinition</a>></font></td><td><font face='monospace'><code>GetBrigades</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetCost</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CMilitaryConstruction.md'>CMilitaryConstruction</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetMilitary</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetSize</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsAir</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsBuilding</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsConvoy</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsLand</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsMilitary</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsNaval</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CMinister ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanTakePosition</code>(<a href='#CGovernmentPosition.md'>CGovernmentPosition</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CIdeology.md'>CIdeology</a></font></td><td><font face='monospace'><code>GetIdeology</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CMinisterType.md'>CMinisterType</a></font></td><td><font face='monospace'><code>GetPersonality</code>(<a href='#CGovernmentPosition.md'>CGovernmentPosition</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CMinisterType ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetDecay</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CMinisterTypeDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static <a href='#CMinisterType.md'>CMinisterType</a></font></td><td><font face='monospace'><code>GetMinisterType</code>(string)</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CMinisterType.md'>CMinisterType</a>></font></td><td><font face='monospace'><code>GetMinisterTypeList</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetNumberOfMinisterTypes</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CModifier ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetValue</code>(number)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_AIR_CAPACITY_</code></font></td><td><font face='monospace'>46</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_AIR_ORGANISATION_</code></font></td><td><font face='monospace'>70</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_ALIGN_TOWARDS_</code></font></td><td><font face='monospace'>47</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_ATTACK_REINFORCE_CHANCE_</code></font></td><td><font face='monospace'>63</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_ATTRITION_</code></font></td><td><font face='monospace'>7</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_COASTAL_FORT_LEVEL_</code></font></td><td><font face='monospace'>11</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_COMBAT_MOVEMENT_SPEED_</code></font></td><td><font face='monospace'>62</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_COMBAT_WIDTH_</code></font></td><td><font face='monospace'>65</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_COUNTER_ESPIONAGE_</code></font></td><td><font face='monospace'>55</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_COUNTER_INTELLIGENCE_</code></font></td><td><font face='monospace'>54</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_DEFEND_REINFORCE_CHANCE_</code></font></td><td><font face='monospace'>64</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_DISSENT_</code></font></td><td><font face='monospace'>43</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_DRIFT_SPEED_</code></font></td><td><font face='monospace'>36</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_ESPIONAGE_BONUS_</code></font></td><td><font face='monospace'>42</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_FORT_LEVEL_</code></font></td><td><font face='monospace'>10</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_CRUDE_OIL_</code></font></td><td><font face='monospace'>19</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_ENERGY_</code></font></td><td><font face='monospace'>21</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_FUEL_</code></font></td><td><font face='monospace'>29</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_IC_</code></font></td><td><font face='monospace'>17</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_INFRASTRUCTURE_</code></font></td><td><font face='monospace'>14</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_LEADERSHIP_</code></font></td><td><font face='monospace'>33</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_LEADERSHIP_MODIFIER_</code></font></td><td><font face='monospace'>35</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_MANPOWER_</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_MANPOWER_MODIFIER_</code></font></td><td><font face='monospace'>6</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_METAL_</code></font></td><td><font face='monospace'>23</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_MONEY_</code></font></td><td><font face='monospace'>31</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_RARE_MATERIALS_</code></font></td><td><font face='monospace'>25</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_REVOLT_RISK_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_GLOBAL_SUPPLIES_</code></font></td><td><font face='monospace'>27</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_IC_</code></font></td><td><font face='monospace'>15</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_INCORPORATE_COST_</code></font></td><td><font face='monospace'>38</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_INDUSTRIAL_EFFICIENCY_</code></font></td><td><font face='monospace'>73</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_INFRASTRUCTURE_</code></font></td><td><font face='monospace'>12</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LAND_ORGANISATION_</code></font></td><td><font face='monospace'>69</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_ANTI_AIR_</code></font></td><td><font face='monospace'>74</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_CRUDE_OIL_</code></font></td><td><font face='monospace'>18</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_ENERGY_</code></font></td><td><font face='monospace'>20</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_FUEL_</code></font></td><td><font face='monospace'>28</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_IC_</code></font></td><td><font face='monospace'>16</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_INFRASTRUCTURE_</code></font></td><td><font face='monospace'>13</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_LEADERSHIP_</code></font></td><td><font face='monospace'>32</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_LEADERSHIP_MODIFIER_</code></font></td><td><font face='monospace'>34</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_MANPOWER_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_MANPOWER_MODIFIER_</code></font></td><td><font face='monospace'>5</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_METAL_</code></font></td><td><font face='monospace'>22</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_MONEY_</code></font></td><td><font face='monospace'>30</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_PARTISAN_SUPPORT_</code></font></td><td><font face='monospace'>75</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_RARE_MATERIALS_</code></font></td><td><font face='monospace'>24</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_REVOLT_RISK_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_LOCAL_SUPPLIES_</code></font></td><td><font face='monospace'>26</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_MAX_WAR_EXHAUSTION_</code></font></td><td><font face='monospace'>9</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_MINIMUM_REVOLT_RISK_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NATIONAL_UNITY_</code></font></td><td><font face='monospace'>44</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NATIONAL_UNITY_EFFECT_</code></font></td><td><font face='monospace'>67</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NAVAL_BASE_EFFICIENCY_</code></font></td><td><font face='monospace'>79</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NAVAL_CAPACITY_</code></font></td><td><font face='monospace'>45</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NAVAL_ORGANISATION_</code></font></td><td><font face='monospace'>71</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_NEUTRALITY_CHANGE_</code></font></td><td><font face='monospace'>77</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_OFFICER_RECRUITMENT_</code></font></td><td><font face='monospace'>81</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_OFFMAP_INDUSTRY_INTEL_</code></font></td><td><font face='monospace'>60</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_OFFMAP_LAND_INTEL_</code></font></td><td><font face='monospace'>58</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_OFFMAP_NAVAL_INTEL_</code></font></td><td><font face='monospace'>59</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_OFFMAP_POLITICAL_INTEL_</code></font></td><td><font face='monospace'>61</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_ORG_REGAIN_</code></font></td><td><font face='monospace'>66</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_PARTISAN_EFFICENCY_</code></font></td><td><font face='monospace'>78</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_PEACETIME_MANPOWER_ROTATION_</code></font></td><td><font face='monospace'>50</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_PEACE_CONSUMER_GOODS_DEMAND_</code></font></td><td><font face='monospace'>41</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_PEACE_OFFMAP_INTEL_</code></font></td><td><font face='monospace'>57</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_RADAR_LEVEL_</code></font></td><td><font face='monospace'>48</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_RESEARCH_EFFICIENCY_</code></font></td><td><font face='monospace'>72</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_RESERVES_PENALTY_SIZE_</code></font></td><td><font face='monospace'>76</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_RULING_PARTY_SUPPORT_</code></font></td><td><font face='monospace'>68</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_SUPPLY_CONSUMPTION_</code></font></td><td><font face='monospace'>49</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_SUPPLY_THROUGHPUT_</code></font></td><td><font face='monospace'>80</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_SUSEPTIBILITY_</code></font></td><td><font face='monospace'>37</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_TERRITORIAL_PRIDE_</code></font></td><td><font face='monospace'>39</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_THREAT_IMPACT_</code></font></td><td><font face='monospace'>56</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_UNIT_RECRUITMENT_TIME_</code></font></td><td><font face='monospace'>51</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_UNIT_REPAIR_</code></font></td><td><font face='monospace'>53</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_UNIT_START_EXPERIENCE_</code></font></td><td><font face='monospace'>52</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_WAR_CONSUMER_GOODS_DEMAND_</code></font></td><td><font face='monospace'>40</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CModifier._MODIFIER_WAR_EXHAUSTION_</code></font></td><td><font face='monospace'>8</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CNapAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CNapAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CNullTag ##
Implements [CCountryTag](#CCountryTag.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CNullTag()```
#### Metamethod summary ####
This object support LUA special features :
  * Special operators : supports tostring() operator


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCountry.md'>CCountry</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetCountry</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetIndex</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>string</i></font></td><td><font color='grey' face='monospace'><i><code>GetTag</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsReal</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CNullTechnology ##
Implements [CTechnology](#CTechnology.md), <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>CanResearch</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>CanUpgrade</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetDifficulty</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>GetEnableUnit</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CTechnologyFolder.md'>CTechnologyFolder</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetFolder</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetIndex</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CString.md'>CString</a></i></font></td><td><font color='grey' face='monospace'><i><code>GetKey</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetOnCompletion</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>iterator<code>&lt;</code><a href='#CResearchBonus.md'>CResearchBonus</a>></i></font></td><td><font color='grey' face='monospace'><i><code>GetResearchBonus</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsOneLevelOnly</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## COfferMilitaryAccessAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
COfferMilitaryAccessAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CPeaceAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CPeaceAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CProvince ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CProvinceBuilding.md'>CProvinceBuilding</a></font></td><td><font face='monospace'><code>GetBuilding</code>(<a href='#CBuilding.md'>CBuilding</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCoastalFortLevel</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CContinent.md'>CContinent</a></font></td><td><font face='monospace'><code>GetContinent</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetController</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCurrentConstructionLevel</code>(<a href='#CBuilding.md'>CBuilding</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFortLevel</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetInfrastructure</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIntelLevel</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetMaxInfrastructure</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumberOfUnits</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetOwner</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetProvinceID</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CUnit.md'>CUnit</a>></font></td><td><font face='monospace'><code>GetUnits</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasAdjacentEnemyOrCB</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>HasBuilding</code>(<a href='#CBuilding.md'>CBuilding</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsFrontProvince</code>(boolean)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CProvinceBuilding ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetCurrent</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetMax</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CResearchBonus ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Properties summary ####
<table width='100%' border='1'>
<tr><th>Property</th><th>Type</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>read only CTechnologyCategory</code></font></td><td><font face='monospace'><code>_pCategory</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read only CFixedPoint</code></font></td><td><font face='monospace'><code>_vWeight</code></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CResourceValues ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CResourceValues()```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>GetResourceValues</code>(<a href='#CCountry.md'>CCountry</a>, number)</font></td><td></td></tr>
</table>
#### Properties summary ####
<table width='100%' border='1'>
<tr><th>Property</th><th>Type</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vConvoyedIn</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vDailyBalance</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vDailyExpense</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vDailyHome</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vDailyIncome</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read/write number</code></font></td><td><font face='monospace'><code>vPool</code></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CRule ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetValue</code>()</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CRule._RULE_ALLIANCE_GUARANTEE_</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CRule._RULE_FREE_RESOURCE_GIFTS_</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CRule._RULE_LIMITED_WAR_</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CRule._RULE_NONE_</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSendExpeditionaryForceAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CSendExpeditionaryForceAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetClaimType</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetTag</code>(unknown)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetUnit</code>(unknown)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CSendExpeditionaryForceAction.SEND</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CSendExpeditionaryForceAction.TAKE</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSetFlagCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CSetFlagCommand(CCountryTag, string, boolean)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSetVariableCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CSetVariableCommand(CCountryTag, CString, CFixedPoint)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSimpleRandom ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>GetFixedPoint</font></td><td><font face='monospace'><code>GetFixedPoint</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetInteger</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetNumber</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>Seed</code>(number)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSpyPresence ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CEU3Date.md'>CEU3Date</a></font></td><td><font face='monospace'><code>GetLastMissionChangeDate</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetLevel</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetMission</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetPriority</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static unknown</font></td><td><font face='monospace'><code>MissionAllowed</code>(unknown)</font></td><td></td></tr>
</table>
#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>CSpyPresence.MAX_SPY_LEVEL</code></font></td><td><font face='monospace'>10</font></td><td></td></tr>
<tr><td><font face='monospace'><code>CSpyPresence.MAX_SPY_PRIORITY</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CStartResearchCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CStartResearchCommand(CCountryTag, CTechnology)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CStrategicWarfare ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetAlliesImpact</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetBombingImpact</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetConvoyImpact</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CString ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CString(string)```
#### Metamethod summary ####
This object support LUA special features :
  * Mathematical operators : `==`
  * Special operators : supports tostring() operator


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetCharPtr</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetString</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSubUnitConstructionEntry ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CSubUnitConstructionEntry(CSubUnitDefinition, number, number)```


#### Properties summary ####
<table width='100%' border='1'>
<tr><th>Property</th><th>Type</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>read only number</code></font></td><td><font face='monospace'><code>nPrio</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read only number</code></font></td><td><font face='monospace'><code>nSequence</code></font></td><td></td></tr>
<tr><td><font face='monospace'><code>read only CSubUnitDefinition</code></font></td><td><font face='monospace'><code>pUnit</code></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSubUnitConstructionEntryList ##
Implements <font color='grey'><em><a href='#CList.md'>CList</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CSubUnitConstructionEntry.md'>CSubUnitConstructionEntry</a></font></td><td><font face='monospace'><code>GetHeadData</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetSize</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CSubUnitConstructionEntry.md'>CSubUnitConstructionEntry</a></font></td><td><font face='monospace'><code>GetTailData</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsEmpty</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>Remove</code>(<a href='#CSubUnitConstructionEntry.md'>CSubUnitConstructionEntry</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>RemoveHead</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>RemoveTail</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSubUnitDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>static number</font></td><td><font face='monospace'><code>GetNumberOfSubUnits</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a></font></td><td><font face='monospace'><code>GetSubUnitByIndex</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>static iterator<code>&lt;</code><a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>></font></td><td><font face='monospace'><code>GetSubUnitList</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CSubUnitDefinition ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanParadrop</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetBuildCostIC</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetBuildCostMP</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetBuildTime</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCombatWidth</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCompletionSize</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetDefaultStrength</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetDefensivness</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>string</font></td><td><font face='monospace'><code>GetName</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetSoftness</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetToughness</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBomber</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBuildable</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsCag</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsCapitalShip</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsCarrier</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsRegiment</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsSecondRank</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsShip</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsSub</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsTransport</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTechnology ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanResearch</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanUpgrade</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetDifficulty</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>GetEnableUnit</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CTechnologyFolder.md'>CTechnologyFolder</a></font></td><td><font face='monospace'><code>GetFolder</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetOnCompletion</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CResearchBonus.md'>CResearchBonus</a>></font></td><td><font face='monospace'><code>GetResearchBonus</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsOneLevelOnly</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTechnologyCategory ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTechnologyDataBase ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTechnologyCategory.md'>CTechnologyCategory</a>></font></td><td><font face='monospace'><code>GetCategories</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetFolderIndex</code>(string)</font></td><td></td></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CTechnology.md'>CTechnology</a>></font></td><td><font face='monospace'><code>GetTechnologies</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static <a href='#CTechnology.md'>CTechnology</a></font></td><td><font face='monospace'><code>GetTechnology</code>(string)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTechnologyFolder ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetIndex</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetKey</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTechnologyStatus ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>CanResearch</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetCost</code>(<a href='#CTechnology.md'>CTechnology</a>, number)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetEffectiveYear</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetIcModifier</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetLevel</code>(<a href='#CTechnology.md'>CTechnology</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetYear</code>(<a href='#CTechnology.md'>CTechnology</a>, number)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsBuildingAvailable</code>(<a href='#CBuilding.md'>CBuilding</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsSubUnitAvailable</code>(<a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsUnitAvailable</code>(<a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTheatre ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetPriority</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CToggleMobilizationCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CToggleMobilizationCommand(CCountryTag, boolean)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTradeAction ##
Implements [CDiplomaticAction](#CDiplomaticAction.md), [CAction](#CAction.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CTradeAction(CCountryTag, CCountryTag)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i>static unknown</i></font></td><td><font color='grey' face='monospace'><i><code>Create</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>number</i></font></td><td><font color='grey' face='monospace'><i><code>GetAIAcceptance</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CTradeRoute.md'>CTradeRoute</a></font></td><td><font face='monospace'><code>GetRoute</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetTrading</code>(number, <a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetType</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>unknown</i></font></td><td><font color='grey' face='monospace'><i><code>GetValue</code>(unknown)</i></font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsConvoyPossible</code>()</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsSelectable</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetRoute</code>(<a href='#CTradeRoute.md'>CTradeRoute</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>void</font></td><td><font face='monospace'><code>SetTrading</code>(<a href='#CFixedPoint.md'>CFixedPoint</a>, number)</font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>void</i></font></td><td><font color='grey' face='monospace'><i><code>SetValue</code>(boolean)</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CTradeRoute ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetConvoyResponsible</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>static unknown</font></td><td><font face='monospace'><code>GetCost</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetFrom</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetLastInactive</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CCountryTag.md'>CCountryTag</a></font></td><td><font face='monospace'><code>GetTo</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetTradedFromOf</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CFixedPoint.md'>CFixedPoint</a></font></td><td><font face='monospace'><code>GetTradedToOf</code>(number)</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsInactive</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsValid</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CUnit ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>iterator<code>&lt;</code><a href='#CUnit.md'>CUnit</a>></font></td><td><font face='monospace'><code>GetChildren</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CString.md'>CString</a></font></td><td><font face='monospace'><code>GetName</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsMoving</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CUnitList ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCount</code>(<a href='#CSubUnitDefinition.md'>CSubUnitDefinition</a>)</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalAmountOfArmies</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalAmountOfDivisions</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNumOfPlanes</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNumOfRegiments</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNumOfShips</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNumOfTransports</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetTotalNumOfWarShips</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetTotalStrength</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CUpgradeRegimentCommand ##
Implements [CCommand](#CCommand.md), <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
CUpgradeRegimentCommand(CSubUnit, number)```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font color='grey' face='monospace'><i><a href='#CCommand.md'>CCommand</a></i></font></td><td><font color='grey' face='monospace'><i><code>Clone</code>()</i></font></td><td></td></tr>
<tr><td><font color='grey' face='monospace'><i>boolean</i></font></td><td><font color='grey' face='monospace'><i><code>IsValid</code>()</i></font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CVariables ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetVariable</code>()</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## CWar ##
Implements <font color='grey'><em><a href='#MultitonObject.md'>MultitonObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetAttackers</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>number</font></td><td><font face='monospace'><code>GetCurrentRunningTimeInMonths</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetDefenders</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'><a href='#CEU3Date.md'>CEU3Date</a></font></td><td><font face='monospace'><code>GetStartDate</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsLimited</code>()</font></td><td></td></tr>
<tr><td><font face='monospace'>boolean</font></td><td><font face='monospace'><code>IsPartOfWar</code>(<a href='#CCountryTag.md'>CCountryTag</a>)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## Hoi3Object ##
Implements <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

This object does not exist in HOI3, and is only used in hoi3 fake api.

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## MultitonObject ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

This object does not exist in HOI3, and is only used in hoi3 fake api.

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## Object ##
This object does not exist in HOI3, and is only used in hoi3 fake api.

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## SingletonObject ##
Implements <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

This object does not exist in HOI3, and is only used in hoi3 fake api.

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## SpyMission ##
Implements <font color='grey'><em><a href='#AbstractObject.md'>AbstractObject</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
There is no constructor for this object, use API reference in order to find a method returning expected type.


#### Constant summary ####
<table width='100%' border='1'>
<tr><th>Constant</th><th>Value</th><th>Since</th></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_BOOST_OUR_PARTY</code></font></td><td><font face='monospace'>6</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_BOOST_RULING_PARTY</code></font></td><td><font face='monospace'>5</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_COUNTER_ESPIONAGE</code></font></td><td><font face='monospace'>1</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_DISRUPT_PRODUCTION</code></font></td><td><font face='monospace'>10</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_DISRUPT_RESEARCH</code></font></td><td><font face='monospace'>9</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_INCREASE_THREAT</code></font></td><td><font face='monospace'>12</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_LOWER_NATIONAL_UNITY</code></font></td><td><font face='monospace'>7</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_LOWER_NEUTRALITY</code></font></td><td><font face='monospace'>11</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_MAX</code></font></td><td><font face='monospace'>14</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_MILITARY</code></font></td><td><font face='monospace'>2</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_NONE</code></font></td><td><font face='monospace'>0</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_POLITICAL</code></font></td><td><font face='monospace'>4</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_RAISE_NATIONAL_UNITY</code></font></td><td><font face='monospace'>13</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_SUPPORT_RESISTANCE</code></font></td><td><font face='monospace'>8</font></td><td></td></tr>
<tr><td><font face='monospace'><code>SpyMission.SPYMISSION_TECH</code></font></td><td><font face='monospace'>3</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>


---

## SubUnitList ##
Implements <font color='grey'><em><a href='#CList.md'>CList</a></em></font>, <font color='grey'><em><a href='#Hoi3Object.md'>Hoi3Object</a></em></font>, <font color='grey'><em><a href='#Object.md'>Object</a></em></font>

#### Constructor summary ####
```lua
SubUnitList()```


#### Method summary ####
<table width='100%' border='1'>
<tr><th>Type</th><th>Method</th><th>Since</th></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>GetSize</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>unknown</font></td><td><font face='monospace'><code>IsEmpty</code>(unknown)</font></td><td></td></tr>
<tr><td><font face='monospace'>static unknown</font></td><td><font face='monospace'><code>RemoveAll</code>(unknown)</font></td><td></td></tr>
</table>
<font size='2'><a href='#Hearts_of_Iron_III_-_LUA_class_reference.md'>Back To Top</a></font>