require('hoi3.Hoi3Object')

CAIForeignMinisterObject = Hoi3Object:subclass('hoi3.CAIAgent')

---
-- @since 1.3
-- @return void
function CAIForeignMinisterObject:ClearWarProposal()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return void
function CAIForeignMinisterObject:ExecuteDiploDecisions()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinisterObject:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinisterObject:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CCountryTag
function CAIForeignMinisterObject:GetProposedWarTarget()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return unknown
function CAIForeignMinisterObject:PercOccupied(...)
	Hoi3Object.throwUnknownSignature()
end

---
-- @since 1.3
-- @param CDiplomaticAction  action
-- @param number score
-- @return void
function CAIForeignMinisterObject:Propose(action, score)
	Hoi3Object.assertParameterType(1, action, 'CDiplomaticAction')
	Hoi3Object.assertParameterType(2, score, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag  countryTag
-- @param number warDesirability
-- @return void
function CAIForeignMinisterObject:ProposeWar(countryTag, warDesirability)
	Hoi3Object.assertParameterType(1, countryTag, 'CCountryTag')
	Hoi3Object.assertParameterType(2, warDesirability, 'number')
	
	Hoi3Object.throwNotYetImplemented()
end