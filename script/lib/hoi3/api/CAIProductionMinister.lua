require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIProductionMinister = CAIAgent:subclass('hoi3.CAIProductionMinister')

-- Same constructor
CAIProductionMinister.initialize = CAIAgent.initalize

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountEscortsUnderConstruction()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'CountEscortsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTotalDesiredEscorts()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'CountTotalDesiredEscorts'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:CountTransportsUnderConstruction()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'CountTransportsUnderConstruction'
	)
end

---
-- @since 1.3
-- @return number
function CAIProductionMinister:GetDesperation()
	hoi3.assertNonStatic(self)
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_NUMBER,
		'GetDesperation'
	)
end

---
-- @since 1.3
-- @return void
function CAIProductionMinister:PrioritizeBuildQueue()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end
