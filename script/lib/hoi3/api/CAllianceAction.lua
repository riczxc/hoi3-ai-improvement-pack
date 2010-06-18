require('hoi3.api.CDiplomaticAction')

CAllianceActionObject = CDiplomaticActionObject:subclass('hoi3.CAllianceActionObject')

---
-- @since 1.3
-- @return unknown 
function CAllianceActionObject.Create()
	Hoi3Object.throwUnknownReturnType()
end 

---
-- @since 1.3
-- @return CAllianceActionObject
function CAllianceAction(countryTagA,  countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end