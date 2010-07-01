require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

CTradeAction = CDiplomaticAction:subclass('hoi3.CTradeAction')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return CTradeAction
function CTradeAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

---
-- @since 1.3
-- @return CTradeRoute 
hoi3.f(CTradeAction, 'GetRoute', true, 'CTradeRoute')

---
-- @since 1.3
-- @param number goodsType
-- @param CCountryTag  ministerTag
-- @return CFixedPoint 
hoi3.f(CTradeAction, 'GetTrading', true, 'CFixedPoint', hoi3.TYPE_NUMBER, 'CCountryTag')

---
-- @since 1.3
-- @return bool 
hoi3.f(CTradeAction, 'IsConvoyPossible', true, hoi3.TYPE_BOOLEAN)

---
-- @since 1.3
-- @param CTradeRoute  route
-- @return void 
hoi3.f(CTradeAction, 'SetRoute', true, hoi3.TYPE_VOID, 'CTradeRoute')

---
-- @since 1.3
-- @param CFixedPoint  amount
-- @param number goodsType
-- @return void 
hoi3.f(CTradeAction, 'SetTrading', true, hoi3.TYPE_VOID, 'CFixedPoint', hoi3.TYPE_NUMBER)

function CTradeAction:desc()
	return tostring(self.tag).." propose trade with "..tostring(self.target).. "."
end

