require('hoi3.api.CCommand')

CCancelUnitConstructionCommand = CCommand:subclass('hoi3.CCancelUnitConstructionCommand')

---
-- @since 1.3
-- @param CCountryTag countryTag
-- @param CID cID
-- @return CCancelUnitConstructionCommand
function CCancelUnitConstructionCommand:initialize(countryTag, cID)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, cID, 'CID')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCancelUnitConstructionCommand 
function CCancelUnitConstructionCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

