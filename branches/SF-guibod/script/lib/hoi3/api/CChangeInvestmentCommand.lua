require('hoi3.api.CCommand')

CChangeInvestmentCommandObject = CCommandObject:subclass('hoi3.CChangeInvestmentCommandObject')

---
-- @since 1.3
-- @return CChangeInvestmentCommandObject 
function CChangeInvestmentCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint ...
-- @return CChangeInvestmentCommandObject
function CChangeInvestmentCommand(actor, ...)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		Hoi3Object.assertParameterType(i+2, v, 'CFixedPoint')
	end

	Hoi3Object.throwNotYetImplemented()
end