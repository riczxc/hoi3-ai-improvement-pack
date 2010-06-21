require('hoi3.api.CAIAgent')

CAITechMinister = CAIAgent:subclass('hoi3.CAITechMinister')

---
-- @since 1.3
-- @param CTechnology tech
-- @return bool
function CAITechMinister:CanResearch(tech)
	Hoi3Object.assertParameterType(1, tech, 'CTechnology')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinister:GetFolderModifers()
	Hoi3Object.throwNotYetImplemented()
end  

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinister:GetTechModifers()
	Hoi3Object.throwNotYetImplemented()
end  