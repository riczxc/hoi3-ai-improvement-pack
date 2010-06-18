require('hoi3.Hoi3Object')

CAlignmentObject = Hoi3Object:subclass('hoi3.CAlignmentObject')

---
-- @since 1.3
-- @param CIdeologyGroup ideologyGroup
-- @return number 
function CAlignmentObject:GetLastDrift(ideologyGroup)
	Hoi3Object.assertParameterType(1, ideologyGroup, 'CIdeologyGroup')
	
	return self:genRandomNumber() 
end

---
-- @since 1.3
-- @return unknown
function CAlignmentObject:GetDistanceFrom()
	Hoi3Object.throwUnknownReturnType()
end