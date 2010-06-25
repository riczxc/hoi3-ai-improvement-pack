require('hoi3')

module("hoi3.api", package.seeall)

CIdeologyGroup = hoi3.MultitonObject:subclass('hoi3.CIdeologyGroup')

function CIdeologyGroup:initialize(name)
	hoi3.assertNonStatic(self)
	
	self.name = name
end

---
-- @since 1.3
-- @return CFaction
function CIdeologyGroup:GetFaction()
	hoi3.assertNonStatic(self)
	
	return CIdeologyGroup:loadResultOrImplOrRandom(
		'CFaction',
		'GetFaction'
	)
end

-- @see CFaction:GetIdeology
function CIdeologyGroup:GetFactionImpl()
	hoi3.assertNonStatic(self)
	
	for k, v in pairs(CCurrentGameState.GetFactions()) do
		if v:GetIdeology() == self then
			return v
		end
	end
end

---
-- @since 1.3
-- @return unknown
function CIdeologyGroup:GetPosition(...)
	hoi3.assertNonStatic(self)
	hoi3.throwUnknownSignature()
end

-- A random CIdeologyGroup is a random EXISTING ideology group !
function CIdeologyGroup.random()
	return randomTableMember(CIdeologyGroup:getInstances())
end