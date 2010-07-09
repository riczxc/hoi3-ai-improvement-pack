require('hoi3')

module("hoi3.api", package.seeall)

CBrigadeConstructionDefinition  = hoi3.MultitonObject:subclass('hoi3.api.CBrigadeConstructionDefinition ')

function CBrigadeConstructionDefinition:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3
-- @return Cstring
hoi3.f(CBrigadeConstructionDefinition, 'GetType', 'CString')

function CBrigadeConstructionDefinition:GetTypeImpl()
	return CString(self.key)
end

function CBrigadeConstructionDefinition.random()
	return hoi3.randomTableMember(CBrigadeConstructionDefinition:getInstances())
end
