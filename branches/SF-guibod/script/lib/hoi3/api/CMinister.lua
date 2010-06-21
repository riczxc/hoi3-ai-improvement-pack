require('hoi3.Hoi3Object')

CMinisterObject = Hoi3Object:subclass('hoi3.CMinisterObject')

---
-- @since 2.0
-- @param CGovernmentPosition position
-- @return bool
function CMinisterObject:CanTakePosition(position)
	Hoi3Object.assertParameterType(1, position, 'CGovernmentPosition')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @return CIdeology
function CMinisterObject:GetIdeology()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 2.0
-- @param number positionIndex
-- @return CPersonality
function CMinisterObject:GetPersonality(positionIndex)
	Hoi3Object.assertParameterType(1, positionIndex, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end