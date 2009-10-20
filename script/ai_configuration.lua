ai_configuration = {
MINIMUM_MONEY_STOCKPILE = 5,
DIP_PEACE_DELAY = 14,
LEADERSHIP_TO_INFLUENCE = 0.15,
MINIMUM_SUPPLY_STOCKPILE = 50, -- Don't go under 50 because there's PI supply bug*
DIP_WAR_DELAY = 7,
USE_RESEARCH_MOD = 1,
POLITICS_DELAY = 7,
MINIMUM_STOCKPILE = 50,
COUNTER_INFLUENCE = 1,
TRADE_DELAY = 10,
MINIMUM_IC_TO_INFLUENCE = 20,
INTELLIGENCE_DELAY = 7,
USE_CUSTOM_TRIGGERS = 0
}

--[[
* If for example as Romania the supply stockpile drops to zero the throughput in
  the capital province will never come up and stay at around 50 -> half army
  will be out of supply and the supply need will also drop to zero for some
  other buggy reason...
]]
