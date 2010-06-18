require('hoi3.Hoi3Object')

CChangeLeadershipCommandObject = Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint ...
-- @return CChangeInvestmentCommandObject
function CChangeLeadershipCommand(actor, ...)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		Hoi3Object.assertParameterType(i+2, v, 'CFixedPoint')
	end

	Hoi3Object.throwNotYetImplemented()
end