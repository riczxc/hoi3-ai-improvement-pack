require('hoi3')

module("hoi3.api", package.seeall)

CFaction = hoi3.MultitonObject:subclass('hoi3.api.CFaction')

function CFaction:initialize(name)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, name, hoi3.TYPE_STRING)
	
	self.name = name
	self.members = {}
end 

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CFaction, 'GetTag', 'CCountryTag')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CFaction, 'GetFactionLeader', 'CCountryTag')

--- Faction leader is random faction member
function CFaction:GetFactionLeaderImpl()
	return hoi3.randomTableMember(self:GetMembers())
end

---
-- @since 1.3
-- @return CIdeologyGroup
hoi3.f(CFaction, 'GetIdeologyGroup', 'CIdeologyGroup')

---
-- @since 1.3
-- @return iterator<CCountryTag>
hoi3.f(CFaction, 'GetMembers', 'iterator<CCountryTag>')

---
-- @since 1.3
-- @return CFixedPoint
hoi3.f(CFaction, 'GetNormalizedProgress', 'CFixedPoint')

---
-- @since 1.3
-- @derived CFaction:GetMembers()
-- @return number
hoi3.f(CFaction, 'GetNumberOfMembers', hoi3.TYPE_NUMBER)

function CFaction:GetNumberOfMembersImpl()
	return hoi3.countTableMember(self:GetMembers())
end

---
-- @since 1.3
-- @param unknown
-- @return unknown
hoi3.f(CFaction, 'GetProgress', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return bool
hoi3.f(CFaction, 'IsValid', hoi3.TYPE_BOOLEAN)

-- A random CFaction is a random EXISTING factiojn !
function CFaction.random()
	return hoi3.randomTableMember(CFaction:getInstances())
end