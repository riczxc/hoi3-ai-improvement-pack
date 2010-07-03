require('hoi3')

module("hoi3.api", package.seeall)

CNullFaction = CFaction:subclass('hoi3.CNullFaction')

CNullFaction.new = function(theClass)
	if CNullFaction.instance == nil then
  		local instance = setmetatable({ class = theClass }, theClass.__classDict)
  		instance:initialize()
  		CNullFaction.instance = instance
  	end
  	
  	return CNullFaction.instance
end

function CNullFaction:initialize()
	hoi3.assertNonStatic(self)
end 

---
-- @since 1.3
-- @return CNullTag
hoi3.f(CNullFaction, 'GetTag', false, 'CCountryTag')

function CNullFaction:GetTagImpl()
	return CNullTag()
end

---
-- @since 1.3
-- @return void
hoi3.f(CNullFaction, 'GetFactionLeader', false, hoi3.TYPE_VOID)

--- Faction leader is random faction member
function CNullFaction:GetFactionLeaderImpl()
	return nil
end

---
-- @since 1.3
-- @return void
hoi3.f(CNullFaction, 'GetIdeologyGroup', false, hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CNullFaction, 'GetMembers', false, hoi3.TYPE_VOID)

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CNullFaction, 'GetNormalizedProgress', false, hoi3.TYPE_VOID)

---
-- @since 1.3
-- @derived CNullFaction:GetMembers()
-- @return number
hoi3.f(CNullFaction, 'GetNumberOfMembers', false, hoi3.TYPE_NUMBER)

function CNullFaction:GetNumberOfMembersImpl()
	return 0
end

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CNullFaction, 'GetProgress', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CNullFaction, 'IsValid', false, hoi3.TYPE_BOOLEAN)

function CNullFaction:IsValidImpl()
	return false
end