require('hoi3.api.CCommand')

CCancelUnitConstructionCommandObject = CCommandObject:subclass('hoi3.CCancelUnitConstructionCommandObject')

---
-- @since 1.3
-- @return CCancelUnitConstructionCommandObject 
function CCancelUnitConstructionCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param CID cID
-- @return CCancelUnitConstructionCommandObject
function CCancelUnitConstructionCommand(countryTag, cID)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, cID, 'CID')

	Hoi3Object.throwNotYetImplemented()
end