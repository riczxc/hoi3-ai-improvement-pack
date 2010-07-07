require('hoi3')

module("hoi3.api", package.seeall)

CAIIntel = hoi3.Hoi3Object:subclass('hoi3.api.CAIIntel')

---
-- @since 1.3
-- @param CCountryTag source
-- @param CCountryTag target
-- @return CAIIntel
function CAIIntel:initialize(source, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, source, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	
	self.source = source
	self.target = target
end

---
-- @since 1.3
-- @return number 
hoi3.f(CAIIntel, 'CalculateOurMilitaryStrength', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CAIIntel, 'CalculateTheirPercievedMilitaryStrengh', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return number
hoi3.f(CAIIntel, 'GetFactor', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return unknown
hoi3.f(CAIIntel, 'GetTheirFactor', hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CAIIntel, 'GetUncertaintyFactor', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CAIIntel, 'HasNoIntel', hoi3.TYPE_BOOLEAN)