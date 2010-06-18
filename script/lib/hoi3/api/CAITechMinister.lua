require('hoi3.api.CAIAgent')

CAITechMinisterObject = CAIAgentObject:subclass('hoi3.CAITechMinisterObject')

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