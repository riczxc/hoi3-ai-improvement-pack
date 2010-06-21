require('hoi3.api.CCommand')

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
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		Hoi3Object.assertParameterType(i+2, v, 'CFixedPoint')
	end

	Hoi3Object.throwNotYetImplemented()
end