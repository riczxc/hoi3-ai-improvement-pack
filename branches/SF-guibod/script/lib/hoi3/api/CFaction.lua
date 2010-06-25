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
function CFaction:GetFactionLeader()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetFactionLeader'
	)
end

--- Faction leader is random faction member
function CFaction:GetFactionLeaderImpl()
	hoi3.assertNonStatic(self)
	
	math.randomseed(os.time)
	local members = self:GetMembers()
	local j = math.random(#members)
	for i, v in pairs(members) do
		if i == j then
			return v
		end
	end
end

---
-- @since 1.3
-- @return CIdeologyGroup
function CFaction:GetIdeologyGroup()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		'CIdeologyGroup',
		'GetIdeologyGroup'
	)
end

---
-- @since 1.3
-- @return table<CCountryTag>
function CFaction:GetMembers()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		'table<CCountryTag>',
		'GetMembers'
	)
end

---
-- @since 1.3
-- @return CFixedPoint
function CFaction:GetNormalizedProgress()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		'CFixedPoint',
		'GetNormalizedProgress'
	)
end

---
-- @since 1.3
-- @derived CFaction:GetMembers()
-- @return number
function CFaction:GetNumberOfMembers()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		number,
		'GetNumberOfMembers'
	)
end

function CFaction:GetNumberOfMembersImpl()
	hoi3.assertNonStatic(self)
	
	return #self:GetMembers()
end

---
-- @since 1.3
-- @return unknown
function CFaction:GetProgress(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @return bool
function CFaction:IsValid()
	hoi3.assertNonStatic(self)
	
	return self:loadResultOrImplOrRandom(
		hoi3.TYPE_BOOLEAN,
		'IsValid'
	)
end

-- A random CFaction is a random EXISTING factiojn !
function CFaction.random()
	return randomTableMember(CFaction:getInstances())
end