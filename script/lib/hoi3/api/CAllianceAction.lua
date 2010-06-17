require('hoi3.Hoi3Object')

CAllianceActionObject = Hoi3Object:subclass('hoi3.CDiplomaticAction')

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