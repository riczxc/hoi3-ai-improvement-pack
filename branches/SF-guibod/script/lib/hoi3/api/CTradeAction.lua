require('hoi3.api.CDiplomaticAction')

CTradeAction = CDiplomaticAction:subclass('hoi3.CTradeAction')

---
-- @since 1.3
-- @param CCountryTag countryTagA
-- @param CCountryTag countryTagB
-- @return CTradeAction
function CTradeAction:initialize(countryTagA, countryTagB)
	Hoi3Object.assertParameterType(1, countryTagA, 'CCountryTag')
	Hoi3Object.assertParameterType(2, countryTagB, 'CCountryTag')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTradeRoute 
function CSpyPresence:GetRoute()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CTradeRoute 
function CSpyPresence:GetRoute()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag  ministerTag
-- @return CFixedPoint 
function CSpyPresence:GetTrading(goodsType, ministerTag)
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	Hoi3Object.assertParameterType(2, ministerTag, 'CCountryTag')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return bool 
function CSpyPresence:IsConvoyPossible()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CTradeRoute  route
-- @return void 
function CSpyPresence:SetRoute(route)
	Hoi3Object.assertParameterType(1, route, 'CTradeRoute')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CFixedPoint  amount
-- @param number goodsType
-- @return void 
function CSpyPresence:SetTrading(amount, goodsType)
	Hoi3Object.assertParameterType(1, amount, 'CFixedPoint')
	Hoi3Object.assertParameterType(1, goodsType, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

