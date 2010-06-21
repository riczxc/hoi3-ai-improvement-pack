require('hoi3.Hoi3Object')

CTradeRouteObject = Hoi3Object:subclass('hoi3.CTradeRouteObject')


---
-- @since 1.3
-- @return CCountryTag 
function CTradeRouteObject:GetConvoyResponsible()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRouteObject:GetFrom()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CTradeRouteObject:GetCost(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return unknown
function CTradeRouteObject:GetLastInactive(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRouteObject:GetTo()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRouteObject:GetTradedFromOf(goodsType)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRouteObject:GetTradedToOf(goodsType)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRouteObject:IsInactive()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRouteObject:IsValid()
	Hoi3Object.throwNotYetImplemented()
end
