require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAITechMinister = CAIAgent:subclass('hoi3.CAITechMinister')

---
-- @since 1.3
-- @param CTechnology tech
-- @return bool
function CAITechMinister:CanResearch(tech)
	hoi3.assertParameterType(1, tech, 'CTechnology')
	
	return self:loadResultOrFakeOrRandom(
		'boolean',
		'CanResearch',
		tech
	)
end

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinister:GetFolderModifers()
	return self:loadResultOrFakeOrRandom(
		'CArrayFix',
		'GetFolderModifers'
	)
end  

---
-- @since 1.3
-- @return CArrayFix
function CAITechMinister:GetTechModifers()
	return self:loadResultOrFakeOrRandom(
		'CArrayFix',
		'GetTechModifers'
	)
end  