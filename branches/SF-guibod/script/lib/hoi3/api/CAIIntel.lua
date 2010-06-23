require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CAIIntel = Hoi3Object:subclass('hoi3.CAIIntel')

---
-- @since 1.3
-- @param CCountryTag source
-- @param CCountryTag target
-- @return CAIIntel
function CAIIntel:initialize(source, target)
	hoi3.assertParameterType(1, source, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	
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
	hoi3.throwUnknownSignature()
end  

---
-- @since 1.3
-- @return unknown
function CAIIntel:GetUncertaintyFactor(...)
	hoi3.throwUnknownSignature()
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
