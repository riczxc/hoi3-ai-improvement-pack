require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIForeignMinister = CAIAgent:subclass('hoi3.CAIForeignMinister')

-- Same constructor
CAIForeignMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @return void
hoi3.f(CAIForeignMinister, 'ClearWarProposal', false, hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return void
hoi3.f(CAIForeignMinister, 'ExecuteDiploDecisions', false, hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CAIForeignMinister, 'GetProposedWarTarget', false, 'CCountryTag')

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIForeignMinister, 'PercOccupied', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param CDiplomaticAction  action
-- @param number score
-- @return void
hoi3.f(CAIForeignMinister, 'Propose', false, hoi3.TYPE_VOID, 'CDiplomaticAction', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param number warDesirability
-- @return void
hoi3.f(CAIForeignMinister, 'ProposeWar', false, hoi3.TYPE_VOID, 'CCountryTag', hoi3.TYPE_NUMBER)
