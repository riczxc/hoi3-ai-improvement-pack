require('hoi3')

module("hoi3.api", package.seeall)

CIdeology = hoi3.Hoi3Object:subclass('hoi3.CIdeology')

---
-- @since 1.3
-- @return CIdeologyGroup
hoi3.f(CIdeology, 'GetGroup', false, 'CIdeologyGroup')