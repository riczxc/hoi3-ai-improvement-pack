require('hoi3')

module("hoi3.api", package.seeall)

CTradeRoute = hoi3.Hoi3Object:subclass('hoi3.CTradeRoute')


---
-- @since 1.3
-- @return CCountryTag 
hoi3.f(CTradeRoute, 'GetConvoyResponsible', false, 'CCountryTag')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CTradeRoute, 'GetFrom', false, 'CCountryTag')

---
-- @since 1.3
-- @return unknown
hoi3.f(CTradeRoute, 'GetCost', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown
hoi3.f(CTradeRoute, 'GetLastInactive', false, hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CTradeRoute, 'GetTo', false, 'CCountryTag')

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint
hoi3.f(CTradeRoute, 'GetTradedFromOf', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
hoi3.f(CTradeRoute, 'GetTradedToOf', false, 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return bool 
hoi3.f(CTradeRoute, 'IsInactive', false, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CTradeRoute, 'IsValid', false, hoi3.TYPE_BOOLEAN)

function CTradeRoute.random()
	return CTradeRoute()
end
