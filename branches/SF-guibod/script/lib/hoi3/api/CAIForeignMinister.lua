require('hoi3.Hoi3Object')

CAIForeignMinister = Hoi3Object:subclass('hoi3.CAIAgent')

---
-- @since 1.3
-- @return void
function CAIForeignMinister:ClearWarProposal()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CAIForeignMinister:ExecuteDiploDecisions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinister:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinister:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinister:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CAI
function CAIForeignMinister:GetOwnerAI()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CAIForeignMinister:PercOccupied(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CDiplomaticAction  action
-- @param number score
-- @return void
function CAIForeignMinister:Propose(action, score)
	Hoi3Object.assertParameterType(1, action, 'CDiplomaticAction')
	Hoi3Object.assertParameterType(2, score, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param number warDesirability
-- @return void
function CAIForeignMinister:ProposeWar(countryTag, warDesirability)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, warDesirability, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end