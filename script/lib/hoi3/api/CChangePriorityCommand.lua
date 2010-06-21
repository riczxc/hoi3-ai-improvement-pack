require('hoi3.api.CCommand')

CChangePriorityCommand = CCommand:subclass('hoi3.CChangePriorityCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CID cid
-- @param number priority
-- @return CChangePriorityCommand
function CChangePriorityCommand:initialize(actor, cid, priority)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, cid, 'CID')
	Hoi3Object.assertParameterType(3, priority, 'number')

	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CChangePriorityCommand:Clone()
	Hoi3Object.throwNotYetImplemented()
end

