require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIProductionMinister = CAIAgent:subclass('hoi3.CAIProductionMinister')

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountEscortsUnderConstruction()
	return self:loadResultOrImplOrRandom(
		'number',
		'CountEscortsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTotalDesiredEscorts()
	return self:loadResultOrImplOrRandom(
		'number',
		'CountTotalDesiredEscorts'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTransportsUnderConstruction()
	return self:loadResultOrImplOrRandom(
		'number',
		'CountTransportsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:GetDesperation()
	return self:loadResultOrImplOrRandom(
		'number',
		'GetDesperation'
	)
end

---
-- @since 1.3
-- @return void
function CAIProductionMinister:PrioritizeBuildQueue()
	hoi3.throwNotYetImplemented()
end
