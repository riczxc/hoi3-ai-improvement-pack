require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangePriorityCommand = CCommand:subclass('hoi3.CChangePriorityCommand')

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CID cid
-- @param number priority
-- @return CChangePriorityCommand
function CChangePriorityCommand:initialize(actor, cid, priority)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, actor, 'CCountryTag')
	hoi3.assertParameterType(2, cid, 'CID')
	hoi3.assertParameterType(3, priority, hoi3.TYPE_NUMBER)

	hoi3.throwNotYetImplemented()
end

---
-- @since 1.3
-- @return CChangeInvestmentCommand 
function CChangePriorityCommand:Clone()
	hoi3.assertNonStatic(self)
	hoi3.throwNotYetImplemented()
end

