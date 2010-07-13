require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangePriorityCommand = CCommand:subclass('hoi3.api.CChangePriorityCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CChangePriorityCommand.constructorSignature = {'CCountryTag','CID',hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CID cid
-- @param number priority
-- @return CChangePriorityCommand
function CChangePriorityCommand:initialize(tag, cid, priority)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, cid, 'CID')
	hoi3.assertParameterType(3, priority, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.cid = cid
	self.priority = priority
end

hoi3.f(CChangePriorityCommand, 'Clone', hoi3.TYPE_UNKNOWN)

function CChangePriorityCommand:desc()
	return "Unit construction "..tostring(self.cid).." priority " ..
			"changed to "..tostring(self.priority).." "..
			"by "..tostring(self.tag).."."
end