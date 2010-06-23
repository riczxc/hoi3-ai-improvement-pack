require('hoi3.Hoi3Object')

module("hoi3.api", package.seeall)

CMinister = Hoi3Object:subclass('hoi3.CMinister')

---
-- @since 2.0
-- @param CGovernmentPosition position
-- @return bool
function CMinister:CanTakePosition(position)
	hoi3.assertParameterType(1, position, 'CGovernmentPosition')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CIdeology
function CMinister:GetIdeology()
	hoi3.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CPersonality
function CMinister:GetPersonality(positionIndex)
	hoi3.assertParameterType(1, positionIndex, 'number')
	
	hoi3.throwNotYetImplemented()
end