require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeSpyPriority = CCommand:subclass('hoi3.CChangeSpyPriority')

---
-- @since 1.3
-- @param CCountryTag tag
-- @param CCountryTag target
-- @param number mission
-- @return CChangeSpyPriority
function CChangeSpyPriority:initialize(tag, target, priority)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, target, 'CCountryTag')
	hoi3.assertParameterType(3, priority, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.target = target
	self.priority = priority
end

function CChangeSpyPriority:desc()
	return "Spy priority changed toward "..tostring(self.target).." to "..
		tostring(self.priority)..
		" by "..tostring(self.tag).."."
end