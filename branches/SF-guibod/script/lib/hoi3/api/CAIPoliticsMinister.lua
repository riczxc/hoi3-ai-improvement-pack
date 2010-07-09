require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIPoliticsMinister = CAIAgent:subclass('hoi3.api.CAIPoliticsMinister')

-- Same constructor
CAIPoliticsMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @return bool
hoi3.f(CAIPoliticsMinister, 'IsCapitalSafeToLiberate', hoi3.TYPE_BOOLEAN, 'CCountryTag')