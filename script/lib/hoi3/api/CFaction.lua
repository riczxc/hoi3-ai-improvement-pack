require('hoi3')

module("hoi3.api", package.seeall)

CFaction = hoi3.MultitonObject:subclass('hoi3.CFaction')

function CFaction:initialize(name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, name, hoi3.TYPE_STRING)
	
	self.name = name
	self.members = {}
end 

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CFaction, 'GetFactionLeader', false, 'CCountryTag')

--- Faction leader is random faction member
function CFaction:GetFactionLeaderImpl()
	return hoi3.randomTableMember(self:GetMembers())
end

---
-- @since 1.3
-- @return CIdeologyGroup
hoi3.f(CFaction, 'GetIdeologyGroup', false, 'CIdeologyGroup')

---
-- @since 1.3
-- @return table<CCountryTag>
hoi3.f(CFaction, 'GetMembers', false, 'table<CCountryTag>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CFaction, 'GetNormalizedProgress', false, 'CFixedPoint')

---
-- @since 1.3
-- @derived CFaction:GetMembers()
-- @return number
hoi3.f(CFaction, 'GetNumberOfMembers', false, hoi3.TYPE_NUMBER)

function CFaction:GetNumberOfMembersImpl()
	return #self:GetMembers()
end

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CFaction, 'GetProgress', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CFaction, 'IsValid', false, hoi3.TYPE_BOOLEAN)

-- A random CFaction is a random EXISTING factiojn !
function CFaction.random()
	return hoi3.randomTableMember(CFaction:getInstances())
end