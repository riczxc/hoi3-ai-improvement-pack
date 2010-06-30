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
hoi3.f(CIdeologyGroup, 'GetFaction', false, 'CFaction')

-- @see CFaction:GetIdeology
function CIdeologyGroup:GetFactionImpl()
	for k, v in pairs(CCurrentGameState.GetFactions()) do
		if v:GetIdeology() == self then
			return v
		end
	end
end

---
-- @since 1.3
-- @return unknown
hoi3.f(CIdeologyGroup, 'GetPosition', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

-- A random CIdeologyGroup is a random EXISTING ideology group !
function CIdeologyGroup.random()
	return hoi3.randomTableMember(CIdeologyGroup:getInstances())
end