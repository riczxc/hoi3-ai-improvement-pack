require('hoi3.Hoi3Object')

CAIIntelObject = Hoi3Object:subclass('hoi3.CAIIntelObject')

---
-- @since 1.3
-- @return number 
function CAIIntelObject:CalculateOurMilitaryStrength()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return number
function CAIIntelObject:CalculateTheirPercievedMilitaryStrengh()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return number
function CAIIntelObject:GetFactor()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return unknown
function CAIIntelObject:GetTheirFactor(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIIntelObject:GetUncertaintyFactor(...)
	Hoi3Object.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return bool
function CAIIntelObject:HasNoIntel()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @param CCountryTag source
-- @param CCountryTag target
-- @return CAIIntel
function CAIIntel(source, target)
	Hoi3Object.assertParameterType(1, source, 'CCountryTag')
	Hoi3Object.assertParameterType(2, target, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end