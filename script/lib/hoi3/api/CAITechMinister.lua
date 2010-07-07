require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAITechMinister = CAIAgent:subclass('hoi3.api.CAITechMinister')

-- Same constructor
CAITechMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @param CTechnology tech
-- @return bool
hoi3.f(CAITechMinister, 'CanResearch', hoi3.TYPE_BOOLEAN, 'CTechnology')

---
-- @since 1.3
-- @return CArrayFloat
hoi3.f(CAITechMinister, 'GetFolderModifers','CArrayFloat')

---
-- @since 1.3
-- @return CArrayFloat
hoi3.f(CAITechMinister, 'GetTechModifers','CArrayFloat')