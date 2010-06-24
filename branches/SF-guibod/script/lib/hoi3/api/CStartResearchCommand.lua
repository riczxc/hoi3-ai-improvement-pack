require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CStartResearchCommand = CCommand:subclass('hoi3.CStartResearchCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CStartResearchCommand:Clone()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  country
-- @param CTechnology  techno
-- @return CStartResearchCommand
function CStartResearchCommand:initialize(country, techno)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, country, 'CCountryTag')
	hoi3.assertParameterType(2, techno, 'CTechnology')

	hoi3.throwNotYetImplemented()
end