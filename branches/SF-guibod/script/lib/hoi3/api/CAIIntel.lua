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
	
	self.source = source
	self.target = target
end

---
-- @since 1.3
-- @return number 
function CAIIntel:CalculateOurMilitaryStrength()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CalculateOurMilitaryStrength'
	)
end

---
-- @since 1.3
-- @return number
function CAIIntel:CalculateTheirPercievedMilitaryStrengh()
	return self:loadResultOrFakeOrRandom(
		'number',
		'CalculateTheirPercievedMilitaryStrengh'
	)
end  

---
-- @since 1.3
-- @return number
function CAIIntel:GetFactor()
	return self:loadResultOrFakeOrRandom(
		'number',
		'GetFactor'
	)
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
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'GetFactor'
	)
end  
