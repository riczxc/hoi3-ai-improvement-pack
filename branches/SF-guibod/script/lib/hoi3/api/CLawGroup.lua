require('hoi3')

module("hoi3.api", package.seeall)

CLawGroup = hoi3.Hoi3Object:subclass('hoi3.CLawGroup')

---
-- @since 1.3
-- @return number
hoi3.f(CLawGroup, 'GetIndex', false, hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return string
hoi3.f(CLawGroup, 'GetKey', false, hoi3.TYPE_STRING)

---
-- @since 1.3
-- @return bool
hoi3.f(CLawGroup, 'IsValid', false, hoi3.TYPE_BOOLEAN)