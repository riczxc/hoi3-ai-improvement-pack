require('hoi3')

module("hoi3.api", package.seeall)

CIdeologyGroup = hoi3.MultitonObject:subclass('hoi3.api.CIdeologyGroup')

function CIdeologyGroup:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return CString
hoi3.f(CIdeologyGroup, 'GetKey', 'CString')

function CIdeologyGroup:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 1.3
-- @return CFaction
hoi3.f(CIdeologyGroup, 'GetFaction', 'CFaction')

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
hoi3.f(CIdeologyGroup, 'GetPosition', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

-- A random CIdeologyGroup is a random EXISTING ideology group !
function CIdeologyGroup.random()
	return hoi3.randomTableMember(CIdeologyGroup:getInstances())
end