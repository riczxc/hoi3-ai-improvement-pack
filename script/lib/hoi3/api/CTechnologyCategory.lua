require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyCategory = hoi3.MultitonObject:subclass('hoi3.CTechnologyCategory')

function CTechnologyCategory:initialize(key)
	hoi3.assertNonStatic(self)
	if type(key) == hoi3.TYPE_STRING then key = CString(key) end
	hoi3.assertParameterType(1, key, 'CString')
	
	self.key = key
end

---
-- @since1.3 
-- @return CString
hoi3.f(CTechnologyCategory, 'GetKey', false, 'CString')

function CTechnologyCategory:GetKeyImpl()
	return self.key
end

---
-- @since 1.3 
-- @return number
hoi3.f(CTechnologyCategory, 'GetIndex', false, hoi3.TYPE_NUMBER)

function CTechnologyCategory:GetIndexImpl()
	return self:getIndexInDictionnary(CTechnologyCategory:getInstances())
end

function CTechnologyCategory.random()
	return randomTableMember(CTechnologyCategory:getInstances())
end