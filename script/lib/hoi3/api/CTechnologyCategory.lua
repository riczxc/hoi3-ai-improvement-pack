require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyCategory = hoi3.MultitonObject:subclass('hoi3.api.CTechnologyCategory')

function CTechnologyCategory:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since1.3 
-- @return CString
hoi3.f(CTechnologyCategory, 'GetKey', 'CString')

function CTechnologyCategory:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 1.3 
-- @return number
hoi3.f(CTechnologyCategory, 'GetIndex', hoi3.TYPE_NUMBER)

function CTechnologyCategory:GetIndexImpl()
	return self:getIndexInDictionnary(CTechnologyCategory:getInstances())
end

function CTechnologyCategory.random()
	return hoi3.randomTableMember(CTechnologyCategory:getInstances())
end