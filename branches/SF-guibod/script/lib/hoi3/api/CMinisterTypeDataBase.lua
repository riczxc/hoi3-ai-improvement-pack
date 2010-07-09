require('hoi3')

module("hoi3.api", package.seeall)

CMinisterTypeDataBase = hoi3.AbstractObject:subclass('hoi3.api.CMinisterTypeDataBase')

---
-- @since 2.0
-- @return number
hoi3.fs(CMinisterTypeDataBase, 'GetMinisterType', 'CMinisterType', hoi3.TYPE_STRING)

function CMinisterTypeDataBase.GetMinisterTypeImpl(key)	
	return CMinisterType.getInstance(key)
end


---
-- @since 2.0
-- @return iterator<CMinisterType>
hoi3.fs(CMinisterTypeDataBase, 'GetMinisterTypeList', 'iterator<CMinisterType>')

function CMinisterTypeDataBase.GetMinisterTypeListImpl()	
	return CMinisterType:getInstances()
end

---
-- @since 1.3
-- @return number
hoi3.fs(CMinisterTypeDataBase, 'GetNumberOfMinisterTypes', hoi3.TYPE_NUMBER)

function CMinisterTypeDataBase.GetNumberOfMinisterTypesImpl()	
	return hoi3.countIteratorMember(CMinisterTypeDataBase.GetMinisterTypeList())
end