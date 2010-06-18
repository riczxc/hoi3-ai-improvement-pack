require('hoi3.Hoi3Object')

CAITechMinisterObject = Hoi3Object:subclass('hoi3.CAIAgent')

---
-- @since 1.3
-- @param CTechnology tech
-- @return bool
function CAITechMinisterObject:CanResearch(tech)
	Hoi3Object.assertParameterType(1, tech, 'CTechnology')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinisterObject:GetFolderModifers()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinisterObject:GetTechModifers()
	Hoi3Object.throwNotYetImplemented()
end  