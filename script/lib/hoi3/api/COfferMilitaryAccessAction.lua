require('hoi3.api.CDiplomaticAction')

module("hoi3.api", package.seeall)

COfferMilitaryAccessAction = CDiplomaticAction:subclass('hoi3.api.COfferMilitaryAccessAction')

-- Constructor signature
-- information only, that will be used by documentation generator.
COfferMilitaryAccessAction.constructorSignature = {'CCountryTag','CCountryTag'}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @return COfferMilitaryAccessAction
function COfferMilitaryAccessAction:initialize(tag, target)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')

	self.tag = tag
	self.target = target
end

function COfferMilitaryAccessAction:desc()
	return tostring(self.tag).." asks "..tostring(self.target).. " military access."
end