require('hoi3')

module("hoi3.api", package.seeall)

CBrigade = hoi3.Hoi3Object:subclass('hoi3.CBrigade')

---
-- @since 1.3
-- @return CSubUnitDefinition
hoi3.f(CBrigade, 'GetType', false, 'CSubUnitDefinition')


function CBrigade.random()
	return CBrigade()
end