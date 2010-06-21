require('hoi3.Hoi3Object')

CAIIntel = Hoi3Object:subclass('hoi3.CAIIntel')

---
-- @since 1.3
-- @param CCountryTag source
-- @param CCountryTag target
-- @return CAIIntel
function CAIIntel:initialize(source, target)
	Hoi3Object.assertParameterType(1, source, 'CCountryTag')
	Hoi3Object.assertParameterType(2, target, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number 
function CAIIntel:CalculateOurMilitaryStrength()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CAIIntel:CalculateTheirPercievedMilitaryStrengh()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return number
function CAIIntel:GetFactor()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIIntel:GetTheirFactor(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIIntel:GetUncertaintyFactor(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return bool
function CAIIntel:HasNoIntel()
	Hoi3Object.throwNotYetImplemented()
end  
