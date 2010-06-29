require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyFolder = hoi3.Hoi3Object:subclass('hoi3.CTechnologyFolder')

---
-- @since 1.3 
-- @return number
hoi3.f(CTechnology, 'GetIndex', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3 
-- @return CString
hoi3.f(CTechnology, 'GetKey', false, 'CString')

---
-- @since 1.3 
-- @return bool
hoi3.f(CTechnology, 'IsValid', false, hoi3.TYPE_BOOLEAN)