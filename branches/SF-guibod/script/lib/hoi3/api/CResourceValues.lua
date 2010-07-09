require('hoi3')

module("hoi3.api", package.seeall)

CResourceValues = hoi3.Hoi3Object:subclass('hoi3.api.CResourceValues')

-- Constructor signature
-- information only, that will be used by documentation generator.
CResourceValues.constructorSignature = {}
CResourceValues.properties = {
	vDailyBalance 	= { "read/write", hoi3.TYPE_NUMBER },
	vDailyExpense 	= { "read/write", hoi3.TYPE_NUMBER },
	vDailyHome 		= { "read/write", hoi3.TYPE_NUMBER },
	vDailyIncome 	= { "read/write", hoi3.TYPE_NUMBER },
	vPool 			= { "read/write", hoi3.TYPE_NUMBER },
	vConvoyedIn 	= { "read/write", hoi3.TYPE_NUMBER }
}

function CResourceValues:initialize()
	self.vDailyBalance = 0
	self.vDailyExpense = 0	
	self.vDailyHome = 0
	self.vDailyIncome = 0
	self.vPool = 0
	self.vConvoyedIn = 0
end

---
-- @since 2.0
-- @param CCountry
-- @param number goodstype
-- @return table 
hoi3.f(CResourceValues, 'GetResourceValues', hoi3.TYPE_VOID, 'CCountry', hoi3.TYPE_NUMBER)

function CResourceValues:GetResourceValuesImpl(country, goodtype)
	self.vDailyBalance = country:GetDailyBalance(goodtype):Get()
	self.vDailyExpense = country:GetDailyExpense(goodtype):Get()
	self.vDailyHome = country:GetHomeProduced():Get(goodtype):Get()
	self.vDailyIncome = country:GetDailyIncome(goodtype):Get()
	self.vPool = country:GetPool():Get(goodtype):Get()
	self.vConvoyedIn = country:GetConvoyedIn():Get(goodtype):Get()
end