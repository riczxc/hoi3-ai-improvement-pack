require('hoi3.Hoi3Object')

CChangePriorityCommandObject = Hoi3Object:subclass('hoi3.CCommand')

---
-- @since 1.3
-- @return CChangeInvestmentCommandObject 
function CChangePriorityCommandObject:Clone()
	Hoi3Object.throwNotYetImplemented()
end

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CID cid
-- @param number priority
-- @return CChangePriorityCommandObject
function CChangePriorityCommand(actor, cid, priority)
	Hoi3Object.assertParameterType(1, actor, 'CCountryTag')
	Hoi3Object.assertParameterType(2, cid, 'CID')
	Hoi3Object.assertParameterType(3, priority, 'number')

	Hoi3Object.throwNotYetImplemented()
end