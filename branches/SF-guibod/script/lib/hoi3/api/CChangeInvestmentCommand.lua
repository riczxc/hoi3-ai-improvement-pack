require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

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
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	for i,v in ipairs(...) do
		hoi3.assertParameterType(i+2, v, 'CFixedPoint')
	end

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CChangeInvestmentCommand:Clone()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

