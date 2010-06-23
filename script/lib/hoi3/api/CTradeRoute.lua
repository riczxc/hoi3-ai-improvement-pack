require('hoi3')

module("hoi3.api", package.seeall)

CTradeRoute = hoi3.Hoi3Object:subclass('hoi3.CTradeRoute')


---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetConvoyResponsible()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetFrom()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CTradeRoute:GetCost(...)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return unknown
function CTradeRoute:GetLastInactive(...)
	hoi3.throwUnknownSignature()
	hoi3.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetTo()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRoute:GetTradedFromOf(goodsType)
	hoi3.assertParameterType(1, goodsType, hoi3.TYPE_NUMBER)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRoute:GetTradedToOf(goodsType)
	hoi3.assertParameterType(1, goodsType, hoi3.TYPE_NUMBER)
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRoute:IsInactive()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRoute:IsValid()
	hoi3.throwNotYetImplemented()
end
