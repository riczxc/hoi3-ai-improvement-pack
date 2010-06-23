require('hoi3.api.CAIAgent')

module("hoi3.api", package.seeall)

CAIForeignMinister = CAIAgent:subclass('hoi3.CAIForeignMinister')

---
-- @since 1.3
-- @return void
function CAIForeignMinister:ClearWarProposal()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CAIForeignMinister:ExecuteDiploDecisions()
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinister:GetProposedWarTarget()
	return self:loadResultOrImplOrRandom(
		'CCountryTag',
		'GetProposedWarTarget'
	)
end

---
-- @since 1.3
-- @return unknown
function CAIForeignMinister:PercOccupied(...)
	hoi3.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CDiplomaticAction  action
-- @param number score
-- @return void
function CAIForeignMinister:Propose(action, score)
	hoi3.assertParameterType(1, action, 'CDiplomaticAction')
	hoi3.assertParameterType(2, score, 'number')
	
	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param number warDesirability
-- @return void
function CAIForeignMinister:ProposeWar(countryTag, warDesirability)
	hoi3.assertParameterType(1, countryTag, 'CCountryTag')
	hoi3.assertParameterType(2, warDesirability, 'number')
	
	hoi3.throwNotYetImplemented()
end