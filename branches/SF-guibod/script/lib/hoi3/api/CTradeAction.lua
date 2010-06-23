require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CTradeAction = CDiplomaticAction:subclass('hoi3.CTradeAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CTradeAction
function CTradeAction:initialize(countryTagA, countryTagB)
	hoi3.assertParameterType(1, countryTagA, 'CCountryTag')
	hoi3.assertParameterType(2, countryTagB, 'CCountryTag')

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTradeRoute 
function CSpyPresence:GetRoute()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTradeRoute 
function CSpyPresence:GetRoute()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag  ministerTag
-- @return CFixedPoint 
function CSpyPresence:GetTrading(goodsType, ministerTag)
	hoi3.assertParameterType(1, goodsType, 'number')
	hoi3.assertParameterType(2, ministerTag, 'CCountryTag')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CSpyPresence:IsConvoyPossible()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTradeRoute  route
-- @return void 
function CSpyPresence:SetRoute(route)
	hoi3.assertParameterType(1, route, 'CTradeRoute')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFixedPoint  amount
-- @param number goodsType
-- @return void 
function CSpyPresence:SetTrading(amount, goodsType)
	hoi3.assertParameterType(1, amount, 'CFixedPoint')
	hoi3.assertParameterType(1, goodsType, 'number')
	
	hoi3.throwNotYetImplemented()
end

