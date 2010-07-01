require('hoi3')

module("hoi3.api", package.seeall)

CResourceValues = hoi3.Hoi3Object:subclass('hoi3.CResourceValues')

---
-- @since 2.0
-- @param CCountry
-- @param number goodstype
-- @return table 
hoi3.f(CResourceValues, 'GetResourceValues', false, hoi3.TYPE_TABLE, 'CCountry', hoi3.TYPE_NUMBER)

function CResourceValues:GetResourceValuesImpl(country, goodtype)
	local res = {}
	res.vDailyBalance = country:GetDailyBalance(goodtype):Get()
	
	print("CResourceValues:GetResourceValuesImpl")
	print(country)
	print(goodtype)
	print(country:GetDailyExpense(goodtype))
	print(country:GetDailyExpense(goodtype):Get())
	res.vDailyExpense = country:GetDailyExpense(goodtype):Get()
	print(res.vDailyExpense)
	
	res.vDailyHome = country:GetHomeProduced():Get(goodtype):Get()
	res.vDailyIncome = country:GetDailyIncome(goodtype):Get()
	res.vPool = country:GetPool():Get(goodtype):Get()
	res.vConvoyedIn = country:GetConvoyedIn():Get(goodtype):Get()
	res.vConvoyedOut = country:GetConvoyedOut():Get(goodtype):Get()
	
	return res
end