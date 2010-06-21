require('hoi3.Hoi3Object')

CTradeRoute = Hoi3Object:subclass('hoi3.CTradeRoute')


---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetConvoyResponsible()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetFrom()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CTradeRoute:GetCost(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return unknown
function CTradeRoute:GetLastInactive(...)
	Hoi3Object.throwUnknownSignature()
	Hoi3Object.throwUnknownReturnType()
end

---
-- @since 1.3
-- @return CCountryTag 
function CTradeRoute:GetTo()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRoute:GetTradedFromOf(goodsType)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @return CFixedPoint 
function CTradeRoute:GetTradedToOf(goodsType)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRoute:IsInactive()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CTradeRoute:IsValid()
	Hoi3Object.throwNotYetImplemented()
end
