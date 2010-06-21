require('hoi3.api.CCommand')

CStartResearchCommandObject = CCommandObject:subclass('hoi3.CStartResearchCommandObject')

---
-- @since 1.3
-- @return CChangeInvestmentCommandObject 
function CStartResearchCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  country
-- @param CTechnology  techno
-- @return CStartResearchCommandObject
function CStartResearchCommand(country, techno)
	Hoi3Object.assertParameterType(1, country, 'CCountryTag')
	Hoi3Object.assertParameterType(2, techno, 'CTechnology')

	Hoi3Object.throwNotYetImplemented()
end