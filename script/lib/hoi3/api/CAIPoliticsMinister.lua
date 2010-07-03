require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIPoliticsMinister = CAIAgent:subclass('hoi3.CAIPoliticsMinister')

-- Same constructor
CAIPoliticsMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CAIPoliticsMinister, 'IsCapitalSafeToLiberate', false, hoi3.TYPE_BOOLEAN, 'CCountryTag')

---
-- @since 2.0
-- @return iterator<CMinister>
hoi3.f(CAIPoliticsMinister, 'GetPossibleMinisters', false, 'iterator<CMinister>')
