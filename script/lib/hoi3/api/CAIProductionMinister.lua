require('hoi3.api.CAIAgent')

CAIProductionMinister = CAIAgent:subclass('hoi3.CAIProductionMinister')

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountEscortsUnderConstruction()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CountEscortsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTotalDesiredEscorts()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CountTotalDesiredEscorts'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTransportsUnderConstruction()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CountTransportsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:GetDesperation()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetDesperation'
	)
end

---
-- @since 1.3
-- @return void
function CAIProductionMinister:PrioritizeBuildQueue()
	Hoi3Object.throwNotYetImplemented()
end
