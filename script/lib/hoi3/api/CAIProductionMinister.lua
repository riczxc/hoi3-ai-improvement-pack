require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIProductionMinister = CAIAgent:subclass('hoi3.CAIProductionMinister')

-- Same constructor
CAIProductionMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @return number
hoi3.f(CAIProductionMinister, 'CountEscortsUnderConstruction', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CAIProductionMinister, 'CountTotalDesiredEscorts', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CAIProductionMinister, 'CountTransportsUnderConstruction', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CAIProductionMinister, 'GetDesperation', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return void
hoi3.f(CAIProductionMinister, 'PrioritizeBuildQueue', false, hoi3.TYPE_VOID)
