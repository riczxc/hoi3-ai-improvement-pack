require('hoi3')

module("hoi3.api", package.seeall)

CPersonality = hoi3.Hoi3Object:subclass('hoi3.CPersonality')

---
-- @since 2.0
-- @return CString
hoi3.f(CPersonality, 'GetKey', false, 'CString')

---
-- @since 2.0
-- @return number
hoi3.f(CPersonality, 'GetIndex', false, hoi3.TYPE_NUMBER)