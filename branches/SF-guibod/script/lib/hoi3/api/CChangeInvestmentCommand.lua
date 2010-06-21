require('hoi3.api.CCommand')

CChangeInvestmentCommand = CCommand:subclass('hoi3.CChangeInvestmentCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint ...
-- @return CChangeInvestmentCommand
function CChangeInvestmentCommand:initialize(actor, ...)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		Hoi3Object.assertParameterType(i+2, v, 'CFixedPoint')
	end

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CChangeInvestmentCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

