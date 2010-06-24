require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeLeadershipCommand = CCommand:subclass('hoi3.CChangeLeadershipCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint ...
-- @return CChangeInvestmentCommand
function CChangeLeadershipCommand:initialize(actor, ...)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		hoi3.assertParameterType(i+2, v, 'CFixedPoint')
	end

	hoi3.throwNotYetImplemented()
end