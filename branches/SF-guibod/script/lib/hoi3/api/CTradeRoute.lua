require('hoi3')

module("hoi3.api", package.seeall)

CTradeRoute = hoi3.Hoi3Object:subclass('hoi3.api.CTradeRoute')


---
-- @since 1.3
-- @return CCountryTag 
hoi3.f(CTradeRoute, 'GetConvoyResponsible', 'CCountryTag')

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CTradeRoute, 'GetFrom', 'CCountryTag')

---
-- @since 1.3
-- @return unknown
hoi3.f(CTradeRoute, 'GetCost', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return unknown
hoi3.f(CTradeRoute, 'GetLastInactive', hoi3.TYPE_UNKNOWN, hoi3.TYPE_UNKNOWN)

---
-- @since 1.3
-- @return CCountryTag
hoi3.f(CTradeRoute, 'GetTo', 'CCountryTag')

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint
hoi3.f(CTradeRoute, 'GetTradedFromOf', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
hoi3.f(CTradeRoute, 'GetTradedToOf', 'CFixedPoint', hoi3.TYPE_NUMBER)

---
-- @since 1.3
-- @return bool 
hoi3.f(CTradeRoute, 'IsInactive', hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @return bool
hoi3.f(CTradeRoute, 'IsValid', hoi3.TYPE_BOOLEAN)

function CTradeRoute.random()
	return CTradeRoute()
end
