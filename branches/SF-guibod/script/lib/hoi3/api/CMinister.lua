require('hoi3')

module("hoi3.api", package.seeall)

CMinister = hoi3.Hoi3Object:subclass('hoi3.CMinister')

---
-- @since 2.0
-- @param CGovernmentPosition position
-- @return bool
hoi3.f(CMinister, 'CanTakePosition', hoi3.TYPE_BOOLEAN, 'CGovernmentPosition')

---
-- @since 2.0
-- @return CIdeology
hoi3.f(CMinister, 'GetIdeology', 'CIdeology')

---
-- @since 2.0
-- @param number positionIndex
-- @return CPersonality
hoi3.f(CMinister, 'GetPersonality', 'CPersonality', 'CGovernmentPosition')

function CMinister.random()
	return CMinister()
end