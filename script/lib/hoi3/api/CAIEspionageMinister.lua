require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIEspionageMinister = CAIAgent:subclass('hoi3.api.CAIEspionageMinister')

-- Same constructor
CAIEspionageMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @return bool
hoi3.f(CAIEspionageMinister, 'IsAligningToFaction', hoi3.TYPE_BOOLEAN)