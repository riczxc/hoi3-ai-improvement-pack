require('hoi3.api.CCommand')

module("hoi3.api", package.seeall)

CChangeLeadershipCommand = CCommand:subclass('hoi3.api.CChangeLeadershipCommand')

-- Constructor signature
-- information only, that will be used by documentation generator.
CChangeLeadershipCommand.constructorSignature = {'CCountryTag',hoi3.TYPE_NUMBER,hoi3.TYPE_NUMBER,hoi3.TYPE_NUMBER,hoi3.TYPE_NUMBER}

---
-- @since 1.3
-- @param CCountryTag actor
-- @param CFixedPoint change1
-- @param CFixedPoint change2
-- @param CFixedPoint change3
-- @param CFixedPoint change4
-- @return CChangeInvestmentCommand
function CChangeLeadershipCommand:initialize(tag, change1, change2, change3, change4)
	hoi3.assertNonStatic(self)
	hoi3.assertParameterType(1, tag, 'CCountryTag')
	hoi3.assertParameterType(2, change1, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(3, change2, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(4, change3, hoi3.TYPE_NUMBER)
	hoi3.assertParameterType(5, change4, hoi3.TYPE_NUMBER)

	self.tag = tag
	self.changes = {change1, change2, change3, change4}
end

function CChangeLeadershipCommand:desc()
	local str = "Changed leadership by "..tostring(self.tag).."."
	
	for i,v in ipairs(self.changes) do
		str = str .. " #"..i.."="..v
	end
	
	return str
end