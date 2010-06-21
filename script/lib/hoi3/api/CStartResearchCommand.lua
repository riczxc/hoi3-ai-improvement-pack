require('hoi3.api.CCommand')

CStartResearchCommand = CCommand:subclass('hoi3.CStartResearchCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CStartResearchCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  country
-- @param CTechnology  techno
-- @return CStartResearchCommand
function CStartResearchCommand:initialize(country, techno)
	Hoi3Object.assertParameterType(1, country, 'CCountryTag')
	Hoi3Object.assertParameterType(2, techno, 'CTechnology')

	Hoi3Object.throwNotYetImplemented()
end