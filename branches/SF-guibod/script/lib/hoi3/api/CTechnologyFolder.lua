require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyFolder = hoi3.MultitonObject:subclass('hoi3.api.CTechnologyFolder')

function CTechnologyFolder:initialize(key)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, key, hoi3.TYPE_STRING)
	
	self.key = key
end

---
-- @since 1.3 
-- @return number
hoi3.f(CTechnologyFolder, 'GetIndex', hoi3.TYPE_NUMBER)

function CTechnologyFolder:GetIndexImpl()
	return self:getIndexInDictionnary(CTechnologyFolder:getInstances())
end

---
-- @since 1.3 
-- @return CString
hoi3.f(CTechnologyFolder, 'GetKey', 'CString')

function CTechnologyCategory:GetKeyImpl()
	return CString(self.key)
end

---
-- @since 1.3 
-- @return bool
hoi3.f(CTechnologyFolder, 'IsValid', hoi3.RAND_BOOL_VLIKELY)

function CTechnologyFolder.random()
	return hoi3.randomTableMember(CTechnologyFolder:getInstances())
end