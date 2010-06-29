require('hoi3')

module("hoi3.api", package.seeall)

CTechnologyCategory = hoi3.Hoi3Object:subclass('hoi3.CTechnologyCategory')

---
-- @since1.3 
-- @return CString
hoi3.f(CTechnology, 'GetKey', false, 'CString')

---
-- @since 1.3 
-- @return number
hoi3.f(CTechnology, 'GetIndex', false, hoi3.TYPE_NUMBER)