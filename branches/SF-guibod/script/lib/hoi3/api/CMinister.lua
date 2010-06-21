require('hoi3.Hoi3Object')

CMinister = Hoi3Object:subclass('hoi3.CMinister')

---
-- @since 2.0
-- @param CGovernmentPosition position
-- @return bool
function CMinister:CanTakePosition(position)
	Hoi3Object.assertParameterType(1, position, 'CGovernmentPosition')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CIdeology
function CMinister:GetIdeology()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CPersonality
function CMinister:GetPersonality(positionIndex)
	Hoi3Object.assertParameterType(1, positionIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end